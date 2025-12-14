import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

import 'package:hammer_ops_server/routes/auth_routes.dart';
import 'package:hammer_ops_server/routes/sync_routes.dart';
import 'package:hammer_ops_server/server_database.dart';
import 'package:hammer_ops_server/middleware/jwt_middleware.dart';

Future<void> main(List<String> args) async {
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final dbPath = Platform.environment['DB_PATH'];

  final db = await AppServerDatabase.open(dbPath);
  final auth = AuthRoutes(db);
  final sync = SyncRoutes(db);

  final router = Router()
    ..get('/health', (Request req) => Response.ok('ok'))
    ..mount('/auth/', auth.router)
    ..mount(
      '/sync/',
      Pipeline()
          .addMiddleware(jwtMiddleware(auth.secret))
          .addHandler(sync.router),
    );

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(corsHeaders())
      .addHandler(router);

  final server = await serve(handler, InternetAddress.anyIPv4, port);
  stdout.writeln('Server running on port ${server.port}');
}
