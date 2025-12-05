// library hammer_ops.database;

import 'dart:io';
import 'package:drift/drift.dart';
// import 'package:drift/native.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as p;
import 'entities.dart';
// import 'database_connection.dart';
part 'DAO.dart';
// part 'DAO.dart';
part 'database.g.dart';



// ------------------
// DATABASE
// ------------------
@DriftDatabase(
  tables: [Users, Templates, TemplateFields, JobQuotes, QuoteFieldValues, Jobs, Customers, Company, Tools, Tasks, Complaint,
  Injury, Document, FleetEvents, ChecklistTemplates, ChecklistItems, ChecklistRuns, ChecklistRunItems, Accounts, AccountSessions, CompanyMembers], 
  daos: [
    UserDao,
    TemplatesDao,
    JobQuotesDao,
    CompanyDao,
    JobsDao,
    CustomersDao,
    FleetEventDao,
    ChecklistDao,
    AccountDao,
    AccountSessionDao,
    CompanyMemberDao,
  ])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        // Development reset: drop all tables and recreate to align with schema changes.
        onUpgrade: (m, from, to) async {
          for (final table in allTables) {
            await m.deleteTable(table.actualTableName);
          }
          await m.createAllTables();
        },
      );
  
}

// // Open DB file
// LazyDatabase _openConnection() {
//   return LazyDatabase(() async {
//     final dbFolder = await getApplicationDocumentsDirectory();
//     final file = File(p.join(dbFolder.path, 'app.sqlite'));
//     return NativeDatabase(file);
//   });
// }
