// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CompanyTable extends Company with TableInfo<$CompanyTable, CompanyData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompanyTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, address];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'company';
  @override
  VerificationContext validateIntegrity(
    Insertable<CompanyData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CompanyData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CompanyData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
    );
  }

  @override
  $CompanyTable createAlias(String alias) {
    return $CompanyTable(attachedDatabase, alias);
  }
}

class CompanyData extends DataClass implements Insertable<CompanyData> {
  final int id;
  final String name;
  final String? address;
  const CompanyData({required this.id, required this.name, this.address});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    return map;
  }

  CompanyCompanion toCompanion(bool nullToAbsent) {
    return CompanyCompanion(
      id: Value(id),
      name: Value(name),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
    );
  }

  factory CompanyData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CompanyData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String?>(json['address']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String?>(address),
    };
  }

  CompanyData copyWith({
    int? id,
    String? name,
    Value<String?> address = const Value.absent(),
  }) => CompanyData(
    id: id ?? this.id,
    name: name ?? this.name,
    address: address.present ? address.value : this.address,
  );
  CompanyData copyWithCompanion(CompanyCompanion data) {
    return CompanyData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CompanyData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, address);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompanyData &&
          other.id == this.id &&
          other.name == this.name &&
          other.address == this.address);
}

class CompanyCompanion extends UpdateCompanion<CompanyData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> address;
  const CompanyCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
  });
  CompanyCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.address = const Value.absent(),
  }) : name = Value(name);
  static Insertable<CompanyData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? address,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
    });
  }

  CompanyCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? address,
  }) {
    return CompanyCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompanyCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
    'age',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('user'),
  );
  static const VerificationMeta _employerMeta = const VerificationMeta(
    'employer',
  );
  @override
  late final GeneratedColumn<String> employer = GeneratedColumn<String>(
    'employer',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _permissionsMeta = const VerificationMeta(
    'permissions',
  );
  @override
  late final GeneratedColumn<String> permissions = GeneratedColumn<String>(
    'permissions',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _canManageUsersMeta = const VerificationMeta(
    'canManageUsers',
  );
  @override
  late final GeneratedColumn<bool> canManageUsers = GeneratedColumn<bool>(
    'can_manage_users',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("can_manage_users" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _companyIdMeta = const VerificationMeta(
    'companyId',
  );
  @override
  late final GeneratedColumn<int> companyId = GeneratedColumn<int>(
    'company_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES company (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    age,
    role,
    employer,
    permissions,
    canManageUsers,
    companyId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
        _ageMeta,
        age.isAcceptableOrUnknown(data['age']!, _ageMeta),
      );
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    }
    if (data.containsKey('employer')) {
      context.handle(
        _employerMeta,
        employer.isAcceptableOrUnknown(data['employer']!, _employerMeta),
      );
    }
    if (data.containsKey('permissions')) {
      context.handle(
        _permissionsMeta,
        permissions.isAcceptableOrUnknown(
          data['permissions']!,
          _permissionsMeta,
        ),
      );
    }
    if (data.containsKey('can_manage_users')) {
      context.handle(
        _canManageUsersMeta,
        canManageUsers.isAcceptableOrUnknown(
          data['can_manage_users']!,
          _canManageUsersMeta,
        ),
      );
    }
    if (data.containsKey('company_id')) {
      context.handle(
        _companyIdMeta,
        companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_companyIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      age: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}age'],
      ),
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      employer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}employer'],
      ),
      permissions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}permissions'],
      ),
      canManageUsers: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}can_manage_users'],
      )!,
      companyId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}company_id'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String name;
  final int? age;
  final String role;
  final String? employer;
  final String? permissions;
  final bool canManageUsers;
  final int companyId;
  const User({
    required this.id,
    required this.name,
    this.age,
    required this.role,
    this.employer,
    this.permissions,
    required this.canManageUsers,
    required this.companyId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || age != null) {
      map['age'] = Variable<int>(age);
    }
    map['role'] = Variable<String>(role);
    if (!nullToAbsent || employer != null) {
      map['employer'] = Variable<String>(employer);
    }
    if (!nullToAbsent || permissions != null) {
      map['permissions'] = Variable<String>(permissions);
    }
    map['can_manage_users'] = Variable<bool>(canManageUsers);
    map['company_id'] = Variable<int>(companyId);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: Value(name),
      age: age == null && nullToAbsent ? const Value.absent() : Value(age),
      role: Value(role),
      employer: employer == null && nullToAbsent
          ? const Value.absent()
          : Value(employer),
      permissions: permissions == null && nullToAbsent
          ? const Value.absent()
          : Value(permissions),
      canManageUsers: Value(canManageUsers),
      companyId: Value(companyId),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      age: serializer.fromJson<int?>(json['age']),
      role: serializer.fromJson<String>(json['role']),
      employer: serializer.fromJson<String?>(json['employer']),
      permissions: serializer.fromJson<String?>(json['permissions']),
      canManageUsers: serializer.fromJson<bool>(json['canManageUsers']),
      companyId: serializer.fromJson<int>(json['companyId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'age': serializer.toJson<int?>(age),
      'role': serializer.toJson<String>(role),
      'employer': serializer.toJson<String?>(employer),
      'permissions': serializer.toJson<String?>(permissions),
      'canManageUsers': serializer.toJson<bool>(canManageUsers),
      'companyId': serializer.toJson<int>(companyId),
    };
  }

  User copyWith({
    int? id,
    String? name,
    Value<int?> age = const Value.absent(),
    String? role,
    Value<String?> employer = const Value.absent(),
    Value<String?> permissions = const Value.absent(),
    bool? canManageUsers,
    int? companyId,
  }) => User(
    id: id ?? this.id,
    name: name ?? this.name,
    age: age.present ? age.value : this.age,
    role: role ?? this.role,
    employer: employer.present ? employer.value : this.employer,
    permissions: permissions.present ? permissions.value : this.permissions,
    canManageUsers: canManageUsers ?? this.canManageUsers,
    companyId: companyId ?? this.companyId,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      age: data.age.present ? data.age.value : this.age,
      role: data.role.present ? data.role.value : this.role,
      employer: data.employer.present ? data.employer.value : this.employer,
      permissions: data.permissions.present
          ? data.permissions.value
          : this.permissions,
      canManageUsers: data.canManageUsers.present
          ? data.canManageUsers.value
          : this.canManageUsers,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('age: $age, ')
          ..write('role: $role, ')
          ..write('employer: $employer, ')
          ..write('permissions: $permissions, ')
          ..write('canManageUsers: $canManageUsers, ')
          ..write('companyId: $companyId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    age,
    role,
    employer,
    permissions,
    canManageUsers,
    companyId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.age == this.age &&
          other.role == this.role &&
          other.employer == this.employer &&
          other.permissions == this.permissions &&
          other.canManageUsers == this.canManageUsers &&
          other.companyId == this.companyId);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> name;
  final Value<int?> age;
  final Value<String> role;
  final Value<String?> employer;
  final Value<String?> permissions;
  final Value<bool> canManageUsers;
  final Value<int> companyId;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.age = const Value.absent(),
    this.role = const Value.absent(),
    this.employer = const Value.absent(),
    this.permissions = const Value.absent(),
    this.canManageUsers = const Value.absent(),
    this.companyId = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.age = const Value.absent(),
    this.role = const Value.absent(),
    this.employer = const Value.absent(),
    this.permissions = const Value.absent(),
    this.canManageUsers = const Value.absent(),
    required int companyId,
  }) : name = Value(name),
       companyId = Value(companyId);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? age,
    Expression<String>? role,
    Expression<String>? employer,
    Expression<String>? permissions,
    Expression<bool>? canManageUsers,
    Expression<int>? companyId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (age != null) 'age': age,
      if (role != null) 'role': role,
      if (employer != null) 'employer': employer,
      if (permissions != null) 'permissions': permissions,
      if (canManageUsers != null) 'can_manage_users': canManageUsers,
      if (companyId != null) 'company_id': companyId,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int?>? age,
    Value<String>? role,
    Value<String?>? employer,
    Value<String?>? permissions,
    Value<bool>? canManageUsers,
    Value<int>? companyId,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      role: role ?? this.role,
      employer: employer ?? this.employer,
      permissions: permissions ?? this.permissions,
      canManageUsers: canManageUsers ?? this.canManageUsers,
      companyId: companyId ?? this.companyId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (employer.present) {
      map['employer'] = Variable<String>(employer.value);
    }
    if (permissions.present) {
      map['permissions'] = Variable<String>(permissions.value);
    }
    if (canManageUsers.present) {
      map['can_manage_users'] = Variable<bool>(canManageUsers.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<int>(companyId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('age: $age, ')
          ..write('role: $role, ')
          ..write('employer: $employer, ')
          ..write('permissions: $permissions, ')
          ..write('canManageUsers: $canManageUsers, ')
          ..write('companyId: $companyId')
          ..write(')'))
        .toString();
  }
}

class $TemplatesTable extends Templates
    with TableInfo<$TemplatesTable, Template> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TemplatesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<int> createdBy = GeneratedColumn<int>(
    'created_by',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
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
  List<GeneratedColumn> get $columns => [id, name, createdBy, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<Template> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    } else if (isInserting) {
      context.missing(_createdByMeta);
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
  Template map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Template(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_by'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TemplatesTable createAlias(String alias) {
    return $TemplatesTable(attachedDatabase, alias);
  }
}

class Template extends DataClass implements Insertable<Template> {
  final int id;
  final String name;
  final int createdBy;
  final DateTime createdAt;
  const Template({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['created_by'] = Variable<int>(createdBy);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TemplatesCompanion toCompanion(bool nullToAbsent) {
    return TemplatesCompanion(
      id: Value(id),
      name: Value(name),
      createdBy: Value(createdBy),
      createdAt: Value(createdAt),
    );
  }

  factory Template.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Template(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdBy: serializer.fromJson<int>(json['createdBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'createdBy': serializer.toJson<int>(createdBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Template copyWith({
    int? id,
    String? name,
    int? createdBy,
    DateTime? createdAt,
  }) => Template(
    id: id ?? this.id,
    name: name ?? this.name,
    createdBy: createdBy ?? this.createdBy,
    createdAt: createdAt ?? this.createdAt,
  );
  Template copyWithCompanion(TemplatesCompanion data) {
    return Template(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Template(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createdBy, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Template &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdBy == this.createdBy &&
          other.createdAt == this.createdAt);
}

class TemplatesCompanion extends UpdateCompanion<Template> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> createdBy;
  final Value<DateTime> createdAt;
  const TemplatesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TemplatesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int createdBy,
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       createdBy = Value(createdBy);
  static Insertable<Template> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? createdBy,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdBy != null) 'created_by': createdBy,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TemplatesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? createdBy,
    Value<DateTime>? createdAt,
  }) {
    return TemplatesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<int>(createdBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TemplatesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TemplateFieldsTable extends TemplateFields
    with TableInfo<$TemplateFieldsTable, TemplateField> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TemplateFieldsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _templateIdMeta = const VerificationMeta(
    'templateId',
  );
  @override
  late final GeneratedColumn<int> templateId = GeneratedColumn<int>(
    'template_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES templates (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _fieldNameMeta = const VerificationMeta(
    'fieldName',
  );
  @override
  late final GeneratedColumn<String> fieldName = GeneratedColumn<String>(
    'field_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isRequiredMeta = const VerificationMeta(
    'isRequired',
  );
  @override
  late final GeneratedColumn<bool> isRequired = GeneratedColumn<bool>(
    'is_required',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_required" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    templateId,
    fieldName,
    isRequired,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'template_fields';
  @override
  VerificationContext validateIntegrity(
    Insertable<TemplateField> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('template_id')) {
      context.handle(
        _templateIdMeta,
        templateId.isAcceptableOrUnknown(data['template_id']!, _templateIdMeta),
      );
    } else if (isInserting) {
      context.missing(_templateIdMeta);
    }
    if (data.containsKey('field_name')) {
      context.handle(
        _fieldNameMeta,
        fieldName.isAcceptableOrUnknown(data['field_name']!, _fieldNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fieldNameMeta);
    }
    if (data.containsKey('is_required')) {
      context.handle(
        _isRequiredMeta,
        isRequired.isAcceptableOrUnknown(data['is_required']!, _isRequiredMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TemplateField map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TemplateField(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      templateId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}template_id'],
      )!,
      fieldName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_name'],
      )!,
      isRequired: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_required'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $TemplateFieldsTable createAlias(String alias) {
    return $TemplateFieldsTable(attachedDatabase, alias);
  }
}

class TemplateField extends DataClass implements Insertable<TemplateField> {
  final int id;
  final int templateId;
  final String fieldName;
  final bool isRequired;
  final int sortOrder;
  const TemplateField({
    required this.id,
    required this.templateId,
    required this.fieldName,
    required this.isRequired,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['template_id'] = Variable<int>(templateId);
    map['field_name'] = Variable<String>(fieldName);
    map['is_required'] = Variable<bool>(isRequired);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  TemplateFieldsCompanion toCompanion(bool nullToAbsent) {
    return TemplateFieldsCompanion(
      id: Value(id),
      templateId: Value(templateId),
      fieldName: Value(fieldName),
      isRequired: Value(isRequired),
      sortOrder: Value(sortOrder),
    );
  }

  factory TemplateField.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TemplateField(
      id: serializer.fromJson<int>(json['id']),
      templateId: serializer.fromJson<int>(json['templateId']),
      fieldName: serializer.fromJson<String>(json['fieldName']),
      isRequired: serializer.fromJson<bool>(json['isRequired']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'templateId': serializer.toJson<int>(templateId),
      'fieldName': serializer.toJson<String>(fieldName),
      'isRequired': serializer.toJson<bool>(isRequired),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  TemplateField copyWith({
    int? id,
    int? templateId,
    String? fieldName,
    bool? isRequired,
    int? sortOrder,
  }) => TemplateField(
    id: id ?? this.id,
    templateId: templateId ?? this.templateId,
    fieldName: fieldName ?? this.fieldName,
    isRequired: isRequired ?? this.isRequired,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  TemplateField copyWithCompanion(TemplateFieldsCompanion data) {
    return TemplateField(
      id: data.id.present ? data.id.value : this.id,
      templateId: data.templateId.present
          ? data.templateId.value
          : this.templateId,
      fieldName: data.fieldName.present ? data.fieldName.value : this.fieldName,
      isRequired: data.isRequired.present
          ? data.isRequired.value
          : this.isRequired,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TemplateField(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('fieldName: $fieldName, ')
          ..write('isRequired: $isRequired, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, templateId, fieldName, isRequired, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TemplateField &&
          other.id == this.id &&
          other.templateId == this.templateId &&
          other.fieldName == this.fieldName &&
          other.isRequired == this.isRequired &&
          other.sortOrder == this.sortOrder);
}

class TemplateFieldsCompanion extends UpdateCompanion<TemplateField> {
  final Value<int> id;
  final Value<int> templateId;
  final Value<String> fieldName;
  final Value<bool> isRequired;
  final Value<int> sortOrder;
  const TemplateFieldsCompanion({
    this.id = const Value.absent(),
    this.templateId = const Value.absent(),
    this.fieldName = const Value.absent(),
    this.isRequired = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  TemplateFieldsCompanion.insert({
    this.id = const Value.absent(),
    required int templateId,
    required String fieldName,
    this.isRequired = const Value.absent(),
    this.sortOrder = const Value.absent(),
  }) : templateId = Value(templateId),
       fieldName = Value(fieldName);
  static Insertable<TemplateField> custom({
    Expression<int>? id,
    Expression<int>? templateId,
    Expression<String>? fieldName,
    Expression<bool>? isRequired,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (templateId != null) 'template_id': templateId,
      if (fieldName != null) 'field_name': fieldName,
      if (isRequired != null) 'is_required': isRequired,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  TemplateFieldsCompanion copyWith({
    Value<int>? id,
    Value<int>? templateId,
    Value<String>? fieldName,
    Value<bool>? isRequired,
    Value<int>? sortOrder,
  }) {
    return TemplateFieldsCompanion(
      id: id ?? this.id,
      templateId: templateId ?? this.templateId,
      fieldName: fieldName ?? this.fieldName,
      isRequired: isRequired ?? this.isRequired,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<int>(templateId.value);
    }
    if (fieldName.present) {
      map['field_name'] = Variable<String>(fieldName.value);
    }
    if (isRequired.present) {
      map['is_required'] = Variable<bool>(isRequired.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TemplateFieldsCompanion(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('fieldName: $fieldName, ')
          ..write('isRequired: $isRequired, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $JobQuotesTable extends JobQuotes
    with TableInfo<$JobQuotesTable, JobQuote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JobQuotesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _templateIdMeta = const VerificationMeta(
    'templateId',
  );
  @override
  late final GeneratedColumn<int> templateId = GeneratedColumn<int>(
    'template_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES templates (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _customerNameMeta = const VerificationMeta(
    'customerName',
  );
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
    'customer_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerContactMeta = const VerificationMeta(
    'customerContact',
  );
  @override
  late final GeneratedColumn<String> customerContact = GeneratedColumn<String>(
    'customer_contact',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quoteDateMeta = const VerificationMeta(
    'quoteDate',
  );
  @override
  late final GeneratedColumn<DateTime> quoteDate = GeneratedColumn<DateTime>(
    'quote_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<int> createdBy = GeneratedColumn<int>(
    'created_by',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    templateId,
    customerName,
    customerContact,
    quoteDate,
    totalAmount,
    createdBy,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'job_quotes';
  @override
  VerificationContext validateIntegrity(
    Insertable<JobQuote> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('template_id')) {
      context.handle(
        _templateIdMeta,
        templateId.isAcceptableOrUnknown(data['template_id']!, _templateIdMeta),
      );
    } else if (isInserting) {
      context.missing(_templateIdMeta);
    }
    if (data.containsKey('customer_name')) {
      context.handle(
        _customerNameMeta,
        customerName.isAcceptableOrUnknown(
          data['customer_name']!,
          _customerNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_customerNameMeta);
    }
    if (data.containsKey('customer_contact')) {
      context.handle(
        _customerContactMeta,
        customerContact.isAcceptableOrUnknown(
          data['customer_contact']!,
          _customerContactMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_customerContactMeta);
    }
    if (data.containsKey('quote_date')) {
      context.handle(
        _quoteDateMeta,
        quoteDate.isAcceptableOrUnknown(data['quote_date']!, _quoteDateMeta),
      );
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    } else if (isInserting) {
      context.missing(_createdByMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JobQuote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JobQuote(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      templateId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}template_id'],
      )!,
      customerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_name'],
      )!,
      customerContact: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_contact'],
      )!,
      quoteDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}quote_date'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_by'],
      )!,
    );
  }

  @override
  $JobQuotesTable createAlias(String alias) {
    return $JobQuotesTable(attachedDatabase, alias);
  }
}

class JobQuote extends DataClass implements Insertable<JobQuote> {
  final int id;
  final int templateId;
  final String customerName;
  final String customerContact;
  final DateTime quoteDate;
  final double totalAmount;
  final int createdBy;
  const JobQuote({
    required this.id,
    required this.templateId,
    required this.customerName,
    required this.customerContact,
    required this.quoteDate,
    required this.totalAmount,
    required this.createdBy,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['template_id'] = Variable<int>(templateId);
    map['customer_name'] = Variable<String>(customerName);
    map['customer_contact'] = Variable<String>(customerContact);
    map['quote_date'] = Variable<DateTime>(quoteDate);
    map['total_amount'] = Variable<double>(totalAmount);
    map['created_by'] = Variable<int>(createdBy);
    return map;
  }

  JobQuotesCompanion toCompanion(bool nullToAbsent) {
    return JobQuotesCompanion(
      id: Value(id),
      templateId: Value(templateId),
      customerName: Value(customerName),
      customerContact: Value(customerContact),
      quoteDate: Value(quoteDate),
      totalAmount: Value(totalAmount),
      createdBy: Value(createdBy),
    );
  }

  factory JobQuote.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JobQuote(
      id: serializer.fromJson<int>(json['id']),
      templateId: serializer.fromJson<int>(json['templateId']),
      customerName: serializer.fromJson<String>(json['customerName']),
      customerContact: serializer.fromJson<String>(json['customerContact']),
      quoteDate: serializer.fromJson<DateTime>(json['quoteDate']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      createdBy: serializer.fromJson<int>(json['createdBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'templateId': serializer.toJson<int>(templateId),
      'customerName': serializer.toJson<String>(customerName),
      'customerContact': serializer.toJson<String>(customerContact),
      'quoteDate': serializer.toJson<DateTime>(quoteDate),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'createdBy': serializer.toJson<int>(createdBy),
    };
  }

  JobQuote copyWith({
    int? id,
    int? templateId,
    String? customerName,
    String? customerContact,
    DateTime? quoteDate,
    double? totalAmount,
    int? createdBy,
  }) => JobQuote(
    id: id ?? this.id,
    templateId: templateId ?? this.templateId,
    customerName: customerName ?? this.customerName,
    customerContact: customerContact ?? this.customerContact,
    quoteDate: quoteDate ?? this.quoteDate,
    totalAmount: totalAmount ?? this.totalAmount,
    createdBy: createdBy ?? this.createdBy,
  );
  JobQuote copyWithCompanion(JobQuotesCompanion data) {
    return JobQuote(
      id: data.id.present ? data.id.value : this.id,
      templateId: data.templateId.present
          ? data.templateId.value
          : this.templateId,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      customerContact: data.customerContact.present
          ? data.customerContact.value
          : this.customerContact,
      quoteDate: data.quoteDate.present ? data.quoteDate.value : this.quoteDate,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JobQuote(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('customerName: $customerName, ')
          ..write('customerContact: $customerContact, ')
          ..write('quoteDate: $quoteDate, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('createdBy: $createdBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    templateId,
    customerName,
    customerContact,
    quoteDate,
    totalAmount,
    createdBy,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JobQuote &&
          other.id == this.id &&
          other.templateId == this.templateId &&
          other.customerName == this.customerName &&
          other.customerContact == this.customerContact &&
          other.quoteDate == this.quoteDate &&
          other.totalAmount == this.totalAmount &&
          other.createdBy == this.createdBy);
}

class JobQuotesCompanion extends UpdateCompanion<JobQuote> {
  final Value<int> id;
  final Value<int> templateId;
  final Value<String> customerName;
  final Value<String> customerContact;
  final Value<DateTime> quoteDate;
  final Value<double> totalAmount;
  final Value<int> createdBy;
  const JobQuotesCompanion({
    this.id = const Value.absent(),
    this.templateId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.customerContact = const Value.absent(),
    this.quoteDate = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.createdBy = const Value.absent(),
  });
  JobQuotesCompanion.insert({
    this.id = const Value.absent(),
    required int templateId,
    required String customerName,
    required String customerContact,
    this.quoteDate = const Value.absent(),
    this.totalAmount = const Value.absent(),
    required int createdBy,
  }) : templateId = Value(templateId),
       customerName = Value(customerName),
       customerContact = Value(customerContact),
       createdBy = Value(createdBy);
  static Insertable<JobQuote> custom({
    Expression<int>? id,
    Expression<int>? templateId,
    Expression<String>? customerName,
    Expression<String>? customerContact,
    Expression<DateTime>? quoteDate,
    Expression<double>? totalAmount,
    Expression<int>? createdBy,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (templateId != null) 'template_id': templateId,
      if (customerName != null) 'customer_name': customerName,
      if (customerContact != null) 'customer_contact': customerContact,
      if (quoteDate != null) 'quote_date': quoteDate,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (createdBy != null) 'created_by': createdBy,
    });
  }

  JobQuotesCompanion copyWith({
    Value<int>? id,
    Value<int>? templateId,
    Value<String>? customerName,
    Value<String>? customerContact,
    Value<DateTime>? quoteDate,
    Value<double>? totalAmount,
    Value<int>? createdBy,
  }) {
    return JobQuotesCompanion(
      id: id ?? this.id,
      templateId: templateId ?? this.templateId,
      customerName: customerName ?? this.customerName,
      customerContact: customerContact ?? this.customerContact,
      quoteDate: quoteDate ?? this.quoteDate,
      totalAmount: totalAmount ?? this.totalAmount,
      createdBy: createdBy ?? this.createdBy,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<int>(templateId.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (customerContact.present) {
      map['customer_contact'] = Variable<String>(customerContact.value);
    }
    if (quoteDate.present) {
      map['quote_date'] = Variable<DateTime>(quoteDate.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<int>(createdBy.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JobQuotesCompanion(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('customerName: $customerName, ')
          ..write('customerContact: $customerContact, ')
          ..write('quoteDate: $quoteDate, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('createdBy: $createdBy')
          ..write(')'))
        .toString();
  }
}

class $QuoteFieldValuesTable extends QuoteFieldValues
    with TableInfo<$QuoteFieldValuesTable, QuoteFieldValue> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuoteFieldValuesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _quoteIdMeta = const VerificationMeta(
    'quoteId',
  );
  @override
  late final GeneratedColumn<int> quoteId = GeneratedColumn<int>(
    'quote_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES job_quotes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _fieldIdMeta = const VerificationMeta(
    'fieldId',
  );
  @override
  late final GeneratedColumn<int> fieldId = GeneratedColumn<int>(
    'field_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES template_fields (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _fieldValueMeta = const VerificationMeta(
    'fieldValue',
  );
  @override
  late final GeneratedColumn<String> fieldValue = GeneratedColumn<String>(
    'field_value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, quoteId, fieldId, fieldValue];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quote_field_values';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuoteFieldValue> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('quote_id')) {
      context.handle(
        _quoteIdMeta,
        quoteId.isAcceptableOrUnknown(data['quote_id']!, _quoteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_quoteIdMeta);
    }
    if (data.containsKey('field_id')) {
      context.handle(
        _fieldIdMeta,
        fieldId.isAcceptableOrUnknown(data['field_id']!, _fieldIdMeta),
      );
    } else if (isInserting) {
      context.missing(_fieldIdMeta);
    }
    if (data.containsKey('field_value')) {
      context.handle(
        _fieldValueMeta,
        fieldValue.isAcceptableOrUnknown(data['field_value']!, _fieldValueMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuoteFieldValue map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuoteFieldValue(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      quoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quote_id'],
      )!,
      fieldId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}field_id'],
      )!,
      fieldValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_value'],
      ),
    );
  }

  @override
  $QuoteFieldValuesTable createAlias(String alias) {
    return $QuoteFieldValuesTable(attachedDatabase, alias);
  }
}

class QuoteFieldValue extends DataClass implements Insertable<QuoteFieldValue> {
  final int id;
  final int quoteId;
  final int fieldId;
  final String? fieldValue;
  const QuoteFieldValue({
    required this.id,
    required this.quoteId,
    required this.fieldId,
    this.fieldValue,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['quote_id'] = Variable<int>(quoteId);
    map['field_id'] = Variable<int>(fieldId);
    if (!nullToAbsent || fieldValue != null) {
      map['field_value'] = Variable<String>(fieldValue);
    }
    return map;
  }

  QuoteFieldValuesCompanion toCompanion(bool nullToAbsent) {
    return QuoteFieldValuesCompanion(
      id: Value(id),
      quoteId: Value(quoteId),
      fieldId: Value(fieldId),
      fieldValue: fieldValue == null && nullToAbsent
          ? const Value.absent()
          : Value(fieldValue),
    );
  }

  factory QuoteFieldValue.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuoteFieldValue(
      id: serializer.fromJson<int>(json['id']),
      quoteId: serializer.fromJson<int>(json['quoteId']),
      fieldId: serializer.fromJson<int>(json['fieldId']),
      fieldValue: serializer.fromJson<String?>(json['fieldValue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'quoteId': serializer.toJson<int>(quoteId),
      'fieldId': serializer.toJson<int>(fieldId),
      'fieldValue': serializer.toJson<String?>(fieldValue),
    };
  }

  QuoteFieldValue copyWith({
    int? id,
    int? quoteId,
    int? fieldId,
    Value<String?> fieldValue = const Value.absent(),
  }) => QuoteFieldValue(
    id: id ?? this.id,
    quoteId: quoteId ?? this.quoteId,
    fieldId: fieldId ?? this.fieldId,
    fieldValue: fieldValue.present ? fieldValue.value : this.fieldValue,
  );
  QuoteFieldValue copyWithCompanion(QuoteFieldValuesCompanion data) {
    return QuoteFieldValue(
      id: data.id.present ? data.id.value : this.id,
      quoteId: data.quoteId.present ? data.quoteId.value : this.quoteId,
      fieldId: data.fieldId.present ? data.fieldId.value : this.fieldId,
      fieldValue: data.fieldValue.present
          ? data.fieldValue.value
          : this.fieldValue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuoteFieldValue(')
          ..write('id: $id, ')
          ..write('quoteId: $quoteId, ')
          ..write('fieldId: $fieldId, ')
          ..write('fieldValue: $fieldValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, quoteId, fieldId, fieldValue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuoteFieldValue &&
          other.id == this.id &&
          other.quoteId == this.quoteId &&
          other.fieldId == this.fieldId &&
          other.fieldValue == this.fieldValue);
}

class QuoteFieldValuesCompanion extends UpdateCompanion<QuoteFieldValue> {
  final Value<int> id;
  final Value<int> quoteId;
  final Value<int> fieldId;
  final Value<String?> fieldValue;
  const QuoteFieldValuesCompanion({
    this.id = const Value.absent(),
    this.quoteId = const Value.absent(),
    this.fieldId = const Value.absent(),
    this.fieldValue = const Value.absent(),
  });
  QuoteFieldValuesCompanion.insert({
    this.id = const Value.absent(),
    required int quoteId,
    required int fieldId,
    this.fieldValue = const Value.absent(),
  }) : quoteId = Value(quoteId),
       fieldId = Value(fieldId);
  static Insertable<QuoteFieldValue> custom({
    Expression<int>? id,
    Expression<int>? quoteId,
    Expression<int>? fieldId,
    Expression<String>? fieldValue,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (quoteId != null) 'quote_id': quoteId,
      if (fieldId != null) 'field_id': fieldId,
      if (fieldValue != null) 'field_value': fieldValue,
    });
  }

  QuoteFieldValuesCompanion copyWith({
    Value<int>? id,
    Value<int>? quoteId,
    Value<int>? fieldId,
    Value<String?>? fieldValue,
  }) {
    return QuoteFieldValuesCompanion(
      id: id ?? this.id,
      quoteId: quoteId ?? this.quoteId,
      fieldId: fieldId ?? this.fieldId,
      fieldValue: fieldValue ?? this.fieldValue,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (quoteId.present) {
      map['quote_id'] = Variable<int>(quoteId.value);
    }
    if (fieldId.present) {
      map['field_id'] = Variable<int>(fieldId.value);
    }
    if (fieldValue.present) {
      map['field_value'] = Variable<String>(fieldValue.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuoteFieldValuesCompanion(')
          ..write('id: $id, ')
          ..write('quoteId: $quoteId, ')
          ..write('fieldId: $fieldId, ')
          ..write('fieldValue: $fieldValue')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contactInfoMeta = const VerificationMeta(
    'contactInfo',
  );
  @override
  late final GeneratedColumn<String> contactInfo = GeneratedColumn<String>(
    'contact_info',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _managedByMeta = const VerificationMeta(
    'managedBy',
  );
  @override
  late final GeneratedColumn<int> managedBy = GeneratedColumn<int>(
    'managed_by',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    contactInfo,
    address,
    managedBy,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Customer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('contact_info')) {
      context.handle(
        _contactInfoMeta,
        contactInfo.isAcceptableOrUnknown(
          data['contact_info']!,
          _contactInfoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contactInfoMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('managed_by')) {
      context.handle(
        _managedByMeta,
        managedBy.isAcceptableOrUnknown(data['managed_by']!, _managedByMeta),
      );
    } else if (isInserting) {
      context.missing(_managedByMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      contactInfo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_info'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      managedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}managed_by'],
      )!,
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class Customer extends DataClass implements Insertable<Customer> {
  final int id;
  final String name;
  final String contactInfo;
  final String? address;
  final int managedBy;
  const Customer({
    required this.id,
    required this.name,
    required this.contactInfo,
    this.address,
    required this.managedBy,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['contact_info'] = Variable<String>(contactInfo);
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['managed_by'] = Variable<int>(managedBy);
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      name: Value(name),
      contactInfo: Value(contactInfo),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      managedBy: Value(managedBy),
    );
  }

  factory Customer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      contactInfo: serializer.fromJson<String>(json['contactInfo']),
      address: serializer.fromJson<String?>(json['address']),
      managedBy: serializer.fromJson<int>(json['managedBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'contactInfo': serializer.toJson<String>(contactInfo),
      'address': serializer.toJson<String?>(address),
      'managedBy': serializer.toJson<int>(managedBy),
    };
  }

  Customer copyWith({
    int? id,
    String? name,
    String? contactInfo,
    Value<String?> address = const Value.absent(),
    int? managedBy,
  }) => Customer(
    id: id ?? this.id,
    name: name ?? this.name,
    contactInfo: contactInfo ?? this.contactInfo,
    address: address.present ? address.value : this.address,
    managedBy: managedBy ?? this.managedBy,
  );
  Customer copyWithCompanion(CustomersCompanion data) {
    return Customer(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      contactInfo: data.contactInfo.present
          ? data.contactInfo.value
          : this.contactInfo,
      address: data.address.present ? data.address.value : this.address,
      managedBy: data.managedBy.present ? data.managedBy.value : this.managedBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('contactInfo: $contactInfo, ')
          ..write('address: $address, ')
          ..write('managedBy: $managedBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, contactInfo, address, managedBy);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.name == this.name &&
          other.contactInfo == this.contactInfo &&
          other.address == this.address &&
          other.managedBy == this.managedBy);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> contactInfo;
  final Value<String?> address;
  final Value<int> managedBy;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.contactInfo = const Value.absent(),
    this.address = const Value.absent(),
    this.managedBy = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String contactInfo,
    this.address = const Value.absent(),
    required int managedBy,
  }) : name = Value(name),
       contactInfo = Value(contactInfo),
       managedBy = Value(managedBy);
  static Insertable<Customer> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? contactInfo,
    Expression<String>? address,
    Expression<int>? managedBy,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (contactInfo != null) 'contact_info': contactInfo,
      if (address != null) 'address': address,
      if (managedBy != null) 'managed_by': managedBy,
    });
  }

  CustomersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? contactInfo,
    Value<String?>? address,
    Value<int>? managedBy,
  }) {
    return CustomersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      contactInfo: contactInfo ?? this.contactInfo,
      address: address ?? this.address,
      managedBy: managedBy ?? this.managedBy,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (contactInfo.present) {
      map['contact_info'] = Variable<String>(contactInfo.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (managedBy.present) {
      map['managed_by'] = Variable<int>(managedBy.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('contactInfo: $contactInfo, ')
          ..write('address: $address, ')
          ..write('managedBy: $managedBy')
          ..write(')'))
        .toString();
  }
}

class $JobsTable extends Jobs with TableInfo<$JobsTable, Job> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JobsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _quoteIdMeta = const VerificationMeta(
    'quoteId',
  );
  @override
  late final GeneratedColumn<int> quoteId = GeneratedColumn<int>(
    'quote_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES job_quotes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jobStatusMeta = const VerificationMeta(
    'jobStatus',
  );
  @override
  late final GeneratedColumn<String> jobStatus = GeneratedColumn<String>(
    'job_status',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _assignedToMeta = const VerificationMeta(
    'assignedTo',
  );
  @override
  late final GeneratedColumn<int> assignedTo = GeneratedColumn<int>(
    'assigned_to',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _customerMeta = const VerificationMeta(
    'customer',
  );
  @override
  late final GeneratedColumn<int> customer = GeneratedColumn<int>(
    'customer',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customers (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    quoteId,
    name,
    jobStatus,
    startDate,
    endDate,
    assignedTo,
    customer,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'jobs';
  @override
  VerificationContext validateIntegrity(
    Insertable<Job> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('quote_id')) {
      context.handle(
        _quoteIdMeta,
        quoteId.isAcceptableOrUnknown(data['quote_id']!, _quoteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_quoteIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('job_status')) {
      context.handle(
        _jobStatusMeta,
        jobStatus.isAcceptableOrUnknown(data['job_status']!, _jobStatusMeta),
      );
    } else if (isInserting) {
      context.missing(_jobStatusMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('assigned_to')) {
      context.handle(
        _assignedToMeta,
        assignedTo.isAcceptableOrUnknown(data['assigned_to']!, _assignedToMeta),
      );
    } else if (isInserting) {
      context.missing(_assignedToMeta);
    }
    if (data.containsKey('customer')) {
      context.handle(
        _customerMeta,
        customer.isAcceptableOrUnknown(data['customer']!, _customerMeta),
      );
    } else if (isInserting) {
      context.missing(_customerMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Job map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Job(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      quoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quote_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      jobStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}job_status'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      ),
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      ),
      assignedTo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}assigned_to'],
      )!,
      customer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer'],
      )!,
    );
  }

  @override
  $JobsTable createAlias(String alias) {
    return $JobsTable(attachedDatabase, alias);
  }
}

class Job extends DataClass implements Insertable<Job> {
  final int id;
  final int quoteId;
  final String name;
  final String jobStatus;
  final DateTime? startDate;
  final DateTime? endDate;
  final int assignedTo;
  final int customer;
  const Job({
    required this.id,
    required this.quoteId,
    required this.name,
    required this.jobStatus,
    this.startDate,
    this.endDate,
    required this.assignedTo,
    required this.customer,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['quote_id'] = Variable<int>(quoteId);
    map['name'] = Variable<String>(name);
    map['job_status'] = Variable<String>(jobStatus);
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    map['assigned_to'] = Variable<int>(assignedTo);
    map['customer'] = Variable<int>(customer);
    return map;
  }

  JobsCompanion toCompanion(bool nullToAbsent) {
    return JobsCompanion(
      id: Value(id),
      quoteId: Value(quoteId),
      name: Value(name),
      jobStatus: Value(jobStatus),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      assignedTo: Value(assignedTo),
      customer: Value(customer),
    );
  }

  factory Job.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Job(
      id: serializer.fromJson<int>(json['id']),
      quoteId: serializer.fromJson<int>(json['quoteId']),
      name: serializer.fromJson<String>(json['name']),
      jobStatus: serializer.fromJson<String>(json['jobStatus']),
      startDate: serializer.fromJson<DateTime?>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      assignedTo: serializer.fromJson<int>(json['assignedTo']),
      customer: serializer.fromJson<int>(json['customer']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'quoteId': serializer.toJson<int>(quoteId),
      'name': serializer.toJson<String>(name),
      'jobStatus': serializer.toJson<String>(jobStatus),
      'startDate': serializer.toJson<DateTime?>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'assignedTo': serializer.toJson<int>(assignedTo),
      'customer': serializer.toJson<int>(customer),
    };
  }

  Job copyWith({
    int? id,
    int? quoteId,
    String? name,
    String? jobStatus,
    Value<DateTime?> startDate = const Value.absent(),
    Value<DateTime?> endDate = const Value.absent(),
    int? assignedTo,
    int? customer,
  }) => Job(
    id: id ?? this.id,
    quoteId: quoteId ?? this.quoteId,
    name: name ?? this.name,
    jobStatus: jobStatus ?? this.jobStatus,
    startDate: startDate.present ? startDate.value : this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    assignedTo: assignedTo ?? this.assignedTo,
    customer: customer ?? this.customer,
  );
  Job copyWithCompanion(JobsCompanion data) {
    return Job(
      id: data.id.present ? data.id.value : this.id,
      quoteId: data.quoteId.present ? data.quoteId.value : this.quoteId,
      name: data.name.present ? data.name.value : this.name,
      jobStatus: data.jobStatus.present ? data.jobStatus.value : this.jobStatus,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      assignedTo: data.assignedTo.present
          ? data.assignedTo.value
          : this.assignedTo,
      customer: data.customer.present ? data.customer.value : this.customer,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Job(')
          ..write('id: $id, ')
          ..write('quoteId: $quoteId, ')
          ..write('name: $name, ')
          ..write('jobStatus: $jobStatus, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('assignedTo: $assignedTo, ')
          ..write('customer: $customer')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    quoteId,
    name,
    jobStatus,
    startDate,
    endDate,
    assignedTo,
    customer,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Job &&
          other.id == this.id &&
          other.quoteId == this.quoteId &&
          other.name == this.name &&
          other.jobStatus == this.jobStatus &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.assignedTo == this.assignedTo &&
          other.customer == this.customer);
}

class JobsCompanion extends UpdateCompanion<Job> {
  final Value<int> id;
  final Value<int> quoteId;
  final Value<String> name;
  final Value<String> jobStatus;
  final Value<DateTime?> startDate;
  final Value<DateTime?> endDate;
  final Value<int> assignedTo;
  final Value<int> customer;
  const JobsCompanion({
    this.id = const Value.absent(),
    this.quoteId = const Value.absent(),
    this.name = const Value.absent(),
    this.jobStatus = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.assignedTo = const Value.absent(),
    this.customer = const Value.absent(),
  });
  JobsCompanion.insert({
    this.id = const Value.absent(),
    required int quoteId,
    required String name,
    required String jobStatus,
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    required int assignedTo,
    required int customer,
  }) : quoteId = Value(quoteId),
       name = Value(name),
       jobStatus = Value(jobStatus),
       assignedTo = Value(assignedTo),
       customer = Value(customer);
  static Insertable<Job> custom({
    Expression<int>? id,
    Expression<int>? quoteId,
    Expression<String>? name,
    Expression<String>? jobStatus,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<int>? assignedTo,
    Expression<int>? customer,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (quoteId != null) 'quote_id': quoteId,
      if (name != null) 'name': name,
      if (jobStatus != null) 'job_status': jobStatus,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (assignedTo != null) 'assigned_to': assignedTo,
      if (customer != null) 'customer': customer,
    });
  }

  JobsCompanion copyWith({
    Value<int>? id,
    Value<int>? quoteId,
    Value<String>? name,
    Value<String>? jobStatus,
    Value<DateTime?>? startDate,
    Value<DateTime?>? endDate,
    Value<int>? assignedTo,
    Value<int>? customer,
  }) {
    return JobsCompanion(
      id: id ?? this.id,
      quoteId: quoteId ?? this.quoteId,
      name: name ?? this.name,
      jobStatus: jobStatus ?? this.jobStatus,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      assignedTo: assignedTo ?? this.assignedTo,
      customer: customer ?? this.customer,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (quoteId.present) {
      map['quote_id'] = Variable<int>(quoteId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (jobStatus.present) {
      map['job_status'] = Variable<String>(jobStatus.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (assignedTo.present) {
      map['assigned_to'] = Variable<int>(assignedTo.value);
    }
    if (customer.present) {
      map['customer'] = Variable<int>(customer.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JobsCompanion(')
          ..write('id: $id, ')
          ..write('quoteId: $quoteId, ')
          ..write('name: $name, ')
          ..write('jobStatus: $jobStatus, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('assignedTo: $assignedTo, ')
          ..write('customer: $customer')
          ..write(')'))
        .toString();
  }
}

class $ToolsTable extends Tools with TableInfo<$ToolsTable, Tool> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ToolsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isAvailableMeta = const VerificationMeta(
    'isAvailable',
  );
  @override
  late final GeneratedColumn<bool> isAvailable = GeneratedColumn<bool>(
    'is_available',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_available" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _managedByMeta = const VerificationMeta(
    'managedBy',
  );
  @override
  late final GeneratedColumn<int> managedBy = GeneratedColumn<int>(
    'managed_by',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    isAvailable,
    managedBy,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tools';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tool> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('is_available')) {
      context.handle(
        _isAvailableMeta,
        isAvailable.isAcceptableOrUnknown(
          data['is_available']!,
          _isAvailableMeta,
        ),
      );
    }
    if (data.containsKey('managed_by')) {
      context.handle(
        _managedByMeta,
        managedBy.isAcceptableOrUnknown(data['managed_by']!, _managedByMeta),
      );
    } else if (isInserting) {
      context.missing(_managedByMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tool map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tool(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      isAvailable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_available'],
      )!,
      managedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}managed_by'],
      )!,
    );
  }

  @override
  $ToolsTable createAlias(String alias) {
    return $ToolsTable(attachedDatabase, alias);
  }
}

class Tool extends DataClass implements Insertable<Tool> {
  final int id;
  final String name;
  final String? description;
  final bool isAvailable;
  final int managedBy;
  const Tool({
    required this.id,
    required this.name,
    this.description,
    required this.isAvailable,
    required this.managedBy,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['is_available'] = Variable<bool>(isAvailable);
    map['managed_by'] = Variable<int>(managedBy);
    return map;
  }

  ToolsCompanion toCompanion(bool nullToAbsent) {
    return ToolsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      isAvailable: Value(isAvailable),
      managedBy: Value(managedBy),
    );
  }

  factory Tool.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tool(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      isAvailable: serializer.fromJson<bool>(json['isAvailable']),
      managedBy: serializer.fromJson<int>(json['managedBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'isAvailable': serializer.toJson<bool>(isAvailable),
      'managedBy': serializer.toJson<int>(managedBy),
    };
  }

  Tool copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    bool? isAvailable,
    int? managedBy,
  }) => Tool(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    isAvailable: isAvailable ?? this.isAvailable,
    managedBy: managedBy ?? this.managedBy,
  );
  Tool copyWithCompanion(ToolsCompanion data) {
    return Tool(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      isAvailable: data.isAvailable.present
          ? data.isAvailable.value
          : this.isAvailable,
      managedBy: data.managedBy.present ? data.managedBy.value : this.managedBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tool(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isAvailable: $isAvailable, ')
          ..write('managedBy: $managedBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, isAvailable, managedBy);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tool &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.isAvailable == this.isAvailable &&
          other.managedBy == this.managedBy);
}

class ToolsCompanion extends UpdateCompanion<Tool> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<bool> isAvailable;
  final Value<int> managedBy;
  const ToolsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.isAvailable = const Value.absent(),
    this.managedBy = const Value.absent(),
  });
  ToolsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.isAvailable = const Value.absent(),
    required int managedBy,
  }) : name = Value(name),
       managedBy = Value(managedBy);
  static Insertable<Tool> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<bool>? isAvailable,
    Expression<int>? managedBy,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (isAvailable != null) 'is_available': isAvailable,
      if (managedBy != null) 'managed_by': managedBy,
    });
  }

  ToolsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<bool>? isAvailable,
    Value<int>? managedBy,
  }) {
    return ToolsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      isAvailable: isAvailable ?? this.isAvailable,
      managedBy: managedBy ?? this.managedBy,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isAvailable.present) {
      map['is_available'] = Variable<bool>(isAvailable.value);
    }
    if (managedBy.present) {
      map['managed_by'] = Variable<int>(managedBy.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ToolsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isAvailable: $isAvailable, ')
          ..write('managedBy: $managedBy')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isFlaggedMeta = const VerificationMeta(
    'isFlagged',
  );
  @override
  late final GeneratedColumn<bool> isFlagged = GeneratedColumn<bool>(
    'is_flagged',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_flagged" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _reasonForFlagMeta = const VerificationMeta(
    'reasonForFlag',
  );
  @override
  late final GeneratedColumn<String> reasonForFlag = GeneratedColumn<String>(
    'reason_for_flag',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _assignedToMeta = const VerificationMeta(
    'assignedTo',
  );
  @override
  late final GeneratedColumn<int> assignedTo = GeneratedColumn<int>(
    'assigned_to',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    dueDate,
    isCompleted,
    isFlagged,
    reasonForFlag,
    assignedTo,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Task> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('is_flagged')) {
      context.handle(
        _isFlaggedMeta,
        isFlagged.isAcceptableOrUnknown(data['is_flagged']!, _isFlaggedMeta),
      );
    }
    if (data.containsKey('reason_for_flag')) {
      context.handle(
        _reasonForFlagMeta,
        reasonForFlag.isAcceptableOrUnknown(
          data['reason_for_flag']!,
          _reasonForFlagMeta,
        ),
      );
    }
    if (data.containsKey('assigned_to')) {
      context.handle(
        _assignedToMeta,
        assignedTo.isAcceptableOrUnknown(data['assigned_to']!, _assignedToMeta),
      );
    } else if (isInserting) {
      context.missing(_assignedToMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Task(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      ),
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
      isFlagged: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_flagged'],
      )!,
      reasonForFlag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason_for_flag'],
      ),
      assignedTo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}assigned_to'],
      )!,
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class Task extends DataClass implements Insertable<Task> {
  final int id;
  final String title;
  final String? description;
  final DateTime? dueDate;
  final bool isCompleted;
  final bool isFlagged;
  final String? reasonForFlag;
  final int assignedTo;
  const Task({
    required this.id,
    required this.title,
    this.description,
    this.dueDate,
    required this.isCompleted,
    required this.isFlagged,
    this.reasonForFlag,
    required this.assignedTo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    map['is_completed'] = Variable<bool>(isCompleted);
    map['is_flagged'] = Variable<bool>(isFlagged);
    if (!nullToAbsent || reasonForFlag != null) {
      map['reason_for_flag'] = Variable<String>(reasonForFlag);
    }
    map['assigned_to'] = Variable<int>(assignedTo);
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      isCompleted: Value(isCompleted),
      isFlagged: Value(isFlagged),
      reasonForFlag: reasonForFlag == null && nullToAbsent
          ? const Value.absent()
          : Value(reasonForFlag),
      assignedTo: Value(assignedTo),
    );
  }

  factory Task.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      isFlagged: serializer.fromJson<bool>(json['isFlagged']),
      reasonForFlag: serializer.fromJson<String?>(json['reasonForFlag']),
      assignedTo: serializer.fromJson<int>(json['assignedTo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'isFlagged': serializer.toJson<bool>(isFlagged),
      'reasonForFlag': serializer.toJson<String?>(reasonForFlag),
      'assignedTo': serializer.toJson<int>(assignedTo),
    };
  }

  Task copyWith({
    int? id,
    String? title,
    Value<String?> description = const Value.absent(),
    Value<DateTime?> dueDate = const Value.absent(),
    bool? isCompleted,
    bool? isFlagged,
    Value<String?> reasonForFlag = const Value.absent(),
    int? assignedTo,
  }) => Task(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    dueDate: dueDate.present ? dueDate.value : this.dueDate,
    isCompleted: isCompleted ?? this.isCompleted,
    isFlagged: isFlagged ?? this.isFlagged,
    reasonForFlag: reasonForFlag.present
        ? reasonForFlag.value
        : this.reasonForFlag,
    assignedTo: assignedTo ?? this.assignedTo,
  );
  Task copyWithCompanion(TasksCompanion data) {
    return Task(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      isFlagged: data.isFlagged.present ? data.isFlagged.value : this.isFlagged,
      reasonForFlag: data.reasonForFlag.present
          ? data.reasonForFlag.value
          : this.reasonForFlag,
      assignedTo: data.assignedTo.present
          ? data.assignedTo.value
          : this.assignedTo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('dueDate: $dueDate, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('isFlagged: $isFlagged, ')
          ..write('reasonForFlag: $reasonForFlag, ')
          ..write('assignedTo: $assignedTo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    dueDate,
    isCompleted,
    isFlagged,
    reasonForFlag,
    assignedTo,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.dueDate == this.dueDate &&
          other.isCompleted == this.isCompleted &&
          other.isFlagged == this.isFlagged &&
          other.reasonForFlag == this.reasonForFlag &&
          other.assignedTo == this.assignedTo);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<DateTime?> dueDate;
  final Value<bool> isCompleted;
  final Value<bool> isFlagged;
  final Value<String?> reasonForFlag;
  final Value<int> assignedTo;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.isFlagged = const Value.absent(),
    this.reasonForFlag = const Value.absent(),
    this.assignedTo = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.isFlagged = const Value.absent(),
    this.reasonForFlag = const Value.absent(),
    required int assignedTo,
  }) : title = Value(title),
       assignedTo = Value(assignedTo);
  static Insertable<Task> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? dueDate,
    Expression<bool>? isCompleted,
    Expression<bool>? isFlagged,
    Expression<String>? reasonForFlag,
    Expression<int>? assignedTo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (dueDate != null) 'due_date': dueDate,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (isFlagged != null) 'is_flagged': isFlagged,
      if (reasonForFlag != null) 'reason_for_flag': reasonForFlag,
      if (assignedTo != null) 'assigned_to': assignedTo,
    });
  }

  TasksCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String?>? description,
    Value<DateTime?>? dueDate,
    Value<bool>? isCompleted,
    Value<bool>? isFlagged,
    Value<String?>? reasonForFlag,
    Value<int>? assignedTo,
  }) {
    return TasksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
      isFlagged: isFlagged ?? this.isFlagged,
      reasonForFlag: reasonForFlag ?? this.reasonForFlag,
      assignedTo: assignedTo ?? this.assignedTo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (isFlagged.present) {
      map['is_flagged'] = Variable<bool>(isFlagged.value);
    }
    if (reasonForFlag.present) {
      map['reason_for_flag'] = Variable<String>(reasonForFlag.value);
    }
    if (assignedTo.present) {
      map['assigned_to'] = Variable<int>(assignedTo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('dueDate: $dueDate, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('isFlagged: $isFlagged, ')
          ..write('reasonForFlag: $reasonForFlag, ')
          ..write('assignedTo: $assignedTo')
          ..write(')'))
        .toString();
  }
}

class $ComplaintTable extends Complaint
    with TableInfo<$ComplaintTable, ComplaintData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ComplaintTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reportedAtMeta = const VerificationMeta(
    'reportedAt',
  );
  @override
  late final GeneratedColumn<DateTime> reportedAt = GeneratedColumn<DateTime>(
    'reported_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isResolvedMeta = const VerificationMeta(
    'isResolved',
  );
  @override
  late final GeneratedColumn<bool> isResolved = GeneratedColumn<bool>(
    'is_resolved',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_resolved" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _reportedByUserMeta = const VerificationMeta(
    'reportedByUser',
  );
  @override
  late final GeneratedColumn<int> reportedByUser = GeneratedColumn<int>(
    'reported_by_user',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _assignedToMeta = const VerificationMeta(
    'assignedTo',
  );
  @override
  late final GeneratedColumn<int> assignedTo = GeneratedColumn<int>(
    'assigned_to',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _reportedByCustomerMeta =
      const VerificationMeta('reportedByCustomer');
  @override
  late final GeneratedColumn<int> reportedByCustomer = GeneratedColumn<int>(
    'reported_by_customer',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customers (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    reportedAt,
    isResolved,
    reportedByUser,
    assignedTo,
    reportedByCustomer,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'complaint';
  @override
  VerificationContext validateIntegrity(
    Insertable<ComplaintData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('reported_at')) {
      context.handle(
        _reportedAtMeta,
        reportedAt.isAcceptableOrUnknown(data['reported_at']!, _reportedAtMeta),
      );
    }
    if (data.containsKey('is_resolved')) {
      context.handle(
        _isResolvedMeta,
        isResolved.isAcceptableOrUnknown(data['is_resolved']!, _isResolvedMeta),
      );
    }
    if (data.containsKey('reported_by_user')) {
      context.handle(
        _reportedByUserMeta,
        reportedByUser.isAcceptableOrUnknown(
          data['reported_by_user']!,
          _reportedByUserMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reportedByUserMeta);
    }
    if (data.containsKey('assigned_to')) {
      context.handle(
        _assignedToMeta,
        assignedTo.isAcceptableOrUnknown(data['assigned_to']!, _assignedToMeta),
      );
    } else if (isInserting) {
      context.missing(_assignedToMeta);
    }
    if (data.containsKey('reported_by_customer')) {
      context.handle(
        _reportedByCustomerMeta,
        reportedByCustomer.isAcceptableOrUnknown(
          data['reported_by_customer']!,
          _reportedByCustomerMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reportedByCustomerMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ComplaintData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ComplaintData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      reportedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}reported_at'],
      )!,
      isResolved: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_resolved'],
      )!,
      reportedByUser: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reported_by_user'],
      )!,
      assignedTo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}assigned_to'],
      )!,
      reportedByCustomer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reported_by_customer'],
      )!,
    );
  }

  @override
  $ComplaintTable createAlias(String alias) {
    return $ComplaintTable(attachedDatabase, alias);
  }
}

class ComplaintData extends DataClass implements Insertable<ComplaintData> {
  final int id;
  final String title;
  final String? description;
  final DateTime reportedAt;
  final bool isResolved;
  final int reportedByUser;
  final int assignedTo;
  final int reportedByCustomer;
  const ComplaintData({
    required this.id,
    required this.title,
    this.description,
    required this.reportedAt,
    required this.isResolved,
    required this.reportedByUser,
    required this.assignedTo,
    required this.reportedByCustomer,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['reported_at'] = Variable<DateTime>(reportedAt);
    map['is_resolved'] = Variable<bool>(isResolved);
    map['reported_by_user'] = Variable<int>(reportedByUser);
    map['assigned_to'] = Variable<int>(assignedTo);
    map['reported_by_customer'] = Variable<int>(reportedByCustomer);
    return map;
  }

  ComplaintCompanion toCompanion(bool nullToAbsent) {
    return ComplaintCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      reportedAt: Value(reportedAt),
      isResolved: Value(isResolved),
      reportedByUser: Value(reportedByUser),
      assignedTo: Value(assignedTo),
      reportedByCustomer: Value(reportedByCustomer),
    );
  }

  factory ComplaintData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ComplaintData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      reportedAt: serializer.fromJson<DateTime>(json['reportedAt']),
      isResolved: serializer.fromJson<bool>(json['isResolved']),
      reportedByUser: serializer.fromJson<int>(json['reportedByUser']),
      assignedTo: serializer.fromJson<int>(json['assignedTo']),
      reportedByCustomer: serializer.fromJson<int>(json['reportedByCustomer']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'reportedAt': serializer.toJson<DateTime>(reportedAt),
      'isResolved': serializer.toJson<bool>(isResolved),
      'reportedByUser': serializer.toJson<int>(reportedByUser),
      'assignedTo': serializer.toJson<int>(assignedTo),
      'reportedByCustomer': serializer.toJson<int>(reportedByCustomer),
    };
  }

  ComplaintData copyWith({
    int? id,
    String? title,
    Value<String?> description = const Value.absent(),
    DateTime? reportedAt,
    bool? isResolved,
    int? reportedByUser,
    int? assignedTo,
    int? reportedByCustomer,
  }) => ComplaintData(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    reportedAt: reportedAt ?? this.reportedAt,
    isResolved: isResolved ?? this.isResolved,
    reportedByUser: reportedByUser ?? this.reportedByUser,
    assignedTo: assignedTo ?? this.assignedTo,
    reportedByCustomer: reportedByCustomer ?? this.reportedByCustomer,
  );
  ComplaintData copyWithCompanion(ComplaintCompanion data) {
    return ComplaintData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      reportedAt: data.reportedAt.present
          ? data.reportedAt.value
          : this.reportedAt,
      isResolved: data.isResolved.present
          ? data.isResolved.value
          : this.isResolved,
      reportedByUser: data.reportedByUser.present
          ? data.reportedByUser.value
          : this.reportedByUser,
      assignedTo: data.assignedTo.present
          ? data.assignedTo.value
          : this.assignedTo,
      reportedByCustomer: data.reportedByCustomer.present
          ? data.reportedByCustomer.value
          : this.reportedByCustomer,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ComplaintData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('reportedAt: $reportedAt, ')
          ..write('isResolved: $isResolved, ')
          ..write('reportedByUser: $reportedByUser, ')
          ..write('assignedTo: $assignedTo, ')
          ..write('reportedByCustomer: $reportedByCustomer')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    reportedAt,
    isResolved,
    reportedByUser,
    assignedTo,
    reportedByCustomer,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ComplaintData &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.reportedAt == this.reportedAt &&
          other.isResolved == this.isResolved &&
          other.reportedByUser == this.reportedByUser &&
          other.assignedTo == this.assignedTo &&
          other.reportedByCustomer == this.reportedByCustomer);
}

class ComplaintCompanion extends UpdateCompanion<ComplaintData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<DateTime> reportedAt;
  final Value<bool> isResolved;
  final Value<int> reportedByUser;
  final Value<int> assignedTo;
  final Value<int> reportedByCustomer;
  const ComplaintCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.reportedAt = const Value.absent(),
    this.isResolved = const Value.absent(),
    this.reportedByUser = const Value.absent(),
    this.assignedTo = const Value.absent(),
    this.reportedByCustomer = const Value.absent(),
  });
  ComplaintCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    this.reportedAt = const Value.absent(),
    this.isResolved = const Value.absent(),
    required int reportedByUser,
    required int assignedTo,
    required int reportedByCustomer,
  }) : title = Value(title),
       reportedByUser = Value(reportedByUser),
       assignedTo = Value(assignedTo),
       reportedByCustomer = Value(reportedByCustomer);
  static Insertable<ComplaintData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? reportedAt,
    Expression<bool>? isResolved,
    Expression<int>? reportedByUser,
    Expression<int>? assignedTo,
    Expression<int>? reportedByCustomer,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (reportedAt != null) 'reported_at': reportedAt,
      if (isResolved != null) 'is_resolved': isResolved,
      if (reportedByUser != null) 'reported_by_user': reportedByUser,
      if (assignedTo != null) 'assigned_to': assignedTo,
      if (reportedByCustomer != null)
        'reported_by_customer': reportedByCustomer,
    });
  }

  ComplaintCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String?>? description,
    Value<DateTime>? reportedAt,
    Value<bool>? isResolved,
    Value<int>? reportedByUser,
    Value<int>? assignedTo,
    Value<int>? reportedByCustomer,
  }) {
    return ComplaintCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      reportedAt: reportedAt ?? this.reportedAt,
      isResolved: isResolved ?? this.isResolved,
      reportedByUser: reportedByUser ?? this.reportedByUser,
      assignedTo: assignedTo ?? this.assignedTo,
      reportedByCustomer: reportedByCustomer ?? this.reportedByCustomer,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (reportedAt.present) {
      map['reported_at'] = Variable<DateTime>(reportedAt.value);
    }
    if (isResolved.present) {
      map['is_resolved'] = Variable<bool>(isResolved.value);
    }
    if (reportedByUser.present) {
      map['reported_by_user'] = Variable<int>(reportedByUser.value);
    }
    if (assignedTo.present) {
      map['assigned_to'] = Variable<int>(assignedTo.value);
    }
    if (reportedByCustomer.present) {
      map['reported_by_customer'] = Variable<int>(reportedByCustomer.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ComplaintCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('reportedAt: $reportedAt, ')
          ..write('isResolved: $isResolved, ')
          ..write('reportedByUser: $reportedByUser, ')
          ..write('assignedTo: $assignedTo, ')
          ..write('reportedByCustomer: $reportedByCustomer')
          ..write(')'))
        .toString();
  }
}

class $InjuryTable extends Injury with TableInfo<$InjuryTable, InjuryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InjuryTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isResolvedMeta = const VerificationMeta(
    'isResolved',
  );
  @override
  late final GeneratedColumn<bool> isResolved = GeneratedColumn<bool>(
    'is_resolved',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_resolved" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _reportedByUserMeta = const VerificationMeta(
    'reportedByUser',
  );
  @override
  late final GeneratedColumn<int> reportedByUser = GeneratedColumn<int>(
    'reported_by_user',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _assignedToMeta = const VerificationMeta(
    'assignedTo',
  );
  @override
  late final GeneratedColumn<int> assignedTo = GeneratedColumn<int>(
    'assigned_to',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _reportedByCustomerMeta =
      const VerificationMeta('reportedByCustomer');
  @override
  late final GeneratedColumn<int> reportedByCustomer = GeneratedColumn<int>(
    'reported_by_customer',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customers (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    occurredAt,
    isResolved,
    reportedByUser,
    assignedTo,
    reportedByCustomer,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'injury';
  @override
  VerificationContext validateIntegrity(
    Insertable<InjuryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    }
    if (data.containsKey('is_resolved')) {
      context.handle(
        _isResolvedMeta,
        isResolved.isAcceptableOrUnknown(data['is_resolved']!, _isResolvedMeta),
      );
    }
    if (data.containsKey('reported_by_user')) {
      context.handle(
        _reportedByUserMeta,
        reportedByUser.isAcceptableOrUnknown(
          data['reported_by_user']!,
          _reportedByUserMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reportedByUserMeta);
    }
    if (data.containsKey('assigned_to')) {
      context.handle(
        _assignedToMeta,
        assignedTo.isAcceptableOrUnknown(data['assigned_to']!, _assignedToMeta),
      );
    } else if (isInserting) {
      context.missing(_assignedToMeta);
    }
    if (data.containsKey('reported_by_customer')) {
      context.handle(
        _reportedByCustomerMeta,
        reportedByCustomer.isAcceptableOrUnknown(
          data['reported_by_customer']!,
          _reportedByCustomerMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reportedByCustomerMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InjuryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InjuryData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
      isResolved: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_resolved'],
      )!,
      reportedByUser: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reported_by_user'],
      )!,
      assignedTo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}assigned_to'],
      )!,
      reportedByCustomer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reported_by_customer'],
      )!,
    );
  }

  @override
  $InjuryTable createAlias(String alias) {
    return $InjuryTable(attachedDatabase, alias);
  }
}

class InjuryData extends DataClass implements Insertable<InjuryData> {
  final int id;
  final String title;
  final String? description;
  final DateTime occurredAt;
  final bool isResolved;
  final int reportedByUser;
  final int assignedTo;
  final int reportedByCustomer;
  const InjuryData({
    required this.id,
    required this.title,
    this.description,
    required this.occurredAt,
    required this.isResolved,
    required this.reportedByUser,
    required this.assignedTo,
    required this.reportedByCustomer,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    map['is_resolved'] = Variable<bool>(isResolved);
    map['reported_by_user'] = Variable<int>(reportedByUser);
    map['assigned_to'] = Variable<int>(assignedTo);
    map['reported_by_customer'] = Variable<int>(reportedByCustomer);
    return map;
  }

  InjuryCompanion toCompanion(bool nullToAbsent) {
    return InjuryCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      occurredAt: Value(occurredAt),
      isResolved: Value(isResolved),
      reportedByUser: Value(reportedByUser),
      assignedTo: Value(assignedTo),
      reportedByCustomer: Value(reportedByCustomer),
    );
  }

  factory InjuryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InjuryData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      isResolved: serializer.fromJson<bool>(json['isResolved']),
      reportedByUser: serializer.fromJson<int>(json['reportedByUser']),
      assignedTo: serializer.fromJson<int>(json['assignedTo']),
      reportedByCustomer: serializer.fromJson<int>(json['reportedByCustomer']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'isResolved': serializer.toJson<bool>(isResolved),
      'reportedByUser': serializer.toJson<int>(reportedByUser),
      'assignedTo': serializer.toJson<int>(assignedTo),
      'reportedByCustomer': serializer.toJson<int>(reportedByCustomer),
    };
  }

  InjuryData copyWith({
    int? id,
    String? title,
    Value<String?> description = const Value.absent(),
    DateTime? occurredAt,
    bool? isResolved,
    int? reportedByUser,
    int? assignedTo,
    int? reportedByCustomer,
  }) => InjuryData(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    occurredAt: occurredAt ?? this.occurredAt,
    isResolved: isResolved ?? this.isResolved,
    reportedByUser: reportedByUser ?? this.reportedByUser,
    assignedTo: assignedTo ?? this.assignedTo,
    reportedByCustomer: reportedByCustomer ?? this.reportedByCustomer,
  );
  InjuryData copyWithCompanion(InjuryCompanion data) {
    return InjuryData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
      isResolved: data.isResolved.present
          ? data.isResolved.value
          : this.isResolved,
      reportedByUser: data.reportedByUser.present
          ? data.reportedByUser.value
          : this.reportedByUser,
      assignedTo: data.assignedTo.present
          ? data.assignedTo.value
          : this.assignedTo,
      reportedByCustomer: data.reportedByCustomer.present
          ? data.reportedByCustomer.value
          : this.reportedByCustomer,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InjuryData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('isResolved: $isResolved, ')
          ..write('reportedByUser: $reportedByUser, ')
          ..write('assignedTo: $assignedTo, ')
          ..write('reportedByCustomer: $reportedByCustomer')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    occurredAt,
    isResolved,
    reportedByUser,
    assignedTo,
    reportedByCustomer,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InjuryData &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.occurredAt == this.occurredAt &&
          other.isResolved == this.isResolved &&
          other.reportedByUser == this.reportedByUser &&
          other.assignedTo == this.assignedTo &&
          other.reportedByCustomer == this.reportedByCustomer);
}

class InjuryCompanion extends UpdateCompanion<InjuryData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<DateTime> occurredAt;
  final Value<bool> isResolved;
  final Value<int> reportedByUser;
  final Value<int> assignedTo;
  final Value<int> reportedByCustomer;
  const InjuryCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.isResolved = const Value.absent(),
    this.reportedByUser = const Value.absent(),
    this.assignedTo = const Value.absent(),
    this.reportedByCustomer = const Value.absent(),
  });
  InjuryCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.isResolved = const Value.absent(),
    required int reportedByUser,
    required int assignedTo,
    required int reportedByCustomer,
  }) : title = Value(title),
       reportedByUser = Value(reportedByUser),
       assignedTo = Value(assignedTo),
       reportedByCustomer = Value(reportedByCustomer);
  static Insertable<InjuryData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? occurredAt,
    Expression<bool>? isResolved,
    Expression<int>? reportedByUser,
    Expression<int>? assignedTo,
    Expression<int>? reportedByCustomer,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (isResolved != null) 'is_resolved': isResolved,
      if (reportedByUser != null) 'reported_by_user': reportedByUser,
      if (assignedTo != null) 'assigned_to': assignedTo,
      if (reportedByCustomer != null)
        'reported_by_customer': reportedByCustomer,
    });
  }

  InjuryCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String?>? description,
    Value<DateTime>? occurredAt,
    Value<bool>? isResolved,
    Value<int>? reportedByUser,
    Value<int>? assignedTo,
    Value<int>? reportedByCustomer,
  }) {
    return InjuryCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      occurredAt: occurredAt ?? this.occurredAt,
      isResolved: isResolved ?? this.isResolved,
      reportedByUser: reportedByUser ?? this.reportedByUser,
      assignedTo: assignedTo ?? this.assignedTo,
      reportedByCustomer: reportedByCustomer ?? this.reportedByCustomer,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (isResolved.present) {
      map['is_resolved'] = Variable<bool>(isResolved.value);
    }
    if (reportedByUser.present) {
      map['reported_by_user'] = Variable<int>(reportedByUser.value);
    }
    if (assignedTo.present) {
      map['assigned_to'] = Variable<int>(assignedTo.value);
    }
    if (reportedByCustomer.present) {
      map['reported_by_customer'] = Variable<int>(reportedByCustomer.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InjuryCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('isResolved: $isResolved, ')
          ..write('reportedByUser: $reportedByUser, ')
          ..write('assignedTo: $assignedTo, ')
          ..write('reportedByCustomer: $reportedByCustomer')
          ..write(')'))
        .toString();
  }
}

class $DocumentTable extends Document
    with TableInfo<$DocumentTable, DocumentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _uploadedAtMeta = const VerificationMeta(
    'uploadedAt',
  );
  @override
  late final GeneratedColumn<DateTime> uploadedAt = GeneratedColumn<DateTime>(
    'uploaded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _uploadedByMeta = const VerificationMeta(
    'uploadedBy',
  );
  @override
  late final GeneratedColumn<int> uploadedBy = GeneratedColumn<int>(
    'uploaded_by',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customers (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _jobIdMeta = const VerificationMeta('jobId');
  @override
  late final GeneratedColumn<int> jobId = GeneratedColumn<int>(
    'job_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES jobs (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    filePath,
    uploadedAt,
    uploadedBy,
    customerId,
    jobId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'document';
  @override
  VerificationContext validateIntegrity(
    Insertable<DocumentData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('uploaded_at')) {
      context.handle(
        _uploadedAtMeta,
        uploadedAt.isAcceptableOrUnknown(data['uploaded_at']!, _uploadedAtMeta),
      );
    }
    if (data.containsKey('uploaded_by')) {
      context.handle(
        _uploadedByMeta,
        uploadedBy.isAcceptableOrUnknown(data['uploaded_by']!, _uploadedByMeta),
      );
    } else if (isInserting) {
      context.missing(_uploadedByMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('job_id')) {
      context.handle(
        _jobIdMeta,
        jobId.isAcceptableOrUnknown(data['job_id']!, _jobIdMeta),
      );
    } else if (isInserting) {
      context.missing(_jobIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DocumentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DocumentData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      uploadedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}uploaded_at'],
      )!,
      uploadedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}uploaded_by'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      )!,
      jobId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}job_id'],
      )!,
    );
  }

  @override
  $DocumentTable createAlias(String alias) {
    return $DocumentTable(attachedDatabase, alias);
  }
}

class DocumentData extends DataClass implements Insertable<DocumentData> {
  final int id;
  final String title;
  final String filePath;
  final DateTime uploadedAt;
  final int uploadedBy;
  final int customerId;
  final int jobId;
  const DocumentData({
    required this.id,
    required this.title,
    required this.filePath,
    required this.uploadedAt,
    required this.uploadedBy,
    required this.customerId,
    required this.jobId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['file_path'] = Variable<String>(filePath);
    map['uploaded_at'] = Variable<DateTime>(uploadedAt);
    map['uploaded_by'] = Variable<int>(uploadedBy);
    map['customer_id'] = Variable<int>(customerId);
    map['job_id'] = Variable<int>(jobId);
    return map;
  }

  DocumentCompanion toCompanion(bool nullToAbsent) {
    return DocumentCompanion(
      id: Value(id),
      title: Value(title),
      filePath: Value(filePath),
      uploadedAt: Value(uploadedAt),
      uploadedBy: Value(uploadedBy),
      customerId: Value(customerId),
      jobId: Value(jobId),
    );
  }

  factory DocumentData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DocumentData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      filePath: serializer.fromJson<String>(json['filePath']),
      uploadedAt: serializer.fromJson<DateTime>(json['uploadedAt']),
      uploadedBy: serializer.fromJson<int>(json['uploadedBy']),
      customerId: serializer.fromJson<int>(json['customerId']),
      jobId: serializer.fromJson<int>(json['jobId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'filePath': serializer.toJson<String>(filePath),
      'uploadedAt': serializer.toJson<DateTime>(uploadedAt),
      'uploadedBy': serializer.toJson<int>(uploadedBy),
      'customerId': serializer.toJson<int>(customerId),
      'jobId': serializer.toJson<int>(jobId),
    };
  }

  DocumentData copyWith({
    int? id,
    String? title,
    String? filePath,
    DateTime? uploadedAt,
    int? uploadedBy,
    int? customerId,
    int? jobId,
  }) => DocumentData(
    id: id ?? this.id,
    title: title ?? this.title,
    filePath: filePath ?? this.filePath,
    uploadedAt: uploadedAt ?? this.uploadedAt,
    uploadedBy: uploadedBy ?? this.uploadedBy,
    customerId: customerId ?? this.customerId,
    jobId: jobId ?? this.jobId,
  );
  DocumentData copyWithCompanion(DocumentCompanion data) {
    return DocumentData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      uploadedAt: data.uploadedAt.present
          ? data.uploadedAt.value
          : this.uploadedAt,
      uploadedBy: data.uploadedBy.present
          ? data.uploadedBy.value
          : this.uploadedBy,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      jobId: data.jobId.present ? data.jobId.value : this.jobId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DocumentData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('filePath: $filePath, ')
          ..write('uploadedAt: $uploadedAt, ')
          ..write('uploadedBy: $uploadedBy, ')
          ..write('customerId: $customerId, ')
          ..write('jobId: $jobId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    filePath,
    uploadedAt,
    uploadedBy,
    customerId,
    jobId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DocumentData &&
          other.id == this.id &&
          other.title == this.title &&
          other.filePath == this.filePath &&
          other.uploadedAt == this.uploadedAt &&
          other.uploadedBy == this.uploadedBy &&
          other.customerId == this.customerId &&
          other.jobId == this.jobId);
}

class DocumentCompanion extends UpdateCompanion<DocumentData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> filePath;
  final Value<DateTime> uploadedAt;
  final Value<int> uploadedBy;
  final Value<int> customerId;
  final Value<int> jobId;
  const DocumentCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.filePath = const Value.absent(),
    this.uploadedAt = const Value.absent(),
    this.uploadedBy = const Value.absent(),
    this.customerId = const Value.absent(),
    this.jobId = const Value.absent(),
  });
  DocumentCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String filePath,
    this.uploadedAt = const Value.absent(),
    required int uploadedBy,
    required int customerId,
    required int jobId,
  }) : title = Value(title),
       filePath = Value(filePath),
       uploadedBy = Value(uploadedBy),
       customerId = Value(customerId),
       jobId = Value(jobId);
  static Insertable<DocumentData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? filePath,
    Expression<DateTime>? uploadedAt,
    Expression<int>? uploadedBy,
    Expression<int>? customerId,
    Expression<int>? jobId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (filePath != null) 'file_path': filePath,
      if (uploadedAt != null) 'uploaded_at': uploadedAt,
      if (uploadedBy != null) 'uploaded_by': uploadedBy,
      if (customerId != null) 'customer_id': customerId,
      if (jobId != null) 'job_id': jobId,
    });
  }

  DocumentCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? filePath,
    Value<DateTime>? uploadedAt,
    Value<int>? uploadedBy,
    Value<int>? customerId,
    Value<int>? jobId,
  }) {
    return DocumentCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      filePath: filePath ?? this.filePath,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      uploadedBy: uploadedBy ?? this.uploadedBy,
      customerId: customerId ?? this.customerId,
      jobId: jobId ?? this.jobId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (uploadedAt.present) {
      map['uploaded_at'] = Variable<DateTime>(uploadedAt.value);
    }
    if (uploadedBy.present) {
      map['uploaded_by'] = Variable<int>(uploadedBy.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (jobId.present) {
      map['job_id'] = Variable<int>(jobId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('filePath: $filePath, ')
          ..write('uploadedAt: $uploadedAt, ')
          ..write('uploadedBy: $uploadedBy, ')
          ..write('customerId: $customerId, ')
          ..write('jobId: $jobId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CompanyTable company = $CompanyTable(this);
  late final $UsersTable users = $UsersTable(this);
  late final $TemplatesTable templates = $TemplatesTable(this);
  late final $TemplateFieldsTable templateFields = $TemplateFieldsTable(this);
  late final $JobQuotesTable jobQuotes = $JobQuotesTable(this);
  late final $QuoteFieldValuesTable quoteFieldValues = $QuoteFieldValuesTable(
    this,
  );
  late final $CustomersTable customers = $CustomersTable(this);
  late final $JobsTable jobs = $JobsTable(this);
  late final $ToolsTable tools = $ToolsTable(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $ComplaintTable complaint = $ComplaintTable(this);
  late final $InjuryTable injury = $InjuryTable(this);
  late final $DocumentTable document = $DocumentTable(this);
  late final UserDao userDao = UserDao(this as AppDatabase);
  late final TemplatesDao templatesDao = TemplatesDao(this as AppDatabase);
  late final JobQuotesDao jobQuotesDao = JobQuotesDao(this as AppDatabase);
  late final CompanyDao companyDao = CompanyDao(this as AppDatabase);
  late final JobsDao jobsDao = JobsDao(this as AppDatabase);
  late final CustomersDao customersDao = CustomersDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    company,
    users,
    templates,
    templateFields,
    jobQuotes,
    quoteFieldValues,
    customers,
    jobs,
    tools,
    tasks,
    complaint,
    injury,
    document,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'company',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('users', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('templates', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'templates',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('template_fields', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'templates',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('job_quotes', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('job_quotes', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'job_quotes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('quote_field_values', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'template_fields',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('quote_field_values', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('customers', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'job_quotes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('jobs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('jobs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'customers',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('jobs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tools', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tasks', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('complaint', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('complaint', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'customers',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('complaint', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('injury', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('injury', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'customers',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('injury', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('document', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'customers',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('document', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'jobs',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('document', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$CompanyTableCreateCompanionBuilder =
    CompanyCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> address,
    });
typedef $$CompanyTableUpdateCompanionBuilder =
    CompanyCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> address,
    });

final class $$CompanyTableReferences
    extends BaseReferences<_$AppDatabase, $CompanyTable, CompanyData> {
  $$CompanyTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UsersTable, List<User>> _usersRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.users,
    aliasName: $_aliasNameGenerator(db.company.id, db.users.companyId),
  );

  $$UsersTableProcessedTableManager get usersRefs {
    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.companyId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_usersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CompanyTableFilterComposer
    extends Composer<_$AppDatabase, $CompanyTable> {
  $$CompanyTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> usersRefs(
    Expression<bool> Function($$UsersTableFilterComposer f) f,
  ) {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.companyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CompanyTableOrderingComposer
    extends Composer<_$AppDatabase, $CompanyTable> {
  $$CompanyTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CompanyTableAnnotationComposer
    extends Composer<_$AppDatabase, $CompanyTable> {
  $$CompanyTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  Expression<T> usersRefs<T extends Object>(
    Expression<T> Function($$UsersTableAnnotationComposer a) f,
  ) {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.companyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CompanyTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CompanyTable,
          CompanyData,
          $$CompanyTableFilterComposer,
          $$CompanyTableOrderingComposer,
          $$CompanyTableAnnotationComposer,
          $$CompanyTableCreateCompanionBuilder,
          $$CompanyTableUpdateCompanionBuilder,
          (CompanyData, $$CompanyTableReferences),
          CompanyData,
          PrefetchHooks Function({bool usersRefs})
        > {
  $$CompanyTableTableManager(_$AppDatabase db, $CompanyTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CompanyTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CompanyTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CompanyTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> address = const Value.absent(),
              }) => CompanyCompanion(id: id, name: name, address: address),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> address = const Value.absent(),
              }) =>
                  CompanyCompanion.insert(id: id, name: name, address: address),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CompanyTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({usersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (usersRefs) db.users],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (usersRefs)
                    await $_getPrefetchedData<CompanyData, $CompanyTable, User>(
                      currentTable: table,
                      referencedTable: $$CompanyTableReferences._usersRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$CompanyTableReferences(db, table, p0).usersRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.companyId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CompanyTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CompanyTable,
      CompanyData,
      $$CompanyTableFilterComposer,
      $$CompanyTableOrderingComposer,
      $$CompanyTableAnnotationComposer,
      $$CompanyTableCreateCompanionBuilder,
      $$CompanyTableUpdateCompanionBuilder,
      (CompanyData, $$CompanyTableReferences),
      CompanyData,
      PrefetchHooks Function({bool usersRefs})
    >;
typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      required String name,
      Value<int?> age,
      Value<String> role,
      Value<String?> employer,
      Value<String?> permissions,
      Value<bool> canManageUsers,
      required int companyId,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int?> age,
      Value<String> role,
      Value<String?> employer,
      Value<String?> permissions,
      Value<bool> canManageUsers,
      Value<int> companyId,
    });

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CompanyTable _companyIdTable(_$AppDatabase db) => db.company
      .createAlias($_aliasNameGenerator(db.users.companyId, db.company.id));

  $$CompanyTableProcessedTableManager get companyId {
    final $_column = $_itemColumn<int>('company_id')!;

    final manager = $$CompanyTableTableManager(
      $_db,
      $_db.company,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_companyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TemplatesTable, List<Template>>
  _templatesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.templates,
    aliasName: $_aliasNameGenerator(db.users.id, db.templates.createdBy),
  );

  $$TemplatesTableProcessedTableManager get templatesRefs {
    final manager = $$TemplatesTableTableManager(
      $_db,
      $_db.templates,
    ).filter((f) => f.createdBy.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_templatesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$JobQuotesTable, List<JobQuote>>
  _jobQuotesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.jobQuotes,
    aliasName: $_aliasNameGenerator(db.users.id, db.jobQuotes.createdBy),
  );

  $$JobQuotesTableProcessedTableManager get jobQuotesRefs {
    final manager = $$JobQuotesTableTableManager(
      $_db,
      $_db.jobQuotes,
    ).filter((f) => f.createdBy.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_jobQuotesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CustomersTable, List<Customer>>
  _customersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.customers,
    aliasName: $_aliasNameGenerator(db.users.id, db.customers.managedBy),
  );

  $$CustomersTableProcessedTableManager get customersRefs {
    final manager = $$CustomersTableTableManager(
      $_db,
      $_db.customers,
    ).filter((f) => f.managedBy.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_customersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$JobsTable, List<Job>> _jobsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.jobs,
    aliasName: $_aliasNameGenerator(db.users.id, db.jobs.assignedTo),
  );

  $$JobsTableProcessedTableManager get jobsRefs {
    final manager = $$JobsTableTableManager(
      $_db,
      $_db.jobs,
    ).filter((f) => f.assignedTo.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_jobsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ToolsTable, List<Tool>> _toolsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.tools,
    aliasName: $_aliasNameGenerator(db.users.id, db.tools.managedBy),
  );

  $$ToolsTableProcessedTableManager get toolsRefs {
    final manager = $$ToolsTableTableManager(
      $_db,
      $_db.tools,
    ).filter((f) => f.managedBy.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_toolsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TasksTable, List<Task>> _tasksRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.tasks,
    aliasName: $_aliasNameGenerator(db.users.id, db.tasks.assignedTo),
  );

  $$TasksTableProcessedTableManager get tasksRefs {
    final manager = $$TasksTableTableManager(
      $_db,
      $_db.tasks,
    ).filter((f) => f.assignedTo.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_tasksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DocumentTable, List<DocumentData>>
  _documentRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.document,
    aliasName: $_aliasNameGenerator(db.users.id, db.document.uploadedBy),
  );

  $$DocumentTableProcessedTableManager get documentRefs {
    final manager = $$DocumentTableTableManager(
      $_db,
      $_db.document,
    ).filter((f) => f.uploadedBy.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_documentRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get employer => $composableBuilder(
    column: $table.employer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get permissions => $composableBuilder(
    column: $table.permissions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get canManageUsers => $composableBuilder(
    column: $table.canManageUsers,
    builder: (column) => ColumnFilters(column),
  );

  $$CompanyTableFilterComposer get companyId {
    final $$CompanyTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.companyId,
      referencedTable: $db.company,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompanyTableFilterComposer(
            $db: $db,
            $table: $db.company,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> templatesRefs(
    Expression<bool> Function($$TemplatesTableFilterComposer f) f,
  ) {
    final $$TemplatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.templates,
      getReferencedColumn: (t) => t.createdBy,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplatesTableFilterComposer(
            $db: $db,
            $table: $db.templates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> jobQuotesRefs(
    Expression<bool> Function($$JobQuotesTableFilterComposer f) f,
  ) {
    final $$JobQuotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.jobQuotes,
      getReferencedColumn: (t) => t.createdBy,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobQuotesTableFilterComposer(
            $db: $db,
            $table: $db.jobQuotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> customersRefs(
    Expression<bool> Function($$CustomersTableFilterComposer f) f,
  ) {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.managedBy,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableFilterComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> jobsRefs(
    Expression<bool> Function($$JobsTableFilterComposer f) f,
  ) {
    final $$JobsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.assignedTo,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableFilterComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> toolsRefs(
    Expression<bool> Function($$ToolsTableFilterComposer f) f,
  ) {
    final $$ToolsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tools,
      getReferencedColumn: (t) => t.managedBy,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ToolsTableFilterComposer(
            $db: $db,
            $table: $db.tools,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> tasksRefs(
    Expression<bool> Function($$TasksTableFilterComposer f) f,
  ) {
    final $$TasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.assignedTo,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableFilterComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> documentRefs(
    Expression<bool> Function($$DocumentTableFilterComposer f) f,
  ) {
    final $$DocumentTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.document,
      getReferencedColumn: (t) => t.uploadedBy,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentTableFilterComposer(
            $db: $db,
            $table: $db.document,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get employer => $composableBuilder(
    column: $table.employer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get permissions => $composableBuilder(
    column: $table.permissions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get canManageUsers => $composableBuilder(
    column: $table.canManageUsers,
    builder: (column) => ColumnOrderings(column),
  );

  $$CompanyTableOrderingComposer get companyId {
    final $$CompanyTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.companyId,
      referencedTable: $db.company,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompanyTableOrderingComposer(
            $db: $db,
            $table: $db.company,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get employer =>
      $composableBuilder(column: $table.employer, builder: (column) => column);

  GeneratedColumn<String> get permissions => $composableBuilder(
    column: $table.permissions,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get canManageUsers => $composableBuilder(
    column: $table.canManageUsers,
    builder: (column) => column,
  );

  $$CompanyTableAnnotationComposer get companyId {
    final $$CompanyTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.companyId,
      referencedTable: $db.company,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompanyTableAnnotationComposer(
            $db: $db,
            $table: $db.company,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> templatesRefs<T extends Object>(
    Expression<T> Function($$TemplatesTableAnnotationComposer a) f,
  ) {
    final $$TemplatesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.templates,
      getReferencedColumn: (t) => t.createdBy,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplatesTableAnnotationComposer(
            $db: $db,
            $table: $db.templates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> jobQuotesRefs<T extends Object>(
    Expression<T> Function($$JobQuotesTableAnnotationComposer a) f,
  ) {
    final $$JobQuotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.jobQuotes,
      getReferencedColumn: (t) => t.createdBy,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobQuotesTableAnnotationComposer(
            $db: $db,
            $table: $db.jobQuotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> customersRefs<T extends Object>(
    Expression<T> Function($$CustomersTableAnnotationComposer a) f,
  ) {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.managedBy,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> jobsRefs<T extends Object>(
    Expression<T> Function($$JobsTableAnnotationComposer a) f,
  ) {
    final $$JobsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.assignedTo,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableAnnotationComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> toolsRefs<T extends Object>(
    Expression<T> Function($$ToolsTableAnnotationComposer a) f,
  ) {
    final $$ToolsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tools,
      getReferencedColumn: (t) => t.managedBy,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ToolsTableAnnotationComposer(
            $db: $db,
            $table: $db.tools,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> tasksRefs<T extends Object>(
    Expression<T> Function($$TasksTableAnnotationComposer a) f,
  ) {
    final $$TasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.assignedTo,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableAnnotationComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> documentRefs<T extends Object>(
    Expression<T> Function($$DocumentTableAnnotationComposer a) f,
  ) {
    final $$DocumentTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.document,
      getReferencedColumn: (t) => t.uploadedBy,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentTableAnnotationComposer(
            $db: $db,
            $table: $db.document,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, $$UsersTableReferences),
          User,
          PrefetchHooks Function({
            bool companyId,
            bool templatesRefs,
            bool jobQuotesRefs,
            bool customersRefs,
            bool jobsRefs,
            bool toolsRefs,
            bool tasksRefs,
            bool documentRefs,
          })
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int?> age = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String?> employer = const Value.absent(),
                Value<String?> permissions = const Value.absent(),
                Value<bool> canManageUsers = const Value.absent(),
                Value<int> companyId = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                name: name,
                age: age,
                role: role,
                employer: employer,
                permissions: permissions,
                canManageUsers: canManageUsers,
                companyId: companyId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<int?> age = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String?> employer = const Value.absent(),
                Value<String?> permissions = const Value.absent(),
                Value<bool> canManageUsers = const Value.absent(),
                required int companyId,
              }) => UsersCompanion.insert(
                id: id,
                name: name,
                age: age,
                role: role,
                employer: employer,
                permissions: permissions,
                canManageUsers: canManageUsers,
                companyId: companyId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$UsersTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                companyId = false,
                templatesRefs = false,
                jobQuotesRefs = false,
                customersRefs = false,
                jobsRefs = false,
                toolsRefs = false,
                tasksRefs = false,
                documentRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (templatesRefs) db.templates,
                    if (jobQuotesRefs) db.jobQuotes,
                    if (customersRefs) db.customers,
                    if (jobsRefs) db.jobs,
                    if (toolsRefs) db.tools,
                    if (tasksRefs) db.tasks,
                    if (documentRefs) db.document,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (companyId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.companyId,
                                    referencedTable: $$UsersTableReferences
                                        ._companyIdTable(db),
                                    referencedColumn: $$UsersTableReferences
                                        ._companyIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (templatesRefs)
                        await $_getPrefetchedData<User, $UsersTable, Template>(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._templatesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).templatesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.createdBy == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (jobQuotesRefs)
                        await $_getPrefetchedData<User, $UsersTable, JobQuote>(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._jobQuotesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).jobQuotesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.createdBy == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (customersRefs)
                        await $_getPrefetchedData<User, $UsersTable, Customer>(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._customersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).customersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.managedBy == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (jobsRefs)
                        await $_getPrefetchedData<User, $UsersTable, Job>(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._jobsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(db, table, p0).jobsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.assignedTo == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (toolsRefs)
                        await $_getPrefetchedData<User, $UsersTable, Tool>(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._toolsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(db, table, p0).toolsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.managedBy == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (tasksRefs)
                        await $_getPrefetchedData<User, $UsersTable, Task>(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._tasksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(db, table, p0).tasksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.assignedTo == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (documentRefs)
                        await $_getPrefetchedData<
                          User,
                          $UsersTable,
                          DocumentData
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._documentRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).documentRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.uploadedBy == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, $$UsersTableReferences),
      User,
      PrefetchHooks Function({
        bool companyId,
        bool templatesRefs,
        bool jobQuotesRefs,
        bool customersRefs,
        bool jobsRefs,
        bool toolsRefs,
        bool tasksRefs,
        bool documentRefs,
      })
    >;
typedef $$TemplatesTableCreateCompanionBuilder =
    TemplatesCompanion Function({
      Value<int> id,
      required String name,
      required int createdBy,
      Value<DateTime> createdAt,
    });
typedef $$TemplatesTableUpdateCompanionBuilder =
    TemplatesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> createdBy,
      Value<DateTime> createdAt,
    });

final class $$TemplatesTableReferences
    extends BaseReferences<_$AppDatabase, $TemplatesTable, Template> {
  $$TemplatesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _createdByTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.templates.createdBy, db.users.id),
  );

  $$UsersTableProcessedTableManager get createdBy {
    final $_column = $_itemColumn<int>('created_by')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_createdByTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TemplateFieldsTable, List<TemplateField>>
  _templateFieldsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.templateFields,
    aliasName: $_aliasNameGenerator(
      db.templates.id,
      db.templateFields.templateId,
    ),
  );

  $$TemplateFieldsTableProcessedTableManager get templateFieldsRefs {
    final manager = $$TemplateFieldsTableTableManager(
      $_db,
      $_db.templateFields,
    ).filter((f) => f.templateId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_templateFieldsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$JobQuotesTable, List<JobQuote>>
  _jobQuotesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.jobQuotes,
    aliasName: $_aliasNameGenerator(db.templates.id, db.jobQuotes.templateId),
  );

  $$JobQuotesTableProcessedTableManager get jobQuotesRefs {
    final manager = $$JobQuotesTableTableManager(
      $_db,
      $_db.jobQuotes,
    ).filter((f) => f.templateId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_jobQuotesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $TemplatesTable> {
  $$TemplatesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get createdBy {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.createdBy,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> templateFieldsRefs(
    Expression<bool> Function($$TemplateFieldsTableFilterComposer f) f,
  ) {
    final $$TemplateFieldsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.templateFields,
      getReferencedColumn: (t) => t.templateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplateFieldsTableFilterComposer(
            $db: $db,
            $table: $db.templateFields,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> jobQuotesRefs(
    Expression<bool> Function($$JobQuotesTableFilterComposer f) f,
  ) {
    final $$JobQuotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.jobQuotes,
      getReferencedColumn: (t) => t.templateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobQuotesTableFilterComposer(
            $db: $db,
            $table: $db.jobQuotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $TemplatesTable> {
  $$TemplatesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get createdBy {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.createdBy,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TemplatesTable> {
  $$TemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get createdBy {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.createdBy,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> templateFieldsRefs<T extends Object>(
    Expression<T> Function($$TemplateFieldsTableAnnotationComposer a) f,
  ) {
    final $$TemplateFieldsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.templateFields,
      getReferencedColumn: (t) => t.templateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplateFieldsTableAnnotationComposer(
            $db: $db,
            $table: $db.templateFields,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> jobQuotesRefs<T extends Object>(
    Expression<T> Function($$JobQuotesTableAnnotationComposer a) f,
  ) {
    final $$JobQuotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.jobQuotes,
      getReferencedColumn: (t) => t.templateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobQuotesTableAnnotationComposer(
            $db: $db,
            $table: $db.jobQuotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TemplatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TemplatesTable,
          Template,
          $$TemplatesTableFilterComposer,
          $$TemplatesTableOrderingComposer,
          $$TemplatesTableAnnotationComposer,
          $$TemplatesTableCreateCompanionBuilder,
          $$TemplatesTableUpdateCompanionBuilder,
          (Template, $$TemplatesTableReferences),
          Template,
          PrefetchHooks Function({
            bool createdBy,
            bool templateFieldsRefs,
            bool jobQuotesRefs,
          })
        > {
  $$TemplatesTableTableManager(_$AppDatabase db, $TemplatesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TemplatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> createdBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TemplatesCompanion(
                id: id,
                name: name,
                createdBy: createdBy,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required int createdBy,
                Value<DateTime> createdAt = const Value.absent(),
              }) => TemplatesCompanion.insert(
                id: id,
                name: name,
                createdBy: createdBy,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TemplatesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                createdBy = false,
                templateFieldsRefs = false,
                jobQuotesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (templateFieldsRefs) db.templateFields,
                    if (jobQuotesRefs) db.jobQuotes,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (createdBy) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.createdBy,
                                    referencedTable: $$TemplatesTableReferences
                                        ._createdByTable(db),
                                    referencedColumn: $$TemplatesTableReferences
                                        ._createdByTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (templateFieldsRefs)
                        await $_getPrefetchedData<
                          Template,
                          $TemplatesTable,
                          TemplateField
                        >(
                          currentTable: table,
                          referencedTable: $$TemplatesTableReferences
                              ._templateFieldsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TemplatesTableReferences(
                                db,
                                table,
                                p0,
                              ).templateFieldsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.templateId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (jobQuotesRefs)
                        await $_getPrefetchedData<
                          Template,
                          $TemplatesTable,
                          JobQuote
                        >(
                          currentTable: table,
                          referencedTable: $$TemplatesTableReferences
                              ._jobQuotesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TemplatesTableReferences(
                                db,
                                table,
                                p0,
                              ).jobQuotesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.templateId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TemplatesTable,
      Template,
      $$TemplatesTableFilterComposer,
      $$TemplatesTableOrderingComposer,
      $$TemplatesTableAnnotationComposer,
      $$TemplatesTableCreateCompanionBuilder,
      $$TemplatesTableUpdateCompanionBuilder,
      (Template, $$TemplatesTableReferences),
      Template,
      PrefetchHooks Function({
        bool createdBy,
        bool templateFieldsRefs,
        bool jobQuotesRefs,
      })
    >;
typedef $$TemplateFieldsTableCreateCompanionBuilder =
    TemplateFieldsCompanion Function({
      Value<int> id,
      required int templateId,
      required String fieldName,
      Value<bool> isRequired,
      Value<int> sortOrder,
    });
typedef $$TemplateFieldsTableUpdateCompanionBuilder =
    TemplateFieldsCompanion Function({
      Value<int> id,
      Value<int> templateId,
      Value<String> fieldName,
      Value<bool> isRequired,
      Value<int> sortOrder,
    });

final class $$TemplateFieldsTableReferences
    extends BaseReferences<_$AppDatabase, $TemplateFieldsTable, TemplateField> {
  $$TemplateFieldsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TemplatesTable _templateIdTable(_$AppDatabase db) =>
      db.templates.createAlias(
        $_aliasNameGenerator(db.templateFields.templateId, db.templates.id),
      );

  $$TemplatesTableProcessedTableManager get templateId {
    final $_column = $_itemColumn<int>('template_id')!;

    final manager = $$TemplatesTableTableManager(
      $_db,
      $_db.templates,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_templateIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$QuoteFieldValuesTable, List<QuoteFieldValue>>
  _quoteFieldValuesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.quoteFieldValues,
    aliasName: $_aliasNameGenerator(
      db.templateFields.id,
      db.quoteFieldValues.fieldId,
    ),
  );

  $$QuoteFieldValuesTableProcessedTableManager get quoteFieldValuesRefs {
    final manager = $$QuoteFieldValuesTableTableManager(
      $_db,
      $_db.quoteFieldValues,
    ).filter((f) => f.fieldId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _quoteFieldValuesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TemplateFieldsTableFilterComposer
    extends Composer<_$AppDatabase, $TemplateFieldsTable> {
  $$TemplateFieldsTableFilterComposer({
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

  ColumnFilters<String> get fieldName => $composableBuilder(
    column: $table.fieldName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRequired => $composableBuilder(
    column: $table.isRequired,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$TemplatesTableFilterComposer get templateId {
    final $$TemplatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.templates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplatesTableFilterComposer(
            $db: $db,
            $table: $db.templates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> quoteFieldValuesRefs(
    Expression<bool> Function($$QuoteFieldValuesTableFilterComposer f) f,
  ) {
    final $$QuoteFieldValuesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quoteFieldValues,
      getReferencedColumn: (t) => t.fieldId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuoteFieldValuesTableFilterComposer(
            $db: $db,
            $table: $db.quoteFieldValues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TemplateFieldsTableOrderingComposer
    extends Composer<_$AppDatabase, $TemplateFieldsTable> {
  $$TemplateFieldsTableOrderingComposer({
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

  ColumnOrderings<String> get fieldName => $composableBuilder(
    column: $table.fieldName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRequired => $composableBuilder(
    column: $table.isRequired,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$TemplatesTableOrderingComposer get templateId {
    final $$TemplatesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.templates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplatesTableOrderingComposer(
            $db: $db,
            $table: $db.templates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TemplateFieldsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TemplateFieldsTable> {
  $$TemplateFieldsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fieldName =>
      $composableBuilder(column: $table.fieldName, builder: (column) => column);

  GeneratedColumn<bool> get isRequired => $composableBuilder(
    column: $table.isRequired,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$TemplatesTableAnnotationComposer get templateId {
    final $$TemplatesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.templates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplatesTableAnnotationComposer(
            $db: $db,
            $table: $db.templates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> quoteFieldValuesRefs<T extends Object>(
    Expression<T> Function($$QuoteFieldValuesTableAnnotationComposer a) f,
  ) {
    final $$QuoteFieldValuesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quoteFieldValues,
      getReferencedColumn: (t) => t.fieldId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuoteFieldValuesTableAnnotationComposer(
            $db: $db,
            $table: $db.quoteFieldValues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TemplateFieldsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TemplateFieldsTable,
          TemplateField,
          $$TemplateFieldsTableFilterComposer,
          $$TemplateFieldsTableOrderingComposer,
          $$TemplateFieldsTableAnnotationComposer,
          $$TemplateFieldsTableCreateCompanionBuilder,
          $$TemplateFieldsTableUpdateCompanionBuilder,
          (TemplateField, $$TemplateFieldsTableReferences),
          TemplateField,
          PrefetchHooks Function({bool templateId, bool quoteFieldValuesRefs})
        > {
  $$TemplateFieldsTableTableManager(
    _$AppDatabase db,
    $TemplateFieldsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TemplateFieldsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TemplateFieldsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TemplateFieldsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> templateId = const Value.absent(),
                Value<String> fieldName = const Value.absent(),
                Value<bool> isRequired = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => TemplateFieldsCompanion(
                id: id,
                templateId: templateId,
                fieldName: fieldName,
                isRequired: isRequired,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int templateId,
                required String fieldName,
                Value<bool> isRequired = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => TemplateFieldsCompanion.insert(
                id: id,
                templateId: templateId,
                fieldName: fieldName,
                isRequired: isRequired,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TemplateFieldsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({templateId = false, quoteFieldValuesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (quoteFieldValuesRefs) db.quoteFieldValues,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (templateId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.templateId,
                                    referencedTable:
                                        $$TemplateFieldsTableReferences
                                            ._templateIdTable(db),
                                    referencedColumn:
                                        $$TemplateFieldsTableReferences
                                            ._templateIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (quoteFieldValuesRefs)
                        await $_getPrefetchedData<
                          TemplateField,
                          $TemplateFieldsTable,
                          QuoteFieldValue
                        >(
                          currentTable: table,
                          referencedTable: $$TemplateFieldsTableReferences
                              ._quoteFieldValuesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TemplateFieldsTableReferences(
                                db,
                                table,
                                p0,
                              ).quoteFieldValuesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fieldId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TemplateFieldsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TemplateFieldsTable,
      TemplateField,
      $$TemplateFieldsTableFilterComposer,
      $$TemplateFieldsTableOrderingComposer,
      $$TemplateFieldsTableAnnotationComposer,
      $$TemplateFieldsTableCreateCompanionBuilder,
      $$TemplateFieldsTableUpdateCompanionBuilder,
      (TemplateField, $$TemplateFieldsTableReferences),
      TemplateField,
      PrefetchHooks Function({bool templateId, bool quoteFieldValuesRefs})
    >;
typedef $$JobQuotesTableCreateCompanionBuilder =
    JobQuotesCompanion Function({
      Value<int> id,
      required int templateId,
      required String customerName,
      required String customerContact,
      Value<DateTime> quoteDate,
      Value<double> totalAmount,
      required int createdBy,
    });
typedef $$JobQuotesTableUpdateCompanionBuilder =
    JobQuotesCompanion Function({
      Value<int> id,
      Value<int> templateId,
      Value<String> customerName,
      Value<String> customerContact,
      Value<DateTime> quoteDate,
      Value<double> totalAmount,
      Value<int> createdBy,
    });

final class $$JobQuotesTableReferences
    extends BaseReferences<_$AppDatabase, $JobQuotesTable, JobQuote> {
  $$JobQuotesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TemplatesTable _templateIdTable(_$AppDatabase db) =>
      db.templates.createAlias(
        $_aliasNameGenerator(db.jobQuotes.templateId, db.templates.id),
      );

  $$TemplatesTableProcessedTableManager get templateId {
    final $_column = $_itemColumn<int>('template_id')!;

    final manager = $$TemplatesTableTableManager(
      $_db,
      $_db.templates,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_templateIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsersTable _createdByTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.jobQuotes.createdBy, db.users.id),
  );

  $$UsersTableProcessedTableManager get createdBy {
    final $_column = $_itemColumn<int>('created_by')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_createdByTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$QuoteFieldValuesTable, List<QuoteFieldValue>>
  _quoteFieldValuesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.quoteFieldValues,
    aliasName: $_aliasNameGenerator(
      db.jobQuotes.id,
      db.quoteFieldValues.quoteId,
    ),
  );

  $$QuoteFieldValuesTableProcessedTableManager get quoteFieldValuesRefs {
    final manager = $$QuoteFieldValuesTableTableManager(
      $_db,
      $_db.quoteFieldValues,
    ).filter((f) => f.quoteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _quoteFieldValuesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$JobsTable, List<Job>> _jobsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.jobs,
    aliasName: $_aliasNameGenerator(db.jobQuotes.id, db.jobs.quoteId),
  );

  $$JobsTableProcessedTableManager get jobsRefs {
    final manager = $$JobsTableTableManager(
      $_db,
      $_db.jobs,
    ).filter((f) => f.quoteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_jobsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$JobQuotesTableFilterComposer
    extends Composer<_$AppDatabase, $JobQuotesTable> {
  $$JobQuotesTableFilterComposer({
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

  ColumnFilters<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerContact => $composableBuilder(
    column: $table.customerContact,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get quoteDate => $composableBuilder(
    column: $table.quoteDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  $$TemplatesTableFilterComposer get templateId {
    final $$TemplatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.templates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplatesTableFilterComposer(
            $db: $db,
            $table: $db.templates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableFilterComposer get createdBy {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.createdBy,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> quoteFieldValuesRefs(
    Expression<bool> Function($$QuoteFieldValuesTableFilterComposer f) f,
  ) {
    final $$QuoteFieldValuesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quoteFieldValues,
      getReferencedColumn: (t) => t.quoteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuoteFieldValuesTableFilterComposer(
            $db: $db,
            $table: $db.quoteFieldValues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> jobsRefs(
    Expression<bool> Function($$JobsTableFilterComposer f) f,
  ) {
    final $$JobsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.quoteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableFilterComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$JobQuotesTableOrderingComposer
    extends Composer<_$AppDatabase, $JobQuotesTable> {
  $$JobQuotesTableOrderingComposer({
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

  ColumnOrderings<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerContact => $composableBuilder(
    column: $table.customerContact,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get quoteDate => $composableBuilder(
    column: $table.quoteDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  $$TemplatesTableOrderingComposer get templateId {
    final $$TemplatesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.templates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplatesTableOrderingComposer(
            $db: $db,
            $table: $db.templates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableOrderingComposer get createdBy {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.createdBy,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JobQuotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $JobQuotesTable> {
  $$JobQuotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customerContact => $composableBuilder(
    column: $table.customerContact,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get quoteDate =>
      $composableBuilder(column: $table.quoteDate, builder: (column) => column);

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  $$TemplatesTableAnnotationComposer get templateId {
    final $$TemplatesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.templates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplatesTableAnnotationComposer(
            $db: $db,
            $table: $db.templates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableAnnotationComposer get createdBy {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.createdBy,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> quoteFieldValuesRefs<T extends Object>(
    Expression<T> Function($$QuoteFieldValuesTableAnnotationComposer a) f,
  ) {
    final $$QuoteFieldValuesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quoteFieldValues,
      getReferencedColumn: (t) => t.quoteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuoteFieldValuesTableAnnotationComposer(
            $db: $db,
            $table: $db.quoteFieldValues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> jobsRefs<T extends Object>(
    Expression<T> Function($$JobsTableAnnotationComposer a) f,
  ) {
    final $$JobsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.quoteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableAnnotationComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$JobQuotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JobQuotesTable,
          JobQuote,
          $$JobQuotesTableFilterComposer,
          $$JobQuotesTableOrderingComposer,
          $$JobQuotesTableAnnotationComposer,
          $$JobQuotesTableCreateCompanionBuilder,
          $$JobQuotesTableUpdateCompanionBuilder,
          (JobQuote, $$JobQuotesTableReferences),
          JobQuote,
          PrefetchHooks Function({
            bool templateId,
            bool createdBy,
            bool quoteFieldValuesRefs,
            bool jobsRefs,
          })
        > {
  $$JobQuotesTableTableManager(_$AppDatabase db, $JobQuotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JobQuotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JobQuotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JobQuotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> templateId = const Value.absent(),
                Value<String> customerName = const Value.absent(),
                Value<String> customerContact = const Value.absent(),
                Value<DateTime> quoteDate = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<int> createdBy = const Value.absent(),
              }) => JobQuotesCompanion(
                id: id,
                templateId: templateId,
                customerName: customerName,
                customerContact: customerContact,
                quoteDate: quoteDate,
                totalAmount: totalAmount,
                createdBy: createdBy,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int templateId,
                required String customerName,
                required String customerContact,
                Value<DateTime> quoteDate = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                required int createdBy,
              }) => JobQuotesCompanion.insert(
                id: id,
                templateId: templateId,
                customerName: customerName,
                customerContact: customerContact,
                quoteDate: quoteDate,
                totalAmount: totalAmount,
                createdBy: createdBy,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$JobQuotesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                templateId = false,
                createdBy = false,
                quoteFieldValuesRefs = false,
                jobsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (quoteFieldValuesRefs) db.quoteFieldValues,
                    if (jobsRefs) db.jobs,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (templateId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.templateId,
                                    referencedTable: $$JobQuotesTableReferences
                                        ._templateIdTable(db),
                                    referencedColumn: $$JobQuotesTableReferences
                                        ._templateIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (createdBy) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.createdBy,
                                    referencedTable: $$JobQuotesTableReferences
                                        ._createdByTable(db),
                                    referencedColumn: $$JobQuotesTableReferences
                                        ._createdByTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (quoteFieldValuesRefs)
                        await $_getPrefetchedData<
                          JobQuote,
                          $JobQuotesTable,
                          QuoteFieldValue
                        >(
                          currentTable: table,
                          referencedTable: $$JobQuotesTableReferences
                              ._quoteFieldValuesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$JobQuotesTableReferences(
                                db,
                                table,
                                p0,
                              ).quoteFieldValuesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.quoteId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (jobsRefs)
                        await $_getPrefetchedData<
                          JobQuote,
                          $JobQuotesTable,
                          Job
                        >(
                          currentTable: table,
                          referencedTable: $$JobQuotesTableReferences
                              ._jobsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$JobQuotesTableReferences(
                                db,
                                table,
                                p0,
                              ).jobsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.quoteId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$JobQuotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JobQuotesTable,
      JobQuote,
      $$JobQuotesTableFilterComposer,
      $$JobQuotesTableOrderingComposer,
      $$JobQuotesTableAnnotationComposer,
      $$JobQuotesTableCreateCompanionBuilder,
      $$JobQuotesTableUpdateCompanionBuilder,
      (JobQuote, $$JobQuotesTableReferences),
      JobQuote,
      PrefetchHooks Function({
        bool templateId,
        bool createdBy,
        bool quoteFieldValuesRefs,
        bool jobsRefs,
      })
    >;
typedef $$QuoteFieldValuesTableCreateCompanionBuilder =
    QuoteFieldValuesCompanion Function({
      Value<int> id,
      required int quoteId,
      required int fieldId,
      Value<String?> fieldValue,
    });
typedef $$QuoteFieldValuesTableUpdateCompanionBuilder =
    QuoteFieldValuesCompanion Function({
      Value<int> id,
      Value<int> quoteId,
      Value<int> fieldId,
      Value<String?> fieldValue,
    });

final class $$QuoteFieldValuesTableReferences
    extends
        BaseReferences<_$AppDatabase, $QuoteFieldValuesTable, QuoteFieldValue> {
  $$QuoteFieldValuesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $JobQuotesTable _quoteIdTable(_$AppDatabase db) =>
      db.jobQuotes.createAlias(
        $_aliasNameGenerator(db.quoteFieldValues.quoteId, db.jobQuotes.id),
      );

  $$JobQuotesTableProcessedTableManager get quoteId {
    final $_column = $_itemColumn<int>('quote_id')!;

    final manager = $$JobQuotesTableTableManager(
      $_db,
      $_db.jobQuotes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_quoteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TemplateFieldsTable _fieldIdTable(_$AppDatabase db) =>
      db.templateFields.createAlias(
        $_aliasNameGenerator(db.quoteFieldValues.fieldId, db.templateFields.id),
      );

  $$TemplateFieldsTableProcessedTableManager get fieldId {
    final $_column = $_itemColumn<int>('field_id')!;

    final manager = $$TemplateFieldsTableTableManager(
      $_db,
      $_db.templateFields,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fieldIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$QuoteFieldValuesTableFilterComposer
    extends Composer<_$AppDatabase, $QuoteFieldValuesTable> {
  $$QuoteFieldValuesTableFilterComposer({
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

  ColumnFilters<String> get fieldValue => $composableBuilder(
    column: $table.fieldValue,
    builder: (column) => ColumnFilters(column),
  );

  $$JobQuotesTableFilterComposer get quoteId {
    final $$JobQuotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quoteId,
      referencedTable: $db.jobQuotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobQuotesTableFilterComposer(
            $db: $db,
            $table: $db.jobQuotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TemplateFieldsTableFilterComposer get fieldId {
    final $$TemplateFieldsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fieldId,
      referencedTable: $db.templateFields,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplateFieldsTableFilterComposer(
            $db: $db,
            $table: $db.templateFields,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuoteFieldValuesTableOrderingComposer
    extends Composer<_$AppDatabase, $QuoteFieldValuesTable> {
  $$QuoteFieldValuesTableOrderingComposer({
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

  ColumnOrderings<String> get fieldValue => $composableBuilder(
    column: $table.fieldValue,
    builder: (column) => ColumnOrderings(column),
  );

  $$JobQuotesTableOrderingComposer get quoteId {
    final $$JobQuotesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quoteId,
      referencedTable: $db.jobQuotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobQuotesTableOrderingComposer(
            $db: $db,
            $table: $db.jobQuotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TemplateFieldsTableOrderingComposer get fieldId {
    final $$TemplateFieldsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fieldId,
      referencedTable: $db.templateFields,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplateFieldsTableOrderingComposer(
            $db: $db,
            $table: $db.templateFields,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuoteFieldValuesTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuoteFieldValuesTable> {
  $$QuoteFieldValuesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fieldValue => $composableBuilder(
    column: $table.fieldValue,
    builder: (column) => column,
  );

  $$JobQuotesTableAnnotationComposer get quoteId {
    final $$JobQuotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quoteId,
      referencedTable: $db.jobQuotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobQuotesTableAnnotationComposer(
            $db: $db,
            $table: $db.jobQuotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TemplateFieldsTableAnnotationComposer get fieldId {
    final $$TemplateFieldsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fieldId,
      referencedTable: $db.templateFields,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplateFieldsTableAnnotationComposer(
            $db: $db,
            $table: $db.templateFields,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuoteFieldValuesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuoteFieldValuesTable,
          QuoteFieldValue,
          $$QuoteFieldValuesTableFilterComposer,
          $$QuoteFieldValuesTableOrderingComposer,
          $$QuoteFieldValuesTableAnnotationComposer,
          $$QuoteFieldValuesTableCreateCompanionBuilder,
          $$QuoteFieldValuesTableUpdateCompanionBuilder,
          (QuoteFieldValue, $$QuoteFieldValuesTableReferences),
          QuoteFieldValue,
          PrefetchHooks Function({bool quoteId, bool fieldId})
        > {
  $$QuoteFieldValuesTableTableManager(
    _$AppDatabase db,
    $QuoteFieldValuesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuoteFieldValuesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuoteFieldValuesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuoteFieldValuesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> quoteId = const Value.absent(),
                Value<int> fieldId = const Value.absent(),
                Value<String?> fieldValue = const Value.absent(),
              }) => QuoteFieldValuesCompanion(
                id: id,
                quoteId: quoteId,
                fieldId: fieldId,
                fieldValue: fieldValue,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int quoteId,
                required int fieldId,
                Value<String?> fieldValue = const Value.absent(),
              }) => QuoteFieldValuesCompanion.insert(
                id: id,
                quoteId: quoteId,
                fieldId: fieldId,
                fieldValue: fieldValue,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$QuoteFieldValuesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({quoteId = false, fieldId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (quoteId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.quoteId,
                                referencedTable:
                                    $$QuoteFieldValuesTableReferences
                                        ._quoteIdTable(db),
                                referencedColumn:
                                    $$QuoteFieldValuesTableReferences
                                        ._quoteIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (fieldId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.fieldId,
                                referencedTable:
                                    $$QuoteFieldValuesTableReferences
                                        ._fieldIdTable(db),
                                referencedColumn:
                                    $$QuoteFieldValuesTableReferences
                                        ._fieldIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$QuoteFieldValuesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuoteFieldValuesTable,
      QuoteFieldValue,
      $$QuoteFieldValuesTableFilterComposer,
      $$QuoteFieldValuesTableOrderingComposer,
      $$QuoteFieldValuesTableAnnotationComposer,
      $$QuoteFieldValuesTableCreateCompanionBuilder,
      $$QuoteFieldValuesTableUpdateCompanionBuilder,
      (QuoteFieldValue, $$QuoteFieldValuesTableReferences),
      QuoteFieldValue,
      PrefetchHooks Function({bool quoteId, bool fieldId})
    >;
typedef $$CustomersTableCreateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      required String name,
      required String contactInfo,
      Value<String?> address,
      required int managedBy,
    });
typedef $$CustomersTableUpdateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> contactInfo,
      Value<String?> address,
      Value<int> managedBy,
    });

final class $$CustomersTableReferences
    extends BaseReferences<_$AppDatabase, $CustomersTable, Customer> {
  $$CustomersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _managedByTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.customers.managedBy, db.users.id),
  );

  $$UsersTableProcessedTableManager get managedBy {
    final $_column = $_itemColumn<int>('managed_by')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_managedByTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$JobsTable, List<Job>> _jobsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.jobs,
    aliasName: $_aliasNameGenerator(db.customers.id, db.jobs.customer),
  );

  $$JobsTableProcessedTableManager get jobsRefs {
    final manager = $$JobsTableTableManager(
      $_db,
      $_db.jobs,
    ).filter((f) => f.customer.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_jobsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ComplaintTable, List<ComplaintData>>
  _complaintRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.complaint,
    aliasName: $_aliasNameGenerator(
      db.customers.id,
      db.complaint.reportedByCustomer,
    ),
  );

  $$ComplaintTableProcessedTableManager get complaintRefs {
    final manager = $$ComplaintTableTableManager($_db, $_db.complaint).filter(
      (f) => f.reportedByCustomer.id.sqlEquals($_itemColumn<int>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_complaintRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InjuryTable, List<InjuryData>> _injuryRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.injury,
    aliasName: $_aliasNameGenerator(
      db.customers.id,
      db.injury.reportedByCustomer,
    ),
  );

  $$InjuryTableProcessedTableManager get injuryRefs {
    final manager = $$InjuryTableTableManager($_db, $_db.injury).filter(
      (f) => f.reportedByCustomer.id.sqlEquals($_itemColumn<int>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_injuryRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DocumentTable, List<DocumentData>>
  _documentRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.document,
    aliasName: $_aliasNameGenerator(db.customers.id, db.document.customerId),
  );

  $$DocumentTableProcessedTableManager get documentRefs {
    final manager = $$DocumentTableTableManager(
      $_db,
      $_db.document,
    ).filter((f) => f.customerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_documentRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CustomersTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactInfo => $composableBuilder(
    column: $table.contactInfo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get managedBy {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.managedBy,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> jobsRefs(
    Expression<bool> Function($$JobsTableFilterComposer f) f,
  ) {
    final $$JobsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.customer,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableFilterComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> complaintRefs(
    Expression<bool> Function($$ComplaintTableFilterComposer f) f,
  ) {
    final $$ComplaintTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.complaint,
      getReferencedColumn: (t) => t.reportedByCustomer,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ComplaintTableFilterComposer(
            $db: $db,
            $table: $db.complaint,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> injuryRefs(
    Expression<bool> Function($$InjuryTableFilterComposer f) f,
  ) {
    final $$InjuryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.injury,
      getReferencedColumn: (t) => t.reportedByCustomer,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InjuryTableFilterComposer(
            $db: $db,
            $table: $db.injury,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> documentRefs(
    Expression<bool> Function($$DocumentTableFilterComposer f) f,
  ) {
    final $$DocumentTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.document,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentTableFilterComposer(
            $db: $db,
            $table: $db.document,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactInfo => $composableBuilder(
    column: $table.contactInfo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get managedBy {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.managedBy,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get contactInfo => $composableBuilder(
    column: $table.contactInfo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  $$UsersTableAnnotationComposer get managedBy {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.managedBy,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> jobsRefs<T extends Object>(
    Expression<T> Function($$JobsTableAnnotationComposer a) f,
  ) {
    final $$JobsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.customer,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableAnnotationComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> complaintRefs<T extends Object>(
    Expression<T> Function($$ComplaintTableAnnotationComposer a) f,
  ) {
    final $$ComplaintTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.complaint,
      getReferencedColumn: (t) => t.reportedByCustomer,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ComplaintTableAnnotationComposer(
            $db: $db,
            $table: $db.complaint,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> injuryRefs<T extends Object>(
    Expression<T> Function($$InjuryTableAnnotationComposer a) f,
  ) {
    final $$InjuryTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.injury,
      getReferencedColumn: (t) => t.reportedByCustomer,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InjuryTableAnnotationComposer(
            $db: $db,
            $table: $db.injury,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> documentRefs<T extends Object>(
    Expression<T> Function($$DocumentTableAnnotationComposer a) f,
  ) {
    final $$DocumentTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.document,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentTableAnnotationComposer(
            $db: $db,
            $table: $db.document,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomersTable,
          Customer,
          $$CustomersTableFilterComposer,
          $$CustomersTableOrderingComposer,
          $$CustomersTableAnnotationComposer,
          $$CustomersTableCreateCompanionBuilder,
          $$CustomersTableUpdateCompanionBuilder,
          (Customer, $$CustomersTableReferences),
          Customer,
          PrefetchHooks Function({
            bool managedBy,
            bool jobsRefs,
            bool complaintRefs,
            bool injuryRefs,
            bool documentRefs,
          })
        > {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> contactInfo = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<int> managedBy = const Value.absent(),
              }) => CustomersCompanion(
                id: id,
                name: name,
                contactInfo: contactInfo,
                address: address,
                managedBy: managedBy,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String contactInfo,
                Value<String?> address = const Value.absent(),
                required int managedBy,
              }) => CustomersCompanion.insert(
                id: id,
                name: name,
                contactInfo: contactInfo,
                address: address,
                managedBy: managedBy,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CustomersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                managedBy = false,
                jobsRefs = false,
                complaintRefs = false,
                injuryRefs = false,
                documentRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (jobsRefs) db.jobs,
                    if (complaintRefs) db.complaint,
                    if (injuryRefs) db.injury,
                    if (documentRefs) db.document,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (managedBy) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.managedBy,
                                    referencedTable: $$CustomersTableReferences
                                        ._managedByTable(db),
                                    referencedColumn: $$CustomersTableReferences
                                        ._managedByTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (jobsRefs)
                        await $_getPrefetchedData<
                          Customer,
                          $CustomersTable,
                          Job
                        >(
                          currentTable: table,
                          referencedTable: $$CustomersTableReferences
                              ._jobsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CustomersTableReferences(
                                db,
                                table,
                                p0,
                              ).jobsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.customer == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (complaintRefs)
                        await $_getPrefetchedData<
                          Customer,
                          $CustomersTable,
                          ComplaintData
                        >(
                          currentTable: table,
                          referencedTable: $$CustomersTableReferences
                              ._complaintRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CustomersTableReferences(
                                db,
                                table,
                                p0,
                              ).complaintRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.reportedByCustomer == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (injuryRefs)
                        await $_getPrefetchedData<
                          Customer,
                          $CustomersTable,
                          InjuryData
                        >(
                          currentTable: table,
                          referencedTable: $$CustomersTableReferences
                              ._injuryRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CustomersTableReferences(
                                db,
                                table,
                                p0,
                              ).injuryRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.reportedByCustomer == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (documentRefs)
                        await $_getPrefetchedData<
                          Customer,
                          $CustomersTable,
                          DocumentData
                        >(
                          currentTable: table,
                          referencedTable: $$CustomersTableReferences
                              ._documentRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CustomersTableReferences(
                                db,
                                table,
                                p0,
                              ).documentRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.customerId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CustomersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomersTable,
      Customer,
      $$CustomersTableFilterComposer,
      $$CustomersTableOrderingComposer,
      $$CustomersTableAnnotationComposer,
      $$CustomersTableCreateCompanionBuilder,
      $$CustomersTableUpdateCompanionBuilder,
      (Customer, $$CustomersTableReferences),
      Customer,
      PrefetchHooks Function({
        bool managedBy,
        bool jobsRefs,
        bool complaintRefs,
        bool injuryRefs,
        bool documentRefs,
      })
    >;
typedef $$JobsTableCreateCompanionBuilder =
    JobsCompanion Function({
      Value<int> id,
      required int quoteId,
      required String name,
      required String jobStatus,
      Value<DateTime?> startDate,
      Value<DateTime?> endDate,
      required int assignedTo,
      required int customer,
    });
typedef $$JobsTableUpdateCompanionBuilder =
    JobsCompanion Function({
      Value<int> id,
      Value<int> quoteId,
      Value<String> name,
      Value<String> jobStatus,
      Value<DateTime?> startDate,
      Value<DateTime?> endDate,
      Value<int> assignedTo,
      Value<int> customer,
    });

final class $$JobsTableReferences
    extends BaseReferences<_$AppDatabase, $JobsTable, Job> {
  $$JobsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $JobQuotesTable _quoteIdTable(_$AppDatabase db) => db.jobQuotes
      .createAlias($_aliasNameGenerator(db.jobs.quoteId, db.jobQuotes.id));

  $$JobQuotesTableProcessedTableManager get quoteId {
    final $_column = $_itemColumn<int>('quote_id')!;

    final manager = $$JobQuotesTableTableManager(
      $_db,
      $_db.jobQuotes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_quoteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsersTable _assignedToTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.jobs.assignedTo, db.users.id),
  );

  $$UsersTableProcessedTableManager get assignedTo {
    final $_column = $_itemColumn<int>('assigned_to')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_assignedToTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CustomersTable _customerTable(_$AppDatabase db) => db.customers
      .createAlias($_aliasNameGenerator(db.jobs.customer, db.customers.id));

  $$CustomersTableProcessedTableManager get customer {
    final $_column = $_itemColumn<int>('customer')!;

    final manager = $$CustomersTableTableManager(
      $_db,
      $_db.customers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$DocumentTable, List<DocumentData>>
  _documentRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.document,
    aliasName: $_aliasNameGenerator(db.jobs.id, db.document.jobId),
  );

  $$DocumentTableProcessedTableManager get documentRefs {
    final manager = $$DocumentTableTableManager(
      $_db,
      $_db.document,
    ).filter((f) => f.jobId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_documentRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$JobsTableFilterComposer extends Composer<_$AppDatabase, $JobsTable> {
  $$JobsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jobStatus => $composableBuilder(
    column: $table.jobStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  $$JobQuotesTableFilterComposer get quoteId {
    final $$JobQuotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quoteId,
      referencedTable: $db.jobQuotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobQuotesTableFilterComposer(
            $db: $db,
            $table: $db.jobQuotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableFilterComposer get assignedTo {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.assignedTo,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableFilterComposer get customer {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customer,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableFilterComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> documentRefs(
    Expression<bool> Function($$DocumentTableFilterComposer f) f,
  ) {
    final $$DocumentTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.document,
      getReferencedColumn: (t) => t.jobId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentTableFilterComposer(
            $db: $db,
            $table: $db.document,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$JobsTableOrderingComposer extends Composer<_$AppDatabase, $JobsTable> {
  $$JobsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jobStatus => $composableBuilder(
    column: $table.jobStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  $$JobQuotesTableOrderingComposer get quoteId {
    final $$JobQuotesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quoteId,
      referencedTable: $db.jobQuotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobQuotesTableOrderingComposer(
            $db: $db,
            $table: $db.jobQuotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableOrderingComposer get assignedTo {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.assignedTo,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableOrderingComposer get customer {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customer,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableOrderingComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JobsTableAnnotationComposer
    extends Composer<_$AppDatabase, $JobsTable> {
  $$JobsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get jobStatus =>
      $composableBuilder(column: $table.jobStatus, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  $$JobQuotesTableAnnotationComposer get quoteId {
    final $$JobQuotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quoteId,
      referencedTable: $db.jobQuotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobQuotesTableAnnotationComposer(
            $db: $db,
            $table: $db.jobQuotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableAnnotationComposer get assignedTo {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.assignedTo,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableAnnotationComposer get customer {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customer,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> documentRefs<T extends Object>(
    Expression<T> Function($$DocumentTableAnnotationComposer a) f,
  ) {
    final $$DocumentTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.document,
      getReferencedColumn: (t) => t.jobId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentTableAnnotationComposer(
            $db: $db,
            $table: $db.document,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$JobsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JobsTable,
          Job,
          $$JobsTableFilterComposer,
          $$JobsTableOrderingComposer,
          $$JobsTableAnnotationComposer,
          $$JobsTableCreateCompanionBuilder,
          $$JobsTableUpdateCompanionBuilder,
          (Job, $$JobsTableReferences),
          Job,
          PrefetchHooks Function({
            bool quoteId,
            bool assignedTo,
            bool customer,
            bool documentRefs,
          })
        > {
  $$JobsTableTableManager(_$AppDatabase db, $JobsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JobsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JobsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JobsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> quoteId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> jobStatus = const Value.absent(),
                Value<DateTime?> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<int> assignedTo = const Value.absent(),
                Value<int> customer = const Value.absent(),
              }) => JobsCompanion(
                id: id,
                quoteId: quoteId,
                name: name,
                jobStatus: jobStatus,
                startDate: startDate,
                endDate: endDate,
                assignedTo: assignedTo,
                customer: customer,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int quoteId,
                required String name,
                required String jobStatus,
                Value<DateTime?> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                required int assignedTo,
                required int customer,
              }) => JobsCompanion.insert(
                id: id,
                quoteId: quoteId,
                name: name,
                jobStatus: jobStatus,
                startDate: startDate,
                endDate: endDate,
                assignedTo: assignedTo,
                customer: customer,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$JobsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                quoteId = false,
                assignedTo = false,
                customer = false,
                documentRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (documentRefs) db.document],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (quoteId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.quoteId,
                                    referencedTable: $$JobsTableReferences
                                        ._quoteIdTable(db),
                                    referencedColumn: $$JobsTableReferences
                                        ._quoteIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (assignedTo) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.assignedTo,
                                    referencedTable: $$JobsTableReferences
                                        ._assignedToTable(db),
                                    referencedColumn: $$JobsTableReferences
                                        ._assignedToTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (customer) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.customer,
                                    referencedTable: $$JobsTableReferences
                                        ._customerTable(db),
                                    referencedColumn: $$JobsTableReferences
                                        ._customerTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (documentRefs)
                        await $_getPrefetchedData<
                          Job,
                          $JobsTable,
                          DocumentData
                        >(
                          currentTable: table,
                          referencedTable: $$JobsTableReferences
                              ._documentRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$JobsTableReferences(db, table, p0).documentRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.jobId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$JobsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JobsTable,
      Job,
      $$JobsTableFilterComposer,
      $$JobsTableOrderingComposer,
      $$JobsTableAnnotationComposer,
      $$JobsTableCreateCompanionBuilder,
      $$JobsTableUpdateCompanionBuilder,
      (Job, $$JobsTableReferences),
      Job,
      PrefetchHooks Function({
        bool quoteId,
        bool assignedTo,
        bool customer,
        bool documentRefs,
      })
    >;
typedef $$ToolsTableCreateCompanionBuilder =
    ToolsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      Value<bool> isAvailable,
      required int managedBy,
    });
typedef $$ToolsTableUpdateCompanionBuilder =
    ToolsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<bool> isAvailable,
      Value<int> managedBy,
    });

final class $$ToolsTableReferences
    extends BaseReferences<_$AppDatabase, $ToolsTable, Tool> {
  $$ToolsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _managedByTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.tools.managedBy, db.users.id),
  );

  $$UsersTableProcessedTableManager get managedBy {
    final $_column = $_itemColumn<int>('managed_by')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_managedByTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ToolsTableFilterComposer extends Composer<_$AppDatabase, $ToolsTable> {
  $$ToolsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get managedBy {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.managedBy,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ToolsTableOrderingComposer
    extends Composer<_$AppDatabase, $ToolsTable> {
  $$ToolsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get managedBy {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.managedBy,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ToolsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ToolsTable> {
  $$ToolsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => column,
  );

  $$UsersTableAnnotationComposer get managedBy {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.managedBy,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ToolsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ToolsTable,
          Tool,
          $$ToolsTableFilterComposer,
          $$ToolsTableOrderingComposer,
          $$ToolsTableAnnotationComposer,
          $$ToolsTableCreateCompanionBuilder,
          $$ToolsTableUpdateCompanionBuilder,
          (Tool, $$ToolsTableReferences),
          Tool,
          PrefetchHooks Function({bool managedBy})
        > {
  $$ToolsTableTableManager(_$AppDatabase db, $ToolsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ToolsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ToolsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ToolsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<bool> isAvailable = const Value.absent(),
                Value<int> managedBy = const Value.absent(),
              }) => ToolsCompanion(
                id: id,
                name: name,
                description: description,
                isAvailable: isAvailable,
                managedBy: managedBy,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<bool> isAvailable = const Value.absent(),
                required int managedBy,
              }) => ToolsCompanion.insert(
                id: id,
                name: name,
                description: description,
                isAvailable: isAvailable,
                managedBy: managedBy,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$ToolsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({managedBy = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (managedBy) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.managedBy,
                                referencedTable: $$ToolsTableReferences
                                    ._managedByTable(db),
                                referencedColumn: $$ToolsTableReferences
                                    ._managedByTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ToolsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ToolsTable,
      Tool,
      $$ToolsTableFilterComposer,
      $$ToolsTableOrderingComposer,
      $$ToolsTableAnnotationComposer,
      $$ToolsTableCreateCompanionBuilder,
      $$ToolsTableUpdateCompanionBuilder,
      (Tool, $$ToolsTableReferences),
      Tool,
      PrefetchHooks Function({bool managedBy})
    >;
typedef $$TasksTableCreateCompanionBuilder =
    TasksCompanion Function({
      Value<int> id,
      required String title,
      Value<String?> description,
      Value<DateTime?> dueDate,
      Value<bool> isCompleted,
      Value<bool> isFlagged,
      Value<String?> reasonForFlag,
      required int assignedTo,
    });
typedef $$TasksTableUpdateCompanionBuilder =
    TasksCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String?> description,
      Value<DateTime?> dueDate,
      Value<bool> isCompleted,
      Value<bool> isFlagged,
      Value<String?> reasonForFlag,
      Value<int> assignedTo,
    });

final class $$TasksTableReferences
    extends BaseReferences<_$AppDatabase, $TasksTable, Task> {
  $$TasksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _assignedToTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.tasks.assignedTo, db.users.id),
  );

  $$UsersTableProcessedTableManager get assignedTo {
    final $_column = $_itemColumn<int>('assigned_to')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_assignedToTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TasksTableFilterComposer extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFlagged => $composableBuilder(
    column: $table.isFlagged,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reasonForFlag => $composableBuilder(
    column: $table.reasonForFlag,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get assignedTo {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.assignedTo,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TasksTableOrderingComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFlagged => $composableBuilder(
    column: $table.isFlagged,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reasonForFlag => $composableBuilder(
    column: $table.reasonForFlag,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get assignedTo {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.assignedTo,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFlagged =>
      $composableBuilder(column: $table.isFlagged, builder: (column) => column);

  GeneratedColumn<String> get reasonForFlag => $composableBuilder(
    column: $table.reasonForFlag,
    builder: (column) => column,
  );

  $$UsersTableAnnotationComposer get assignedTo {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.assignedTo,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TasksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TasksTable,
          Task,
          $$TasksTableFilterComposer,
          $$TasksTableOrderingComposer,
          $$TasksTableAnnotationComposer,
          $$TasksTableCreateCompanionBuilder,
          $$TasksTableUpdateCompanionBuilder,
          (Task, $$TasksTableReferences),
          Task,
          PrefetchHooks Function({bool assignedTo})
        > {
  $$TasksTableTableManager(_$AppDatabase db, $TasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<bool> isFlagged = const Value.absent(),
                Value<String?> reasonForFlag = const Value.absent(),
                Value<int> assignedTo = const Value.absent(),
              }) => TasksCompanion(
                id: id,
                title: title,
                description: description,
                dueDate: dueDate,
                isCompleted: isCompleted,
                isFlagged: isFlagged,
                reasonForFlag: reasonForFlag,
                assignedTo: assignedTo,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<String?> description = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<bool> isFlagged = const Value.absent(),
                Value<String?> reasonForFlag = const Value.absent(),
                required int assignedTo,
              }) => TasksCompanion.insert(
                id: id,
                title: title,
                description: description,
                dueDate: dueDate,
                isCompleted: isCompleted,
                isFlagged: isFlagged,
                reasonForFlag: reasonForFlag,
                assignedTo: assignedTo,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TasksTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({assignedTo = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (assignedTo) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.assignedTo,
                                referencedTable: $$TasksTableReferences
                                    ._assignedToTable(db),
                                referencedColumn: $$TasksTableReferences
                                    ._assignedToTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TasksTable,
      Task,
      $$TasksTableFilterComposer,
      $$TasksTableOrderingComposer,
      $$TasksTableAnnotationComposer,
      $$TasksTableCreateCompanionBuilder,
      $$TasksTableUpdateCompanionBuilder,
      (Task, $$TasksTableReferences),
      Task,
      PrefetchHooks Function({bool assignedTo})
    >;
typedef $$ComplaintTableCreateCompanionBuilder =
    ComplaintCompanion Function({
      Value<int> id,
      required String title,
      Value<String?> description,
      Value<DateTime> reportedAt,
      Value<bool> isResolved,
      required int reportedByUser,
      required int assignedTo,
      required int reportedByCustomer,
    });
typedef $$ComplaintTableUpdateCompanionBuilder =
    ComplaintCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String?> description,
      Value<DateTime> reportedAt,
      Value<bool> isResolved,
      Value<int> reportedByUser,
      Value<int> assignedTo,
      Value<int> reportedByCustomer,
    });

final class $$ComplaintTableReferences
    extends BaseReferences<_$AppDatabase, $ComplaintTable, ComplaintData> {
  $$ComplaintTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _reportedByUserTable(_$AppDatabase db) =>
      db.users.createAlias(
        $_aliasNameGenerator(db.complaint.reportedByUser, db.users.id),
      );

  $$UsersTableProcessedTableManager get reportedByUser {
    final $_column = $_itemColumn<int>('reported_by_user')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_reportedByUserTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsersTable _assignedToTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.complaint.assignedTo, db.users.id),
  );

  $$UsersTableProcessedTableManager get assignedTo {
    final $_column = $_itemColumn<int>('assigned_to')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_assignedToTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CustomersTable _reportedByCustomerTable(_$AppDatabase db) =>
      db.customers.createAlias(
        $_aliasNameGenerator(db.complaint.reportedByCustomer, db.customers.id),
      );

  $$CustomersTableProcessedTableManager get reportedByCustomer {
    final $_column = $_itemColumn<int>('reported_by_customer')!;

    final manager = $$CustomersTableTableManager(
      $_db,
      $_db.customers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_reportedByCustomerTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ComplaintTableFilterComposer
    extends Composer<_$AppDatabase, $ComplaintTable> {
  $$ComplaintTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get reportedAt => $composableBuilder(
    column: $table.reportedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isResolved => $composableBuilder(
    column: $table.isResolved,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get reportedByUser {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportedByUser,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableFilterComposer get assignedTo {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.assignedTo,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableFilterComposer get reportedByCustomer {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportedByCustomer,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableFilterComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ComplaintTableOrderingComposer
    extends Composer<_$AppDatabase, $ComplaintTable> {
  $$ComplaintTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get reportedAt => $composableBuilder(
    column: $table.reportedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isResolved => $composableBuilder(
    column: $table.isResolved,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get reportedByUser {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportedByUser,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableOrderingComposer get assignedTo {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.assignedTo,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableOrderingComposer get reportedByCustomer {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportedByCustomer,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableOrderingComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ComplaintTableAnnotationComposer
    extends Composer<_$AppDatabase, $ComplaintTable> {
  $$ComplaintTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get reportedAt => $composableBuilder(
    column: $table.reportedAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isResolved => $composableBuilder(
    column: $table.isResolved,
    builder: (column) => column,
  );

  $$UsersTableAnnotationComposer get reportedByUser {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportedByUser,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableAnnotationComposer get assignedTo {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.assignedTo,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableAnnotationComposer get reportedByCustomer {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportedByCustomer,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ComplaintTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ComplaintTable,
          ComplaintData,
          $$ComplaintTableFilterComposer,
          $$ComplaintTableOrderingComposer,
          $$ComplaintTableAnnotationComposer,
          $$ComplaintTableCreateCompanionBuilder,
          $$ComplaintTableUpdateCompanionBuilder,
          (ComplaintData, $$ComplaintTableReferences),
          ComplaintData,
          PrefetchHooks Function({
            bool reportedByUser,
            bool assignedTo,
            bool reportedByCustomer,
          })
        > {
  $$ComplaintTableTableManager(_$AppDatabase db, $ComplaintTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ComplaintTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ComplaintTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ComplaintTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> reportedAt = const Value.absent(),
                Value<bool> isResolved = const Value.absent(),
                Value<int> reportedByUser = const Value.absent(),
                Value<int> assignedTo = const Value.absent(),
                Value<int> reportedByCustomer = const Value.absent(),
              }) => ComplaintCompanion(
                id: id,
                title: title,
                description: description,
                reportedAt: reportedAt,
                isResolved: isResolved,
                reportedByUser: reportedByUser,
                assignedTo: assignedTo,
                reportedByCustomer: reportedByCustomer,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<String?> description = const Value.absent(),
                Value<DateTime> reportedAt = const Value.absent(),
                Value<bool> isResolved = const Value.absent(),
                required int reportedByUser,
                required int assignedTo,
                required int reportedByCustomer,
              }) => ComplaintCompanion.insert(
                id: id,
                title: title,
                description: description,
                reportedAt: reportedAt,
                isResolved: isResolved,
                reportedByUser: reportedByUser,
                assignedTo: assignedTo,
                reportedByCustomer: reportedByCustomer,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ComplaintTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                reportedByUser = false,
                assignedTo = false,
                reportedByCustomer = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (reportedByUser) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.reportedByUser,
                                    referencedTable: $$ComplaintTableReferences
                                        ._reportedByUserTable(db),
                                    referencedColumn: $$ComplaintTableReferences
                                        ._reportedByUserTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (assignedTo) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.assignedTo,
                                    referencedTable: $$ComplaintTableReferences
                                        ._assignedToTable(db),
                                    referencedColumn: $$ComplaintTableReferences
                                        ._assignedToTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (reportedByCustomer) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.reportedByCustomer,
                                    referencedTable: $$ComplaintTableReferences
                                        ._reportedByCustomerTable(db),
                                    referencedColumn: $$ComplaintTableReferences
                                        ._reportedByCustomerTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$ComplaintTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ComplaintTable,
      ComplaintData,
      $$ComplaintTableFilterComposer,
      $$ComplaintTableOrderingComposer,
      $$ComplaintTableAnnotationComposer,
      $$ComplaintTableCreateCompanionBuilder,
      $$ComplaintTableUpdateCompanionBuilder,
      (ComplaintData, $$ComplaintTableReferences),
      ComplaintData,
      PrefetchHooks Function({
        bool reportedByUser,
        bool assignedTo,
        bool reportedByCustomer,
      })
    >;
typedef $$InjuryTableCreateCompanionBuilder =
    InjuryCompanion Function({
      Value<int> id,
      required String title,
      Value<String?> description,
      Value<DateTime> occurredAt,
      Value<bool> isResolved,
      required int reportedByUser,
      required int assignedTo,
      required int reportedByCustomer,
    });
typedef $$InjuryTableUpdateCompanionBuilder =
    InjuryCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String?> description,
      Value<DateTime> occurredAt,
      Value<bool> isResolved,
      Value<int> reportedByUser,
      Value<int> assignedTo,
      Value<int> reportedByCustomer,
    });

final class $$InjuryTableReferences
    extends BaseReferences<_$AppDatabase, $InjuryTable, InjuryData> {
  $$InjuryTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _reportedByUserTable(_$AppDatabase db) => db.users
      .createAlias($_aliasNameGenerator(db.injury.reportedByUser, db.users.id));

  $$UsersTableProcessedTableManager get reportedByUser {
    final $_column = $_itemColumn<int>('reported_by_user')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_reportedByUserTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsersTable _assignedToTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.injury.assignedTo, db.users.id),
  );

  $$UsersTableProcessedTableManager get assignedTo {
    final $_column = $_itemColumn<int>('assigned_to')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_assignedToTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CustomersTable _reportedByCustomerTable(_$AppDatabase db) =>
      db.customers.createAlias(
        $_aliasNameGenerator(db.injury.reportedByCustomer, db.customers.id),
      );

  $$CustomersTableProcessedTableManager get reportedByCustomer {
    final $_column = $_itemColumn<int>('reported_by_customer')!;

    final manager = $$CustomersTableTableManager(
      $_db,
      $_db.customers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_reportedByCustomerTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InjuryTableFilterComposer
    extends Composer<_$AppDatabase, $InjuryTable> {
  $$InjuryTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isResolved => $composableBuilder(
    column: $table.isResolved,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get reportedByUser {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportedByUser,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableFilterComposer get assignedTo {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.assignedTo,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableFilterComposer get reportedByCustomer {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportedByCustomer,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableFilterComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InjuryTableOrderingComposer
    extends Composer<_$AppDatabase, $InjuryTable> {
  $$InjuryTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isResolved => $composableBuilder(
    column: $table.isResolved,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get reportedByUser {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportedByUser,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableOrderingComposer get assignedTo {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.assignedTo,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableOrderingComposer get reportedByCustomer {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportedByCustomer,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableOrderingComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InjuryTableAnnotationComposer
    extends Composer<_$AppDatabase, $InjuryTable> {
  $$InjuryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isResolved => $composableBuilder(
    column: $table.isResolved,
    builder: (column) => column,
  );

  $$UsersTableAnnotationComposer get reportedByUser {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportedByUser,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableAnnotationComposer get assignedTo {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.assignedTo,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableAnnotationComposer get reportedByCustomer {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportedByCustomer,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InjuryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InjuryTable,
          InjuryData,
          $$InjuryTableFilterComposer,
          $$InjuryTableOrderingComposer,
          $$InjuryTableAnnotationComposer,
          $$InjuryTableCreateCompanionBuilder,
          $$InjuryTableUpdateCompanionBuilder,
          (InjuryData, $$InjuryTableReferences),
          InjuryData,
          PrefetchHooks Function({
            bool reportedByUser,
            bool assignedTo,
            bool reportedByCustomer,
          })
        > {
  $$InjuryTableTableManager(_$AppDatabase db, $InjuryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InjuryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InjuryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InjuryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<bool> isResolved = const Value.absent(),
                Value<int> reportedByUser = const Value.absent(),
                Value<int> assignedTo = const Value.absent(),
                Value<int> reportedByCustomer = const Value.absent(),
              }) => InjuryCompanion(
                id: id,
                title: title,
                description: description,
                occurredAt: occurredAt,
                isResolved: isResolved,
                reportedByUser: reportedByUser,
                assignedTo: assignedTo,
                reportedByCustomer: reportedByCustomer,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<String?> description = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<bool> isResolved = const Value.absent(),
                required int reportedByUser,
                required int assignedTo,
                required int reportedByCustomer,
              }) => InjuryCompanion.insert(
                id: id,
                title: title,
                description: description,
                occurredAt: occurredAt,
                isResolved: isResolved,
                reportedByUser: reportedByUser,
                assignedTo: assignedTo,
                reportedByCustomer: reportedByCustomer,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$InjuryTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                reportedByUser = false,
                assignedTo = false,
                reportedByCustomer = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (reportedByUser) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.reportedByUser,
                                    referencedTable: $$InjuryTableReferences
                                        ._reportedByUserTable(db),
                                    referencedColumn: $$InjuryTableReferences
                                        ._reportedByUserTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (assignedTo) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.assignedTo,
                                    referencedTable: $$InjuryTableReferences
                                        ._assignedToTable(db),
                                    referencedColumn: $$InjuryTableReferences
                                        ._assignedToTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (reportedByCustomer) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.reportedByCustomer,
                                    referencedTable: $$InjuryTableReferences
                                        ._reportedByCustomerTable(db),
                                    referencedColumn: $$InjuryTableReferences
                                        ._reportedByCustomerTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$InjuryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InjuryTable,
      InjuryData,
      $$InjuryTableFilterComposer,
      $$InjuryTableOrderingComposer,
      $$InjuryTableAnnotationComposer,
      $$InjuryTableCreateCompanionBuilder,
      $$InjuryTableUpdateCompanionBuilder,
      (InjuryData, $$InjuryTableReferences),
      InjuryData,
      PrefetchHooks Function({
        bool reportedByUser,
        bool assignedTo,
        bool reportedByCustomer,
      })
    >;
typedef $$DocumentTableCreateCompanionBuilder =
    DocumentCompanion Function({
      Value<int> id,
      required String title,
      required String filePath,
      Value<DateTime> uploadedAt,
      required int uploadedBy,
      required int customerId,
      required int jobId,
    });
typedef $$DocumentTableUpdateCompanionBuilder =
    DocumentCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> filePath,
      Value<DateTime> uploadedAt,
      Value<int> uploadedBy,
      Value<int> customerId,
      Value<int> jobId,
    });

final class $$DocumentTableReferences
    extends BaseReferences<_$AppDatabase, $DocumentTable, DocumentData> {
  $$DocumentTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _uploadedByTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.document.uploadedBy, db.users.id),
  );

  $$UsersTableProcessedTableManager get uploadedBy {
    final $_column = $_itemColumn<int>('uploaded_by')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_uploadedByTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CustomersTable _customerIdTable(_$AppDatabase db) =>
      db.customers.createAlias(
        $_aliasNameGenerator(db.document.customerId, db.customers.id),
      );

  $$CustomersTableProcessedTableManager get customerId {
    final $_column = $_itemColumn<int>('customer_id')!;

    final manager = $$CustomersTableTableManager(
      $_db,
      $_db.customers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $JobsTable _jobIdTable(_$AppDatabase db) =>
      db.jobs.createAlias($_aliasNameGenerator(db.document.jobId, db.jobs.id));

  $$JobsTableProcessedTableManager get jobId {
    final $_column = $_itemColumn<int>('job_id')!;

    final manager = $$JobsTableTableManager(
      $_db,
      $_db.jobs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_jobIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DocumentTableFilterComposer
    extends Composer<_$AppDatabase, $DocumentTable> {
  $$DocumentTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get uploadedAt => $composableBuilder(
    column: $table.uploadedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get uploadedBy {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uploadedBy,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableFilterComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$JobsTableFilterComposer get jobId {
    final $$JobsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableFilterComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumentTable> {
  $$DocumentTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get uploadedAt => $composableBuilder(
    column: $table.uploadedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get uploadedBy {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uploadedBy,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableOrderingComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$JobsTableOrderingComposer get jobId {
    final $$JobsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableOrderingComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumentTable> {
  $$DocumentTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<DateTime> get uploadedAt => $composableBuilder(
    column: $table.uploadedAt,
    builder: (column) => column,
  );

  $$UsersTableAnnotationComposer get uploadedBy {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uploadedBy,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableAnnotationComposer get customerId {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$JobsTableAnnotationComposer get jobId {
    final $$JobsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableAnnotationComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DocumentTable,
          DocumentData,
          $$DocumentTableFilterComposer,
          $$DocumentTableOrderingComposer,
          $$DocumentTableAnnotationComposer,
          $$DocumentTableCreateCompanionBuilder,
          $$DocumentTableUpdateCompanionBuilder,
          (DocumentData, $$DocumentTableReferences),
          DocumentData,
          PrefetchHooks Function({bool uploadedBy, bool customerId, bool jobId})
        > {
  $$DocumentTableTableManager(_$AppDatabase db, $DocumentTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<DateTime> uploadedAt = const Value.absent(),
                Value<int> uploadedBy = const Value.absent(),
                Value<int> customerId = const Value.absent(),
                Value<int> jobId = const Value.absent(),
              }) => DocumentCompanion(
                id: id,
                title: title,
                filePath: filePath,
                uploadedAt: uploadedAt,
                uploadedBy: uploadedBy,
                customerId: customerId,
                jobId: jobId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String filePath,
                Value<DateTime> uploadedAt = const Value.absent(),
                required int uploadedBy,
                required int customerId,
                required int jobId,
              }) => DocumentCompanion.insert(
                id: id,
                title: title,
                filePath: filePath,
                uploadedAt: uploadedAt,
                uploadedBy: uploadedBy,
                customerId: customerId,
                jobId: jobId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DocumentTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({uploadedBy = false, customerId = false, jobId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (uploadedBy) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.uploadedBy,
                                    referencedTable: $$DocumentTableReferences
                                        ._uploadedByTable(db),
                                    referencedColumn: $$DocumentTableReferences
                                        ._uploadedByTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (customerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.customerId,
                                    referencedTable: $$DocumentTableReferences
                                        ._customerIdTable(db),
                                    referencedColumn: $$DocumentTableReferences
                                        ._customerIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (jobId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.jobId,
                                    referencedTable: $$DocumentTableReferences
                                        ._jobIdTable(db),
                                    referencedColumn: $$DocumentTableReferences
                                        ._jobIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$DocumentTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DocumentTable,
      DocumentData,
      $$DocumentTableFilterComposer,
      $$DocumentTableOrderingComposer,
      $$DocumentTableAnnotationComposer,
      $$DocumentTableCreateCompanionBuilder,
      $$DocumentTableUpdateCompanionBuilder,
      (DocumentData, $$DocumentTableReferences),
      DocumentData,
      PrefetchHooks Function({bool uploadedBy, bool customerId, bool jobId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CompanyTableTableManager get company =>
      $$CompanyTableTableManager(_db, _db.company);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$TemplatesTableTableManager get templates =>
      $$TemplatesTableTableManager(_db, _db.templates);
  $$TemplateFieldsTableTableManager get templateFields =>
      $$TemplateFieldsTableTableManager(_db, _db.templateFields);
  $$JobQuotesTableTableManager get jobQuotes =>
      $$JobQuotesTableTableManager(_db, _db.jobQuotes);
  $$QuoteFieldValuesTableTableManager get quoteFieldValues =>
      $$QuoteFieldValuesTableTableManager(_db, _db.quoteFieldValues);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$JobsTableTableManager get jobs => $$JobsTableTableManager(_db, _db.jobs);
  $$ToolsTableTableManager get tools =>
      $$ToolsTableTableManager(_db, _db.tools);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
  $$ComplaintTableTableManager get complaint =>
      $$ComplaintTableTableManager(_db, _db.complaint);
  $$InjuryTableTableManager get injury =>
      $$InjuryTableTableManager(_db, _db.injury);
  $$DocumentTableTableManager get document =>
      $$DocumentTableTableManager(_db, _db.document);
}

mixin _$UserDaoMixin on DatabaseAccessor<AppDatabase> {
  $CompanyTable get company => attachedDatabase.company;
  $UsersTable get users => attachedDatabase.users;
}
mixin _$TemplatesDaoMixin on DatabaseAccessor<AppDatabase> {
  $CompanyTable get company => attachedDatabase.company;
  $UsersTable get users => attachedDatabase.users;
  $TemplatesTable get templates => attachedDatabase.templates;
  $TemplateFieldsTable get templateFields => attachedDatabase.templateFields;
}
mixin _$JobQuotesDaoMixin on DatabaseAccessor<AppDatabase> {
  $CompanyTable get company => attachedDatabase.company;
  $UsersTable get users => attachedDatabase.users;
  $TemplatesTable get templates => attachedDatabase.templates;
  $JobQuotesTable get jobQuotes => attachedDatabase.jobQuotes;
  $TemplateFieldsTable get templateFields => attachedDatabase.templateFields;
  $QuoteFieldValuesTable get quoteFieldValues =>
      attachedDatabase.quoteFieldValues;
}
mixin _$CompanyDaoMixin on DatabaseAccessor<AppDatabase> {
  $CompanyTable get company => attachedDatabase.company;
}
mixin _$JobsDaoMixin on DatabaseAccessor<AppDatabase> {
  $CompanyTable get company => attachedDatabase.company;
  $UsersTable get users => attachedDatabase.users;
  $TemplatesTable get templates => attachedDatabase.templates;
  $JobQuotesTable get jobQuotes => attachedDatabase.jobQuotes;
  $CustomersTable get customers => attachedDatabase.customers;
  $JobsTable get jobs => attachedDatabase.jobs;
}
mixin _$CustomersDaoMixin on DatabaseAccessor<AppDatabase> {
  $CompanyTable get company => attachedDatabase.company;
  $UsersTable get users => attachedDatabase.users;
  $CustomersTable get customers => attachedDatabase.customers;
}
