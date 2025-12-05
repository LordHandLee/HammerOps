import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:jose/jose.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../server_database.dart';

class AuthRoutes {
  final AppServerDatabase db;
  late final JwtSigner _signer;
  late final String secret;

  AuthRoutes(this.db) {
    // Demo signer; replace with env secret/keys.
    secret = Platform.environment['JWT_SECRET'] ?? 'dev-secret-change-me';
    _signer = JwtSigner.withHmacSha256(secret.codeUnits);
  }

  Router get router {
    final r = Router();
    r.post('/signup', _signup);
    r.post('/login', _login);
    r.post('/refresh', _refresh);
    return r;
  }

  Future<Response> _signup(Request req) async {
    final body = await req.readAsString();
    final data = jsonDecode(body) as Map<String, dynamic>;
    final email = (data['email'] as String?)?.trim();
    final password = data['password'] as String?;
    final companyName = (data['companyName'] as String?)?.trim();

    if (email == null ||
        password == null ||
        email.isEmpty ||
        password.isEmpty) {
      return Response(400, body: 'email and password required');
    }

    final salt = _generateSalt();
    final hash = _hashPassword(password, salt);

    return db.transaction(() async {
      final existing = await (db.select(
        db.accounts,
      )..where((a) => a.email.equals(email))).getSingleOrNull();
      if (existing != null) {
        return Response(409, body: 'email already exists');
      }

      final accountId = await db
          .into(db.accounts)
          .insert(
            AccountsCompanion.insert(
              email: email,
              passwordHash: hash,
              passwordSalt: salt,
            ),
          );

      int? companyId;
      if (companyName != null && companyName.isNotEmpty) {
        companyId = await db
            .into(db.company)
            .insert(
              CompanyCompanion.insert(
                name: companyName,
                adminAccountId: accountId,
              ),
            );
        await db
            .into(db.companyMembers)
            .insert(
              CompanyMembersCompanion.insert(
                companyId: companyId,
                accountId: accountId,
                role: 'admin',
              ),
            );
      }

      final session = await _createRefreshSession(
        accountId,
        companyId: companyId,
      );
      final tokens = _issueTokens(
        accountId,
        session.refreshToken,
        companyId: companyId,
        refreshSessionId: session.sessionId,
      );
      return Response.ok(
        jsonEncode(tokens),
        headers: {'content-type': 'application/json'},
      );
    });
  }

  Future<Response> _login(Request req) async {
    final body = await req.readAsString();
    final data = jsonDecode(body) as Map<String, dynamic>;
    final email = (data['email'] as String?)?.trim();
    final password = data['password'] as String?;

    if (email == null ||
        password == null ||
        email.isEmpty ||
        password.isEmpty) {
      return Response(400, body: 'email and password required');
    }

    final account = await (db.select(
      db.accounts,
    )..where((a) => a.email.equals(email))).getSingleOrNull();
    if (account == null) {
      return Response(401, body: 'invalid credentials');
    }

    final salt = account.passwordSalt;
    final computed = salt == null ? null : _hashPassword(password, salt);
    if (computed == null || computed != account.passwordHash) {
      return Response(401, body: 'invalid credentials');
    }

    await (db.update(db.accounts)..where((a) => a.id.equals(account.id))).write(
      AccountsCompanion(
        lastSeen: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ),
    );

    // Load company membership (first membership, if any)
    final member = await (db.select(
      db.companyMembers,
    )..where((m) => m.accountId.equals(account.id))).getSingleOrNull();
    final session = await _createRefreshSession(
      account.id,
      companyId: member?.companyId,
    );
    final tokens = _issueTokens(
      account.id,
      session.refreshToken,
      companyId: member?.companyId,
      refreshSessionId: session.sessionId,
    );

    return Response.ok(
      jsonEncode(tokens),
      headers: {'content-type': 'application/json'},
    );
  }

  Future<Response> _refresh(Request req) async {
    final body = await req.readAsString();
    final data = jsonDecode(body) as Map<String, dynamic>;
    final refreshToken = data['refreshToken'] as String?;

    if (refreshToken == null || refreshToken.isEmpty) {
      return Response(400, body: 'refreshToken required');
    }

    try {
      final keyStore = JsonWebKeyStore()
        ..addKey(
          JsonWebKey.fromJson({
            'kty': 'oct',
            'k': base64Url.encode(secret.codeUnits),
            'alg': 'HS256',
          }),
        );

      final jws = JsonWebSignature.fromCompactSerialization(refreshToken);
      final verified = await jws.verify(keyStore);
      final payload =
          jsonDecode(utf8.decode(verified.unverifiedPayload))
              as Map<String, dynamic>;
      if (payload['type'] != 'refresh') {
        return Response(401, body: 'Invalid token type');
      }
      final exp = payload['exp'] as int?;
      final accountId = payload['sub'] as int?;
      final companyId = payload['companyId'] as int?;
      if (exp == null || accountId == null) {
        return Response(401, body: 'Invalid token');
      }
      if (DateTime.fromMillisecondsSinceEpoch(
        exp * 1000,
      ).isBefore(DateTime.now())) {
        return Response(401, body: 'Token expired');
      }

      final hash = sha256.convert(utf8.encode(refreshToken)).toString();
      final session =
          await (db.select(db.accountSessions)
                ..where((s) => s.accountId.equals(accountId))
                ..where((s) => s.refreshTokenHash.equals(hash))
                ..where((s) => s.revokedAt.isNull())
                ..where((s) => s.expiresAt.isBiggerThanValue(DateTime.now())))
              .getSingleOrNull();

      if (session == null) {
        return Response(401, body: 'Invalid or revoked session');
      }

      // Rotate session
      await (db.update(db.accountSessions)
            ..where((s) => s.id.equals(session.id)))
          .write(AccountSessionsCompanion(revokedAt: Value(DateTime.now())));

      final newSession = await _createRefreshSession(
        accountId,
        companyId: companyId,
      );
      final tokens = _issueTokens(
        accountId,
        newSession.refreshToken,
        companyId: companyId,
        refreshSessionId: newSession.sessionId,
      );
      return Response.ok(
        jsonEncode(tokens),
        headers: {'content-type': 'application/json'},
      );
    } catch (_) {
      return Response(401, body: 'Invalid token');
    }
  }

  Map<String, dynamic> _issueTokens(
    int accountId,
    String refreshToken, {
    int? companyId,
    int? refreshSessionId,
  }) {
    final access = JsonWebSignatureBuilder()
      ..jsonContent = {
        'sub': accountId,
        'companyId': companyId,
        'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000,
        'exp':
            DateTime.now()
                .add(const Duration(minutes: 15))
                .millisecondsSinceEpoch ~/
            1000,
      }
      ..addRecipient(_signer);

    return {
      'accessToken': access.build().toCompactSerialization(),
      'refreshToken': refreshToken,
      'accountId': accountId,
      'companyId': companyId,
      'refreshSessionId': refreshSessionId,
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
        'exp':
            DateTime.now()
                .add(const Duration(days: 30))
                .millisecondsSinceEpoch ~/
            1000,
        'type': 'refresh',
      }
      ..addRecipient(_signer);

    final refresh = refreshBuilder.build().toCompactSerialization();
    final hash = sha256.convert(utf8.encode(refresh)).toString();
    final exp = DateTime.now().add(const Duration(days: 30));

    final sessionId = await db
        .into(db.accountSessions)
        .insert(
          AccountSessionsCompanion.insert(
            accountId: accountId,
            refreshTokenHash: hash,
            expiresAt: exp,
          ),
        );

    return _RefreshSession(refresh, sessionId);
  }

  String _generateSalt({int length = 16}) {
    final bytes = List<int>.generate(
      length,
      (i) => Random.secure().nextInt(256),
    );
    return base64Encode(bytes);
  }

  String _hashPassword(
    String password,
    String saltBase64, {
    int iterations = 100000,
    int keyLength = 32,
  }) {
    final salt = base64Decode(saltBase64);
    final derived = _pbkdf2(
      password,
      salt,
      iterations: iterations,
      keyLength: keyLength,
    );
    return base64Encode(derived);
  }

  List<int> _pbkdf2(
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
    return derived.sublist(0, keyLength);
  }

  List<int> _int32BigEndian(int i) => [
    (i >> 24) & 0xff,
    (i >> 16) & 0xff,
    (i >> 8) & 0xff,
    i & 0xff,
  ];
}

class _RefreshSession {
  final String refreshToken;
  final int sessionId;

  _RefreshSession(this.refreshToken, this.sessionId);
}
