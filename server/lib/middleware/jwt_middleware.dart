import 'dart:convert';

import 'package:jose/jose.dart';
import 'package:shelf/shelf.dart';

Middleware jwtMiddleware(String secret) {
  final keyStore = JsonWebKeyStore()
    ..addKey(
      JsonWebKey.fromJson({
        'kty': 'oct',
        'k': base64Url.encode(secret.codeUnits),
        'alg': 'HS256',
      }),
    );

  return (innerHandler) {
    return (Request req) async {
      final header = req.headers['authorization'];
      if (header == null || !header.toLowerCase().startsWith('bearer ')) {
        return Response(401, body: 'Missing bearer token');
      }

      final token = header.substring(7).trim();
      try {
        final jwt = JsonWebToken.unverified(token);
        final ok = await jwt.verify(keyStore);
        if (!ok) return Response(401, body: 'Invalid token');

        final payload = jwt.claims.toJson();
        final exp = payload['exp'] as int?;
        if (exp == null ||
            DateTime.fromMillisecondsSinceEpoch(exp * 1000)
                .isBefore(DateTime.now())) {
          return Response(401, body: 'Token expired');
        }
        final updatedContext = req.context['auth'] is Map<String, dynamic>
            ? Map<String, dynamic>.from(req.context['auth'] as Map<String, dynamic>)
            : <String, dynamic>{};
        updatedContext['accountId'] = payload['sub'];
        updatedContext['companyId'] = payload['companyId'];
        final authed = req.change(context: {'auth': updatedContext});
        return innerHandler(authed);
      } catch (_) {
        return Response(401, body: 'Invalid token');
      }
    };
  };
}
