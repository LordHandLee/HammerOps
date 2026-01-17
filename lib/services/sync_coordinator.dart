import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:hammer_ops/database/database.dart';
import 'package:drift/drift.dart';
import 'sync_service.dart';

class SyncCoordinator {
  SyncCoordinator(this.db, this.localChanges, this.syncService);

  final AppDatabase db;
  final LocalChangeDao localChanges;
  final SyncService syncService;

  static const _kServerVersion = 'serverVersion';

  Future<int> _loadServerVersion() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kServerVersion) ?? 0;
  }

  Future<void> _saveServerVersion(int version) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kServerVersion, version);
  }

  Future<void> queueUpsert(String table, Map<String, dynamic> row) =>
      localChanges.queueUpsert(table, row);

  Future<void> queueDelete(String table, dynamic id) =>
      localChanges.queueDelete(table, id);

  /// Push pending changes and pull new data. Returns pull payload for caller to apply.
  Future<Map<String, dynamic>> sync() async {
    final pending = await localChanges.pending();
    if (pending.isNotEmpty) {
      final grouped = <String, Map<String, dynamic>>{};
      for (final change in pending) {
        final table = change.targetTable;
        grouped.putIfAbsent(table, () => {
              'table': table,
              'rows': <Map<String, dynamic>>[],
              'deletedIds': <dynamic>[],
            });
        final decoded = jsonDecode(change.payload);
        if (change.changeType == 'delete') {
          grouped[table]!['deletedIds'].add(decoded['id']);
        } else {
          grouped[table]!['rows'].add(decoded as Map<String, dynamic>);
        }
      }
      await syncService.push(grouped.values.toList());
      // Optional: inspect push response for conflicts
      await localChanges.clear();
    }

    final since = await _loadServerVersion();
    final pullRes = await syncService.pull(since);
    final tables = pullRes['tables'] as Map<String, dynamic>? ?? {};
    int maxVersion = since;
    for (final entry in tables.entries) {
      final tableName = entry.key;
      final rows = (entry.value as List).cast<Map<String, dynamic>>();
      final table = _tableForName(tableName);
      if (table == null) continue;

      for (final row in rows) {
        final version = row['version'] as int? ?? since;
        if (version > maxVersion) maxVersion = version;
        await db.into(table).insert(_toInsertable(row),
            mode: InsertMode.insertOrReplace);
      }
    }

    await _saveServerVersion(maxVersion);
    return pullRes;
  }

  TableInfo<Table, dynamic>? _tableForName(String name) {
    switch (name) {
      case 'accounts':
        return db.accounts;
      case 'account_sessions':
        return db.accountSessions;
      case 'company':
        return db.company;
      case 'company_members':
        return db.companyMembers;
      case 'users':
        return db.users;
      case 'templates':
        return db.templates;
      case 'template_fields':
        return db.templateFields;
      case 'job_quotes':
        return db.jobQuotes;
      case 'quote_field_values':
        return db.quoteFieldValues;
      case 'jobs':
        return db.jobs;
      case 'customers':
        return db.customers;
      case 'tools':
        return db.tools;
      case 'tasks':
        return db.tasks;
      case 'complaint':
        return db.complaint;
      case 'injury':
        return db.injury;
      case 'documents':
        return db.documents;
      case 'fleet_events':
        return db.fleetEvents;
      case 'checklist_templates':
        return db.checklistTemplates;
      case 'checklist_items':
        return db.checklistItems;
      case 'checklist_runs':
        return db.checklistRuns;
      case 'checklist_run_items':
        return db.checklistRunItems;
      default:
        return null;
    }
  }

  RawValuesInsertable _toInsertable(Map<String, dynamic> row) {
    final mapped = <String, Expression>{};
    for (final entry in row.entries) {
      mapped[entry.key] = Variable(entry.value);
    }
    return RawValuesInsertable(mapped);
  }
}
