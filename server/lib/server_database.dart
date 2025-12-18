import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';
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
  AppServerDatabase(PgDatabase db) : super(db);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async => m.createAll(),
        // TODO: add onUpgrade steps when bumping schemaVersion in prod
      );

  static Future<AppServerDatabase> openFromUrl(String url) async {
    final uri = Uri.parse(url);
    final db = PgDatabase(
      connectionUri: uri,
      sslMode: SslMode.require,
      logStatements: false,
    );
    return AppServerDatabase(db);
  }
}
