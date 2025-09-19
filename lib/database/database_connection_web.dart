// lib/database/database_connection_web.dart
import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:sqlite3/wasm.dart';
// import 'package:http/http.dart' as http;

Future<QueryExecutor> openConnection() async {
  final uri = Uri.parse('https://unpkg.com/sql.js@1.10.3/dist/sql-wasm.wasm');
  final sqlite3 = await WasmSqlite3.loadFromUrl(uri);
  return WasmDatabase.inMemory(sqlite3);
}