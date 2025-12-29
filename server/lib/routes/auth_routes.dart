import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:jose/jose.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:http/http.dart' as http;

import '../server_database.dart';

class AuthRoutes {
  final AppServerDatabase db;
  final String secret;
  final JsonWebKey _hmacKey;

  AuthRoutes(this.db)
      : secret = Platform.environment['JWT_SECRET'] ?? 'dev-secret-change-me',
        _hmacKey = JsonWebKey.fromJson({
          'kty': 'oct',
          'k': base64Url.encode(
            (Platform.environment['JWT_SECRET'] ?? 'dev-secret-change-me')
                .codeUnits,
          ),
          'alg': 'HS256',
        });

  Router get router {
    final r = Router();
    r.post('/signup', _signup);
    r.post('/login', _login);
    r.post('/refresh', _refresh);
    r.get('/verify', _verify);
    return r;
  }

  Future<Response> _signup(Request req) async {
    final body = await req.readAsString();
    final data = jsonDecode(body) as Map<String, dynamic>;
    final email = (data['email'] as String?)?.trim();
    final password = data['password'] as String?;
    final companyName = (data['companyName'] as String?)?.trim();

    if (email == null || password == null || email.isEmpty || password.isEmpty) {
      return Response(400, body: 'email and password required');
    }

    final salt = _generateSalt();
    final hash = _hashPassword(password, salt);

    return db.transaction(() async {
      final existing = await (db.select(db.accounts)
            ..where((a) => a.email.equals(email)))
          .getSingleOrNull();
      if (existing != null) {
        return Response(409, body: 'email already exists');
      }

      final accountId = await db.into(db.accounts).insert(
            AccountsCompanion.insert(
              email: email,
              passwordHash: hash,
              passwordSalt: Value(salt),
            ),
          );

      int? companyId;
      if (companyName != null && companyName.isNotEmpty) {
        companyId = await db.into(db.company).insert(
              CompanyCompanion.insert(
                name: companyName,
                adminAccountId: accountId,
              ),
            );
        await db.into(db.companyMembers).insert(
              CompanyMembersCompanion.insert(
                companyId: companyId,
                accountId: accountId,
                role: 'admin',
              ),
            );
      }

      await _sendVerificationEmail(accountId, email);
      return Response(
        202,
        body:
            'Account created. Please check your email to verify before logging in.',
      );
    });
  }

  Future<Response> _login(Request req) async {
    final body = await req.readAsString();
    final data = jsonDecode(body) as Map<String, dynamic>;
    final email = (data['email'] as String?)?.trim();
    final password = data['password'] as String?;

    if (email == null || password == null || email.isEmpty || password.isEmpty) {
      return Response(400, body: 'email and password required');
    }

    final account = await (db.select(db.accounts)
          ..where((a) => a.email.equals(email)))
        .getSingleOrNull();
    if (account == null) {
      return Response(401, body: 'invalid credentials');
    }

    final salt = account.passwordSalt;
    final computed = salt == null ? null : _hashPassword(password, salt);
    if (computed == null || computed != account.passwordHash) {
      return Response(401, body: 'invalid credentials');
    }

    if (account.isEmailVerified != true) {
      return Response(403, body: 'email not verified');
    }

    await (db.update(db.accounts)..where((a) => a.id.equals(account.id))).write(
      AccountsCompanion(
        lastSeen: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ),
    );

    final member = await (db.select(db.companyMembers)
          ..where((m) => m.accountId.equals(account.id)))
        .getSingleOrNull();
    final session =
        await _createRefreshSession(account.id, companyId: member?.companyId);
    final tokens = _issueTokens(
      account.id,
      session.refreshToken,
      companyId: member?.companyId,
      refreshSessionId: session.sessionId,
      isEmailVerified: true,
    );

    return Response.ok(jsonEncode(tokens), headers: {'content-type': 'application/json'});
  }

  Future<Response> _verify(Request req) async {
    final code = req.url.queryParameters['code'];
    if (code == null || code.isEmpty) {
      return Response(400, body: 'code required');
    }

    final now = DateTime.now();
    final record = await (db.select(db.emailVerifications)
          ..where((v) => v.code.equals(code))
          ..where((v) => v.usedAt.isNull())
          ..where((v) => v.expiresAt.isBiggerThanValue(now)))
        .getSingleOrNull();

    if (record == null) return Response(400, body: 'invalid or expired code');

    await db.transaction(() async {
      await (db.update(db.emailVerifications)..where((v) => v.id.equals(record.id)))
          .write(EmailVerificationsCompanion(usedAt: Value(now)));
      await (db.update(db.accounts)..where((a) => a.id.equals(record.accountId)))
          .write(const AccountsCompanion(isEmailVerified: Value(true)));
    });

    return Response.ok('Email verified');
  }

  Future<Response> _refresh(Request req) async {
    final body = await req.readAsString();
    final data = jsonDecode(body) as Map<String, dynamic>;
    final refreshToken = data['refreshToken'] as String?;

    if (refreshToken == null || refreshToken.isEmpty) {
      return Response(400, body: 'refreshToken required');
    }

    try {
      final keyStore = JsonWebKeyStore()..addKey(_hmacKey);
      final jwt = JsonWebToken.unverified(refreshToken);
      final ok = await jwt.verify(keyStore);
      if (!ok) return Response(401, body: 'Invalid token');
      final payload = jwt.claims.toJson();
      if (payload['type'] != 'refresh') {
        return Response(401, body: 'Invalid token type');
      }
      final exp = payload['exp'] as int?;
      final accountId = payload['sub'] as int?;
      final companyId = payload['companyId'] as int?;
      if (exp == null || accountId == null) {
        return Response(401, body: 'Invalid token');
      }
      if (DateTime.fromMillisecondsSinceEpoch(exp * 1000)
          .isBefore(DateTime.now())) {
        return Response(401, body: 'Token expired');
      }

      final hash = sha256.convert(utf8.encode(refreshToken)).toString();
      final session = await (db.select(db.accountSessions)
            ..where((s) => s.accountId.equals(accountId))
            ..where((s) => s.refreshTokenHash.equals(hash))
            ..where((s) => s.revokedAt.isNull())
            ..where((s) => s.expiresAt.isBiggerThanValue(DateTime.now())))
          .getSingleOrNull();

      if (session == null) {
        return Response(401, body: 'Invalid or revoked session');
      }

      final account =
          await (db.select(db.accounts)..where((a) => a.id.equals(accountId)))
              .getSingle();
      if (account.isEmailVerified != true) {
        return Response(403, body: 'email not verified');
      }

      await (db.update(db.accountSessions)..where((s) => s.id.equals(session.id)))
          .write(AccountSessionsCompanion(revokedAt: Value(DateTime.now())));

      final newSession = await _createRefreshSession(accountId, companyId: companyId);
      final tokens = _issueTokens(
        accountId,
        newSession.refreshToken,
        companyId: companyId,
        refreshSessionId: newSession.sessionId,
        isEmailVerified: true,
      );
      return Response.ok(jsonEncode(tokens), headers: {'content-type': 'application/json'});
    } catch (_) {
      return Response(401, body: 'Invalid token');
    }
  }

  Map<String, dynamic> _issueTokens(
    int accountId,
    String refreshToken, {
    int? companyId,
    int? refreshSessionId,
    bool isEmailVerified = true,
  }) {
    final accessBuilder = JsonWebSignatureBuilder()
      ..jsonContent = {
        'sub': accountId,
        'companyId': companyId,
        'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000,
        'exp': DateTime.now().add(const Duration(minutes: 15)).millisecondsSinceEpoch ~/ 1000,
      }
      ..addRecipient(_hmacKey, algorithm: 'HS256');

    return {
      'accessToken': accessBuilder.build().toCompactSerialization(),
      'refreshToken': refreshToken,
      'accountId': accountId,
      'companyId': companyId,
      'refreshSessionId': refreshSessionId,
      'isEmailVerified': isEmailVerified,
    };
  }

  Future<_RefreshSession> _createRefreshSession(
    int accountId, {
    int? companyId,
  }) async {
    final refreshBuilder = JsonWebSignatureBuilder()
      ..jsonContent = {
        'sub': accountId,
        'companyId': companyId,
        'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000,
        'exp': DateTime.now().add(const Duration(days: 30)).millisecondsSinceEpoch ~/ 1000,
        'type': 'refresh',
      }
      ..addRecipient(_hmacKey, algorithm: 'HS256');

    final refresh = refreshBuilder.build().toCompactSerialization();
    final hash = sha256.convert(utf8.encode(refresh)).toString();
    final exp = DateTime.now().add(const Duration(days: 30));

    final sessionId = await db.into(db.accountSessions).insert(
          AccountSessionsCompanion.insert(
            accountId: accountId,
            refreshTokenHash: hash,
            expiresAt: exp,
          ),
        );

    return _RefreshSession(refresh, sessionId);
  }

  String _generateSalt({int length = 16}) {
    final random = Random.secure();
    final bytes = List<int>.generate(length, (_) => random.nextInt(256));
    return base64Encode(bytes);
  }

  String _hashPassword(String password, String saltBase64,
      {int iterations = 100000, int keyLength = 32}) {
    final salt = base64Decode(saltBase64);
    final derived = _pbkdf2(password, salt,
        iterations: iterations, keyLength: keyLength);
    return base64Encode(derived);
  }

  Uint8List _pbkdf2(
    String password,
    List<int> salt, {
    int iterations = 100000,
    int keyLength = 32,
  }) {
    final hmac = Hmac(sha256, utf8.encode(password));
    final hashLength = hmac.convert(<int>[]).bytes.length;
    final blockCount = (keyLength + hashLength - 1) ~/ hashLength;
    final output = BytesBuilder();

    for (var blockIndex = 1; blockIndex <= blockCount; blockIndex++) {
      final blockInput = Uint8List.fromList([
        ...salt,
        ..._int32BigEndian(blockIndex),
      ]);

      var u = hmac.convert(blockInput).bytes;
      final t = Uint8List.fromList(u);

      for (var i = 1; i < iterations; i++) {
        u = hmac.convert(u).bytes;
        for (var j = 0; j < t.length; j++) {
          t[j] ^= u[j];
        }
      }

      output.add(t);
    }

    final derived = output.takeBytes();
    return Uint8List.fromList(derived.sublist(0, keyLength));
  }

  List<int> _int32BigEndian(int i) => [
        (i >> 24) & 0xff,
        (i >> 16) & 0xff,
        (i >> 8) & 0xff,
        i & 0xff,
      ];

  Future<void> _sendVerificationEmail(int accountId, String email) async {
    final code = _generateSalt(length: 32);
    final expires = DateTime.now().add(const Duration(hours: 2));

    await db.into(db.emailVerifications).insert(
          EmailVerificationsCompanion.insert(
            accountId: accountId,
            code: code,
            expiresAt: expires,
          ),
        );

    final verifyBase = Platform.environment['VERIFY_BASE_URL'] ?? 'http://localhost:8080';
    final link = '$verifyBase/auth/verify?code=$code';

    // Prefer Mailgun HTTP API if configured
    final mgKey = Platform.environment['MAILGUN_API_KEY']; //re_7nrJVnqf_NAwrizyDPa2USE1CnGWtYzn3 resend api
    final mgDomain = Platform.environment['MAILGUN_DOMAIN'];
    final mgFrom =
        Platform.environment['MAILGUN_FROM'] ?? Platform.environment['SMTP_FROM'] ?? 'no-reply@$mgDomain';
    if (mgKey != null && mgDomain != null) {
      final uri = Uri.https('$mgDomain', '/emails');
      final auth = 'api:$mgKey';
      try {
        final resp = await http.post(
          uri,
          headers: {
            // 'Authorization': 'Bearer ${base64Encode(utf8.encode(auth))}',
            'Authorization': 'Bearer ${auth}',
          },
          body: {
            'from': mgFrom ?? 'no-reply@$mgDomain',
            'to': email,
            'subject': 'Verify your Hammer Ops email',
            'text': 'Click to verify: $link',
          },
        );
        if (resp.statusCode >= 200 && resp.statusCode < 300) {
          stderr.writeln('Verification email sent via Mailgun to $email');
          return;
        } else {
          stderr.writeln('Mailgun send failed (${resp.statusCode}): ${resp.body}');
        }
      } catch (e, st) {
        stderr.writeln('Mailgun send error to $email: $e\n$st');
      }
    }

    // Fallback to SMTP
    final host = Platform.environment['SMTP_HOST'];
    final port = int.tryParse(Platform.environment['SMTP_PORT'] ?? '587') ?? 587;
    final user = Platform.environment['SMTP_USER'];
    final pass = Platform.environment['SMTP_PASS'];
    final from = Platform.environment['SMTP_FROM'] ?? user;

    if (host == null || user == null || pass == null) {
      stderr.writeln('SMTP not configured; skipping verification email for $email');
      return;
    }

    final smtp = SmtpServer(
      host,
      port: port,
      username: user,
      password: pass,
      ssl: port == 465,
      allowInsecure: port == 587, // STARTTLS upgrade
    );
    final message = Message()
      ..from = Address(from!)
      ..recipients.add(email)
      ..subject = 'Verify your Hammer Ops email'
      ..text = 'Click to verify: $link';

    try {
      await send(message, smtp);
      stderr.writeln('Verification email sent to $email');
    } catch (e, st) {
      stderr.writeln('Failed to send verification email to $email: $e\n$st');
    }
  }
}

class _RefreshSession {
  final String refreshToken;
  final int sessionId;

  _RefreshSession(this.refreshToken, this.sessionId);
}
