import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../server_database.dart';

class SyncRoutes {
  final AppServerDatabase db;

  SyncRoutes(this.db);

  Router get router {
    final r = Router();
    r.post('/push', _push);
    r.get('/pull', _pull);
    return r;
  }

  // Minimal shape: expects { "changes": [ { "table": "users", "rows": [ {..}, ...], "deletedIds": [..] } ] }
  Future<Response> _push(Request req) async {
    final auth = req.context['auth'] as Map<String, dynamic>? ?? {};
    final accountId = auth['accountId'] as int?;
    final companyId = auth['companyId'] as int?;
    if (accountId == null || companyId == null) {
      return Response(403, body: 'Missing auth context');
    }

    final body = await req.readAsString();
    final data = jsonDecode(body) as Map<String, dynamic>;
    final changes = (data['changes'] as List?) ?? [];

    final conflicts = <Map<String, dynamic>>[];

    await db.transaction(() async {
      for (final change in changes.cast<Map<String, dynamic>>()) {
        final tableName = change['table'] as String?;
        if (tableName == null) continue;

        final table = _tableForName(tableName);
        if (table == null) continue;

        final rows = (change['rows'] as List?) ?? [];
        final deletedIds = (change['deletedIds'] as List?) ?? [];

        // Upserts
        for (final row in rows.cast<Map<String, dynamic>>()) {
          final incomingId = row['id'] ?? row['Id'] ?? row['ID'];
          if (incomingId == null) continue;
          final incomingVersion = row['version'] as int? ?? 0;
          final incomingCompanyId = _extractCompanyId(row);

          if (_hasCompanyColumn(table) && incomingCompanyId != companyId) {
            conflicts.add({
              'table': tableName,
              'id': incomingId,
              'reason': 'company_mismatch',
            });
            continue;
          }

          final existing =
              await (db.select(table)
                    ..where((tbl) => (tbl as dynamic).id.equals(incomingId)))
                  .getSingleOrNull();
          if (existing != null) {
            final existingVersion = (existing as dynamic).version as int? ?? 0;
            if (existingVersion >= incomingVersion) {
              conflicts.add({
                'table': tableName,
                'id': incomingId,
                'reason': 'stale_version',
                'serverVersion': existingVersion,
                'clientVersion': incomingVersion,
              });
              continue;
            }
          }

          await db.into(table).insert(
            _toInsertable(table, row),
            mode: InsertMode.insertOrReplace,
          );
        }

        // Soft deletes (expecting a deletedAt value in row or apply now)
        for (final id in deletedIds) {
          await (db.update(
            table,
          )..where((tbl) => (tbl as dynamic).id.equals(id))).write(
            RawValuesInsertable({'deleted_at': Variable(DateTime.now())}),
          );
        }
      }
    });

    return Response.ok(
      jsonEncode({'status': 'ok', 'conflicts': conflicts}),
      headers: {'content-type': 'application/json'},
    );
  }

  Future<Response> _pull(Request req) async {
    final auth = req.context['auth'] as Map<String, dynamic>? ?? {};
    final companyId = auth['companyId'] as int?;
    if (companyId == null) {
      return Response(403, body: 'Missing auth context');
    }

    final sinceVersion =
        int.tryParse(req.url.queryParameters['since'] ?? '0') ?? 0;
    final serializer = const ValueSerializer.defaults();

    final tables = <String, dynamic>{};
    for (final entry in _versionedTables.entries) {
      final table = entry.value;
      final query = db.select(table)
        ..where(
          (tbl) => (tbl as dynamic).version.isBiggerThanValue(sinceVersion),
        );

      if (_hasCompanyColumn(table)) {
        query.where((tbl) => (tbl as dynamic).companyId.equals(companyId));
      }

      final rows = await query.get();
      tables[entry.key] = rows
          .map((row) => (row as dynamic).toJson(serializer: serializer))
          .toList();
    }

    final changes = {'since': sinceVersion, 'tables': tables};
    return Response.ok(
      jsonEncode(changes),
      headers: {'content-type': 'application/json'},
    );
  }

  final Map<String, TableInfo<Table, dynamic>> _versionedTables = {};

  TableInfo<Table, dynamic>? _tableForName(String name) {
    if (_versionedTables.isEmpty) {
      _versionedTables.addAll({
        'accounts': db.accounts,
        'account_sessions': db.accountSessions,
        'company': db.company,
        'company_members': db.companyMembers,
        'users': db.users,
        'templates': db.templates,
        'template_fields': db.templateFields,
        'job_quotes': db.jobQuotes,
        'quote_field_values': db.quoteFieldValues,
        'jobs': db.jobs,
        'customers': db.customers,
        'tools': db.tools,
        'tasks': db.tasks,
        'complaint': db.complaint,
        'injury': db.injury,
        'document': db.document,
        'documents': db.document,
        'fleet_events': db.fleetEvents,
        'checklist_templates': db.checklistTemplates,
        'checklist_items': db.checklistItems,
        'checklist_runs': db.checklistRuns,
        'checklist_run_items': db.checklistRunItems,
      });
    }
    return _versionedTables[name];
  }

  RawValuesInsertable _toInsertable(
    TableInfo<Table, dynamic> table,
    Map<String, dynamic> row,
  ) {
    final mapped = <String, Expression>{};
    final knownColumns = {for (final c in table.$columns) c.$name: c};
    for (final entry in row.entries) {
      final resolvedKey = _resolveColumnKey(entry.key, knownColumns);
      if (resolvedKey == null) continue;
      final column = knownColumns[resolvedKey]!;
      final coerced = _coerceValue(column, entry.value);
      mapped[resolvedKey] = Variable(coerced);
    }
    return RawValuesInsertable(mapped);
  }

  String? _resolveColumnKey(
    String inputKey,
    Map<String, GeneratedColumn<dynamic>> knownColumns,
  ) {
    if (knownColumns.containsKey(inputKey)) return inputKey;
    final snake = _toSnakeCase(inputKey);
    if (knownColumns.containsKey(snake)) return snake;
    return null;
  }

  String _toSnakeCase(String value) {
    final buffer = StringBuffer();
    for (var i = 0; i < value.length; i++) {
      final ch = value[i];
      final isUpper = ch.toUpperCase() == ch && ch.toLowerCase() != ch;
      if (isUpper && i > 0) buffer.write('_');
      buffer.write(ch.toLowerCase());
    }
    return buffer.toString();
  }

  dynamic _coerceValue(GeneratedColumn<dynamic> column, dynamic value) {
    if (value == null) return null;

    if (column.type == DriftSqlType.dateTime) {
      if (value is DateTime) return value;
      if (value is String) {
        final parsed = DateTime.tryParse(value);
        if (parsed != null) return parsed;
      }
      if (value is int) {
        return DateTime.fromMillisecondsSinceEpoch(value);
      }
    }

    if (column.type == DriftSqlType.bool) {
      if (value is bool) return value;
      if (value is int) return value != 0;
      if (value is String) {
        final v = value.toLowerCase();
        if (v == 'true' || v == '1') return true;
        if (v == 'false' || v == '0') return false;
      }
    }

    if (column.type == DriftSqlType.int && value is String) {
      return int.tryParse(value) ?? value;
    }

    if (column.type == DriftSqlType.double && value is String) {
      return double.tryParse(value) ?? value;
    }

    return value;
  }

  bool _hasCompanyColumn(TableInfo<Table, dynamic> table) {
    return table.$columns.any(
      (c) => c.$name == 'companyId' || c.$name == 'company_id',
    );
  }

  int? _extractCompanyId(Map<String, dynamic> row) {
    final val = row['companyId'] ?? row['company_id'];
    if (val is int) return val;
    if (val is String) return int.tryParse(val);
    return null;
  }
}
