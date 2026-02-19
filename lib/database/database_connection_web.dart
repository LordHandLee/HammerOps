// lib/database/database_connection_web.dart
import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:sqlite3/wasm.dart';
// import 'package:http/http.dart' as http;

Future<QueryExecutor> openConnection() async {
  final wasmCandidates = <Uri>[
    Uri.parse('/assets/sqlite3.wasm'),
    Uri.parse('/assets/web/assets/sqlite3.wasm'),
    Uri.parse('/web/assets/sqlite3.wasm'),
  ];

  Object? lastError;
  WasmSqlite3? sqlite3;
  for (final candidate in wasmCandidates) {
    try {
      sqlite3 = await WasmSqlite3.loadFromUrl(candidate);
      break;
    } catch (e) {
      lastError = e;
    }
  }

  if (sqlite3 == null) {
    throw StateError(
      'Failed to load sqlite3.wasm from known paths: $wasmCandidates. '
      'Last error: $lastError',
    );
  }

  final fileSystem = await IndexedDbFileSystem.open(dbName: 'my_app');
  sqlite3.registerVirtualFileSystem(fileSystem, makeDefault: true);
  return WasmDatabase(sqlite3: sqlite3, path: 'app.db');
}
