// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_database.dart';

// ignore_for_file: type=lint
class $EmailVerificationsTable extends EmailVerifications
    with TableInfo<$EmailVerificationsTable, EmailVerification> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmailVerificationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<int> accountId = GeneratedColumn<int>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
    'expires_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usedAtMeta = const VerificationMeta('usedAt');
  @override
  late final GeneratedColumn<DateTime> usedAt = GeneratedColumn<DateTime>(
    'used_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accountId,
    code,
    expiresAt,
    usedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'email_verifications';
  @override
  VerificationContext validateIntegrity(
    Insertable<EmailVerification> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    if (data.containsKey('used_at')) {
      context.handle(
        _usedAtMeta,
        usedAt.isAcceptableOrUnknown(data['used_at']!, _usedAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EmailVerification map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmailVerification(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}account_id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires_at'],
      )!,
      usedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}used_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $EmailVerificationsTable createAlias(String alias) {
    return $EmailVerificationsTable(attachedDatabase, alias);
  }
}

class EmailVerification extends DataClass
    implements Insertable<EmailVerification> {
  final int id;
  final int accountId;
  final String code;
  final DateTime expiresAt;
  final DateTime? usedAt;
  final DateTime createdAt;
  const EmailVerification({
    required this.id,
    required this.accountId,
    required this.code,
    required this.expiresAt,
    this.usedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['account_id'] = Variable<int>(accountId);
    map['code'] = Variable<String>(code);
    map['expires_at'] = Variable<DateTime>(expiresAt);
    if (!nullToAbsent || usedAt != null) {
      map['used_at'] = Variable<DateTime>(usedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  EmailVerificationsCompanion toCompanion(bool nullToAbsent) {
    return EmailVerificationsCompanion(
      id: Value(id),
      accountId: Value(accountId),
      code: Value(code),
      expiresAt: Value(expiresAt),
      usedAt: usedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(usedAt),
      createdAt: Value(createdAt),
    );
  }

  factory EmailVerification.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmailVerification(
      id: serializer.fromJson<int>(json['id']),
      accountId: serializer.fromJson<int>(json['accountId']),
      code: serializer.fromJson<String>(json['code']),
      expiresAt: serializer.fromJson<DateTime>(json['expiresAt']),
      usedAt: serializer.fromJson<DateTime?>(json['usedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'accountId': serializer.toJson<int>(accountId),
      'code': serializer.toJson<String>(code),
      'expiresAt': serializer.toJson<DateTime>(expiresAt),
      'usedAt': serializer.toJson<DateTime?>(usedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  EmailVerification copyWith({
    int? id,
    int? accountId,
    String? code,
    DateTime? expiresAt,
    Value<DateTime?> usedAt = const Value.absent(),
    DateTime? createdAt,
  }) => EmailVerification(
    id: id ?? this.id,
    accountId: accountId ?? this.accountId,
    code: code ?? this.code,
    expiresAt: expiresAt ?? this.expiresAt,
    usedAt: usedAt.present ? usedAt.value : this.usedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  EmailVerification copyWithCompanion(EmailVerificationsCompanion data) {
    return EmailVerification(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      code: data.code.present ? data.code.value : this.code,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      usedAt: data.usedAt.present ? data.usedAt.value : this.usedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EmailVerification(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('code: $code, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('usedAt: $usedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, accountId, code, expiresAt, usedAt, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmailVerification &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.code == this.code &&
          other.expiresAt == this.expiresAt &&
          other.usedAt == this.usedAt &&
          other.createdAt == this.createdAt);
}

class EmailVerificationsCompanion extends UpdateCompanion<EmailVerification> {
  final Value<int> id;
  final Value<int> accountId;
  final Value<String> code;
  final Value<DateTime> expiresAt;
  final Value<DateTime?> usedAt;
  final Value<DateTime> createdAt;
  const EmailVerificationsCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.code = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.usedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  EmailVerificationsCompanion.insert({
    this.id = const Value.absent(),
    required int accountId,
    required String code,
    required DateTime expiresAt,
    this.usedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : accountId = Value(accountId),
       code = Value(code),
       expiresAt = Value(expiresAt);
  static Insertable<EmailVerification> custom({
    Expression<int>? id,
    Expression<int>? accountId,
    Expression<String>? code,
    Expression<DateTime>? expiresAt,
    Expression<DateTime>? usedAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (code != null) 'code': code,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (usedAt != null) 'used_at': usedAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  EmailVerificationsCompanion copyWith({
    Value<int>? id,
    Value<int>? accountId,
    Value<String>? code,
    Value<DateTime>? expiresAt,
    Value<DateTime?>? usedAt,
    Value<DateTime>? createdAt,
  }) {
    return EmailVerificationsCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      code: code ?? this.code,
      expiresAt: expiresAt ?? this.expiresAt,
      usedAt: usedAt ?? this.usedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (usedAt.present) {
      map['used_at'] = Variable<DateTime>(usedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmailVerificationsCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('code: $code, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('usedAt: $usedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppServerDatabase extends GeneratedDatabase {
  _$AppServerDatabase(QueryExecutor e) : super(e);
  $AppServerDatabaseManager get managers => $AppServerDatabaseManager(this);
  late final $EmailVerificationsTable emailVerifications =
      $EmailVerificationsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [emailVerifications];
}

typedef $$EmailVerificationsTableCreateCompanionBuilder =
    EmailVerificationsCompanion Function({
      Value<int> id,
      required int accountId,
      required String code,
      required DateTime expiresAt,
      Value<DateTime?> usedAt,
      Value<DateTime> createdAt,
    });
typedef $$EmailVerificationsTableUpdateCompanionBuilder =
    EmailVerificationsCompanion Function({
      Value<int> id,
      Value<int> accountId,
      Value<String> code,
      Value<DateTime> expiresAt,
      Value<DateTime?> usedAt,
      Value<DateTime> createdAt,
    });

class $$EmailVerificationsTableFilterComposer
    extends Composer<_$AppServerDatabase, $EmailVerificationsTable> {
  $$EmailVerificationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get usedAt => $composableBuilder(
    column: $table.usedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EmailVerificationsTableOrderingComposer
    extends Composer<_$AppServerDatabase, $EmailVerificationsTable> {
  $$EmailVerificationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get usedAt => $composableBuilder(
    column: $table.usedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EmailVerificationsTableAnnotationComposer
    extends Composer<_$AppServerDatabase, $EmailVerificationsTable> {
  $$EmailVerificationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumn<DateTime> get usedAt =>
      $composableBuilder(column: $table.usedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$EmailVerificationsTableTableManager
    extends
        RootTableManager<
          _$AppServerDatabase,
          $EmailVerificationsTable,
          EmailVerification,
          $$EmailVerificationsTableFilterComposer,
          $$EmailVerificationsTableOrderingComposer,
          $$EmailVerificationsTableAnnotationComposer,
          $$EmailVerificationsTableCreateCompanionBuilder,
          $$EmailVerificationsTableUpdateCompanionBuilder,
          (
            EmailVerification,
            BaseReferences<
              _$AppServerDatabase,
              $EmailVerificationsTable,
              EmailVerification
            >,
          ),
          EmailVerification,
          PrefetchHooks Function()
        > {
  $$EmailVerificationsTableTableManager(
    _$AppServerDatabase db,
    $EmailVerificationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmailVerificationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmailVerificationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmailVerificationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> accountId = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<DateTime> expiresAt = const Value.absent(),
                Value<DateTime?> usedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => EmailVerificationsCompanion(
                id: id,
                accountId: accountId,
                code: code,
                expiresAt: expiresAt,
                usedAt: usedAt,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int accountId,
                required String code,
                required DateTime expiresAt,
                Value<DateTime?> usedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => EmailVerificationsCompanion.insert(
                id: id,
                accountId: accountId,
                code: code,
                expiresAt: expiresAt,
                usedAt: usedAt,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EmailVerificationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppServerDatabase,
      $EmailVerificationsTable,
      EmailVerification,
      $$EmailVerificationsTableFilterComposer,
      $$EmailVerificationsTableOrderingComposer,
      $$EmailVerificationsTableAnnotationComposer,
      $$EmailVerificationsTableCreateCompanionBuilder,
      $$EmailVerificationsTableUpdateCompanionBuilder,
      (
        EmailVerification,
        BaseReferences<
          _$AppServerDatabase,
          $EmailVerificationsTable,
          EmailVerification
        >,
      ),
      EmailVerification,
      PrefetchHooks Function()
    >;

class $AppServerDatabaseManager {
  final _$AppServerDatabase _db;
  $AppServerDatabaseManager(this._db);
  $$EmailVerificationsTableTableManager get emailVerifications =>
      $$EmailVerificationsTableTableManager(_db, _db.emailVerifications);
}
