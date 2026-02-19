import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:postgres/postgres.dart';
import 'schema/entities.dart';

part 'server_database.g.dart';

class EmailVerifications extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get accountId =>
      integer().references(Accounts, #id, onDelete: KeyAction.cascade)();
  TextColumn get code => text()();
  DateTimeColumn get expiresAt => dateTime()();
  DateTimeColumn get usedAt => dateTime().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
}

class Invites extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get companyId =>
      integer().references(Company, #id, onDelete: KeyAction.cascade)();
  IntColumn get invitedBy =>
      integer().nullable().references(Accounts, #id, onDelete: KeyAction.setNull)();
  TextColumn get email => text()();
  TextColumn get role =>
      text().withLength(min: 1, max: 20).withDefault(const Constant('user'))();
  TextColumn get code => text()();
  DateTimeColumn get expiresAt => dateTime()();
  DateTimeColumn get usedAt => dateTime().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
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
    Invites,
  ],
)
class AppServerDatabase extends _$AppServerDatabase {
  AppServerDatabase(PgDatabase db) : super(db);

  @override
  int get schemaVersion => 2;

  @override
  SqlDialect get dialect => SqlDialect.postgres;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(invites);
          }
        },
      );

  static Future<AppServerDatabase> openFromUrl(String url) async {
    final uri = Uri.parse(url);
    final userInfo = uri.userInfo.split(':');
    final username = userInfo.isNotEmpty ? userInfo.first : '';
    final password = userInfo.length > 1 ? userInfo[1] : '';

    final endpoint = Endpoint(
      host: uri.host,
      database: uri.pathSegments.isNotEmpty ? uri.pathSegments.first : 'postgres',
      username: username,
      password: password,
      port: uri.hasPort ? uri.port : 5432,
    );

    final settings = ConnectionSettings(sslMode: SslMode.require);

    final db = PgDatabase(
      endpoint: endpoint,
      settings: settings,
      logStatements: true,
    );
    return AppServerDatabase(db);
  }
}
