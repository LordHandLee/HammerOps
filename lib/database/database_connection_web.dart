// lib/database/database_connection_web.dart
import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:sqlite3/wasm.dart';
// import 'package:http/http.dart' as http;

Future<QueryExecutor> openConnection() async {
  print("web");
  // final uri = Uri.parse('https://unpkg.com/sql.js@1.10.3/dist/sql-wasm.wasm');
  final uri = Uri.parse('/web/assets/sqlite3.wasm');
  final sqlite3 = await WasmSqlite3.loadFromUrl(uri);
  final fileSystem = await IndexedDbFileSystem.open(dbName: 'my_app');
  sqlite3.registerVirtualFileSystem(fileSystem, makeDefault: true);
  // return sqlite3;
  return WasmDatabase(sqlite3: sqlite3, path: 'app.db');
}