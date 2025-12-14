import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'schema/entities.dart';

part 'server_database.g.dart';

class EmailVerifications extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get accountId =>
      integer().references(Accounts, #id, onDelete: KeyAction.cascade)();
  TextColumn get code => text()();
  DateTimeColumn get expiresAt => dateTime()();
  DateTimeColumn get usedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(
  tables: [
    Accounts,
    AccountSessions,
    Company,
    CompanyMembers,
    Users,
    Templates,
    TemplateFields,
    JobQuotes,
    QuoteFieldValues,
    Jobs,
    Customers,
    Tools,
    Tasks,
    Complaint,
    Injury,
    Document,
    FleetEvents,
    ChecklistTemplates,
    ChecklistItems,
    ChecklistRuns,
    ChecklistRunItems,
    EmailVerifications,
  ],
)
class AppServerDatabase extends _$AppServerDatabase {
  AppServerDatabase(super.e);

  @override
  int get schemaVersion => 1;

  static Future<AppServerDatabase> open(String? dbPath) async {
    final resolved =
        dbPath ?? p.join(Directory.current.path, 'data', 'server.sqlite');
    await Directory(p.dirname(resolved)).create(recursive: true);
    final executor = NativeDatabase(File(resolved));
    return AppServerDatabase(executor);
  }
}
