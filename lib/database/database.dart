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
  Injury, Document, FleetEvents, ChecklistTemplates, ChecklistItems, ChecklistRuns, ChecklistRunItems], 
  daos: [UserDao, TemplatesDao, JobQuotesDao, CompanyDao, JobsDao, CustomersDao, FleetEventDao, ChecklistDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  
}

// // Open DB file
// LazyDatabase _openConnection() {
//   return LazyDatabase(() async {
//     final dbFolder = await getApplicationDocumentsDirectory();
//     final file = File(p.join(dbFolder.path, 'app.sqlite'));
//     return NativeDatabase(file);
//   });
// }