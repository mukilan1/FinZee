// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AccountsTable extends Accounts
    with TableInfo<$AccountsTable, AccountRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _openingBalanceMinorMeta =
      const VerificationMeta('openingBalanceMinor');
  @override
  late final GeneratedColumn<int> openingBalanceMinor = GeneratedColumn<int>(
    'opening_balance_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('INR'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _archivedMeta = const VerificationMeta(
    'archived',
  );
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
    'archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    type,
    openingBalanceMinor,
    currency,
    notes,
    archived,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<AccountRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('opening_balance_minor')) {
      context.handle(
        _openingBalanceMinorMeta,
        openingBalanceMinor.isAcceptableOrUnknown(
          data['opening_balance_minor']!,
          _openingBalanceMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_openingBalanceMinorMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('archived')) {
      context.handle(
        _archivedMeta,
        archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccountRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      openingBalanceMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}opening_balance_minor'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      archived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(attachedDatabase, alias);
  }
}

class AccountRow extends DataClass implements Insertable<AccountRow> {
  final String id;
  final String name;
  final String type;
  final int openingBalanceMinor;
  final String currency;
  final String? notes;
  final bool archived;
  final DateTime createdAt;
  const AccountRow({
    required this.id,
    required this.name,
    required this.type,
    required this.openingBalanceMinor,
    required this.currency,
    this.notes,
    required this.archived,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['opening_balance_minor'] = Variable<int>(openingBalanceMinor);
    map['currency'] = Variable<String>(currency);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['archived'] = Variable<bool>(archived);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      openingBalanceMinor: Value(openingBalanceMinor),
      currency: Value(currency),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      archived: Value(archived),
      createdAt: Value(createdAt),
    );
  }

  factory AccountRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      openingBalanceMinor: serializer.fromJson<int>(
        json['openingBalanceMinor'],
      ),
      currency: serializer.fromJson<String>(json['currency']),
      notes: serializer.fromJson<String?>(json['notes']),
      archived: serializer.fromJson<bool>(json['archived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'openingBalanceMinor': serializer.toJson<int>(openingBalanceMinor),
      'currency': serializer.toJson<String>(currency),
      'notes': serializer.toJson<String?>(notes),
      'archived': serializer.toJson<bool>(archived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AccountRow copyWith({
    String? id,
    String? name,
    String? type,
    int? openingBalanceMinor,
    String? currency,
    Value<String?> notes = const Value.absent(),
    bool? archived,
    DateTime? createdAt,
  }) => AccountRow(
    id: id ?? this.id,
    name: name ?? this.name,
    type: type ?? this.type,
    openingBalanceMinor: openingBalanceMinor ?? this.openingBalanceMinor,
    currency: currency ?? this.currency,
    notes: notes.present ? notes.value : this.notes,
    archived: archived ?? this.archived,
    createdAt: createdAt ?? this.createdAt,
  );
  AccountRow copyWithCompanion(AccountsCompanion data) {
    return AccountRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      openingBalanceMinor: data.openingBalanceMinor.present
          ? data.openingBalanceMinor.value
          : this.openingBalanceMinor,
      currency: data.currency.present ? data.currency.value : this.currency,
      notes: data.notes.present ? data.notes.value : this.notes,
      archived: data.archived.present ? data.archived.value : this.archived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('openingBalanceMinor: $openingBalanceMinor, ')
          ..write('currency: $currency, ')
          ..write('notes: $notes, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    type,
    openingBalanceMinor,
    currency,
    notes,
    archived,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.openingBalanceMinor == this.openingBalanceMinor &&
          other.currency == this.currency &&
          other.notes == this.notes &&
          other.archived == this.archived &&
          other.createdAt == this.createdAt);
}

class AccountsCompanion extends UpdateCompanion<AccountRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> type;
  final Value<int> openingBalanceMinor;
  final Value<String> currency;
  final Value<String?> notes;
  final Value<bool> archived;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.openingBalanceMinor = const Value.absent(),
    this.currency = const Value.absent(),
    this.notes = const Value.absent(),
    this.archived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AccountsCompanion.insert({
    required String id,
    required String name,
    required String type,
    required int openingBalanceMinor,
    this.currency = const Value.absent(),
    this.notes = const Value.absent(),
    this.archived = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       type = Value(type),
       openingBalanceMinor = Value(openingBalanceMinor),
       createdAt = Value(createdAt);
  static Insertable<AccountRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<int>? openingBalanceMinor,
    Expression<String>? currency,
    Expression<String>? notes,
    Expression<bool>? archived,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (openingBalanceMinor != null)
        'opening_balance_minor': openingBalanceMinor,
      if (currency != null) 'currency': currency,
      if (notes != null) 'notes': notes,
      if (archived != null) 'archived': archived,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AccountsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? type,
    Value<int>? openingBalanceMinor,
    Value<String>? currency,
    Value<String?>? notes,
    Value<bool>? archived,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return AccountsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      openingBalanceMinor: openingBalanceMinor ?? this.openingBalanceMinor,
      currency: currency ?? this.currency,
      notes: notes ?? this.notes,
      archived: archived ?? this.archived,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (openingBalanceMinor.present) {
      map['opening_balance_minor'] = Variable<int>(openingBalanceMinor.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('openingBalanceMinor: $openingBalanceMinor, ')
          ..write('currency: $currency, ')
          ..write('notes: $notes, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, CategoryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parentIdMeta = const VerificationMeta(
    'parentId',
  );
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
    'parent_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('category'),
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
  static const VerificationMeta _archivedMeta = const VerificationMeta(
    'archived',
  );
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
    'archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    kind,
    parentId,
    icon,
    sortOrder,
    archived,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(
        _parentIdMeta,
        parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta),
      );
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('archived')) {
      context.handle(
        _archivedMeta,
        archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      parentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_id'],
      ),
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      archived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archived'],
      )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class CategoryRow extends DataClass implements Insertable<CategoryRow> {
  final String id;
  final String name;
  final String kind;
  final String? parentId;
  final String icon;
  final int sortOrder;
  final bool archived;
  const CategoryRow({
    required this.id,
    required this.name,
    required this.kind,
    this.parentId,
    required this.icon,
    required this.sortOrder,
    required this.archived,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['kind'] = Variable<String>(kind);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    map['icon'] = Variable<String>(icon);
    map['sort_order'] = Variable<int>(sortOrder);
    map['archived'] = Variable<bool>(archived);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      kind: Value(kind),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      icon: Value(icon),
      sortOrder: Value(sortOrder),
      archived: Value(archived),
    );
  }

  factory CategoryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      kind: serializer.fromJson<String>(json['kind']),
      parentId: serializer.fromJson<String?>(json['parentId']),
      icon: serializer.fromJson<String>(json['icon']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      archived: serializer.fromJson<bool>(json['archived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'kind': serializer.toJson<String>(kind),
      'parentId': serializer.toJson<String?>(parentId),
      'icon': serializer.toJson<String>(icon),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'archived': serializer.toJson<bool>(archived),
    };
  }

  CategoryRow copyWith({
    String? id,
    String? name,
    String? kind,
    Value<String?> parentId = const Value.absent(),
    String? icon,
    int? sortOrder,
    bool? archived,
  }) => CategoryRow(
    id: id ?? this.id,
    name: name ?? this.name,
    kind: kind ?? this.kind,
    parentId: parentId.present ? parentId.value : this.parentId,
    icon: icon ?? this.icon,
    sortOrder: sortOrder ?? this.sortOrder,
    archived: archived ?? this.archived,
  );
  CategoryRow copyWithCompanion(CategoriesCompanion data) {
    return CategoryRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      kind: data.kind.present ? data.kind.value : this.kind,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      icon: data.icon.present ? data.icon.value : this.icon,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      archived: data.archived.present ? data.archived.value : this.archived,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('parentId: $parentId, ')
          ..write('icon: $icon, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('archived: $archived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, kind, parentId, icon, sortOrder, archived);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.kind == this.kind &&
          other.parentId == this.parentId &&
          other.icon == this.icon &&
          other.sortOrder == this.sortOrder &&
          other.archived == this.archived);
}

class CategoriesCompanion extends UpdateCompanion<CategoryRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> kind;
  final Value<String?> parentId;
  final Value<String> icon;
  final Value<int> sortOrder;
  final Value<bool> archived;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.kind = const Value.absent(),
    this.parentId = const Value.absent(),
    this.icon = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.archived = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String id,
    required String name,
    required String kind,
    this.parentId = const Value.absent(),
    this.icon = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.archived = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       kind = Value(kind);
  static Insertable<CategoryRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? kind,
    Expression<String>? parentId,
    Expression<String>? icon,
    Expression<int>? sortOrder,
    Expression<bool>? archived,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (kind != null) 'kind': kind,
      if (parentId != null) 'parent_id': parentId,
      if (icon != null) 'icon': icon,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (archived != null) 'archived': archived,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? kind,
    Value<String?>? parentId,
    Value<String>? icon,
    Value<int>? sortOrder,
    Value<bool>? archived,
    Value<int>? rowid,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      parentId: parentId ?? this.parentId,
      icon: icon ?? this.icon,
      sortOrder: sortOrder ?? this.sortOrder,
      archived: archived ?? this.archived,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('parentId: $parentId, ')
          ..write('icon: $icon, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('archived: $archived, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, TransactionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMinorMeta = const VerificationMeta(
    'amountMinor',
  );
  @override
  late final GeneratedColumn<int> amountMinor = GeneratedColumn<int>(
    'amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toAccountIdMeta = const VerificationMeta(
    'toAccountId',
  );
  @override
  late final GeneratedColumn<String> toAccountId = GeneratedColumn<String>(
    'to_account_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subcategoryIdMeta = const VerificationMeta(
    'subcategoryId',
  );
  @override
  late final GeneratedColumn<String> subcategoryId = GeneratedColumn<String>(
    'subcategory_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _incomeSourceIdMeta = const VerificationMeta(
    'incomeSourceId',
  );
  @override
  late final GeneratedColumn<String> incomeSourceId = GeneratedColumn<String>(
    'income_source_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tagsJsonMeta = const VerificationMeta(
    'tagsJson',
  );
  @override
  late final GeneratedColumn<String> tagsJson = GeneratedColumn<String>(
    'tags_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _attachmentPathMeta = const VerificationMeta(
    'attachmentPath',
  );
  @override
  late final GeneratedColumn<String> attachmentPath = GeneratedColumn<String>(
    'attachment_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _allocationItemIdMeta = const VerificationMeta(
    'allocationItemId',
  );
  @override
  late final GeneratedColumn<String> allocationItemId = GeneratedColumn<String>(
    'allocation_item_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<String> goalId = GeneratedColumn<String>(
    'goal_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _investmentIdMeta = const VerificationMeta(
    'investmentId',
  );
  @override
  late final GeneratedColumn<String> investmentId = GeneratedColumn<String>(
    'investment_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    amountMinor,
    date,
    accountId,
    toAccountId,
    categoryId,
    subcategoryId,
    paymentMethod,
    incomeSourceId,
    note,
    tagsJson,
    attachmentPath,
    allocationItemId,
    goalId,
    investmentId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransactionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('amount_minor')) {
      context.handle(
        _amountMinorMeta,
        amountMinor.isAcceptableOrUnknown(
          data['amount_minor']!,
          _amountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountMinorMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('to_account_id')) {
      context.handle(
        _toAccountIdMeta,
        toAccountId.isAcceptableOrUnknown(
          data['to_account_id']!,
          _toAccountIdMeta,
        ),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('subcategory_id')) {
      context.handle(
        _subcategoryIdMeta,
        subcategoryId.isAcceptableOrUnknown(
          data['subcategory_id']!,
          _subcategoryIdMeta,
        ),
      );
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    }
    if (data.containsKey('income_source_id')) {
      context.handle(
        _incomeSourceIdMeta,
        incomeSourceId.isAcceptableOrUnknown(
          data['income_source_id']!,
          _incomeSourceIdMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('tags_json')) {
      context.handle(
        _tagsJsonMeta,
        tagsJson.isAcceptableOrUnknown(data['tags_json']!, _tagsJsonMeta),
      );
    }
    if (data.containsKey('attachment_path')) {
      context.handle(
        _attachmentPathMeta,
        attachmentPath.isAcceptableOrUnknown(
          data['attachment_path']!,
          _attachmentPathMeta,
        ),
      );
    }
    if (data.containsKey('allocation_item_id')) {
      context.handle(
        _allocationItemIdMeta,
        allocationItemId.isAcceptableOrUnknown(
          data['allocation_item_id']!,
          _allocationItemIdMeta,
        ),
      );
    }
    if (data.containsKey('goal_id')) {
      context.handle(
        _goalIdMeta,
        goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta),
      );
    }
    if (data.containsKey('investment_id')) {
      context.handle(
        _investmentIdMeta,
        investmentId.isAcceptableOrUnknown(
          data['investment_id']!,
          _investmentIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      amountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_minor'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      toAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}to_account_id'],
      ),
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      subcategoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subcategory_id'],
      ),
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      ),
      incomeSourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}income_source_id'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      tagsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags_json'],
      )!,
      attachmentPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attachment_path'],
      ),
      allocationItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}allocation_item_id'],
      ),
      goalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal_id'],
      ),
      investmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}investment_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

class TransactionRow extends DataClass implements Insertable<TransactionRow> {
  final String id;
  final String type;
  final int amountMinor;
  final DateTime date;
  final String accountId;
  final String? toAccountId;
  final String? categoryId;
  final String? subcategoryId;
  final String? paymentMethod;
  final String? incomeSourceId;
  final String? note;
  final String tagsJson;
  final String? attachmentPath;
  final String? allocationItemId;
  final String? goalId;
  final String? investmentId;
  final DateTime createdAt;
  const TransactionRow({
    required this.id,
    required this.type,
    required this.amountMinor,
    required this.date,
    required this.accountId,
    this.toAccountId,
    this.categoryId,
    this.subcategoryId,
    this.paymentMethod,
    this.incomeSourceId,
    this.note,
    required this.tagsJson,
    this.attachmentPath,
    this.allocationItemId,
    this.goalId,
    this.investmentId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    map['amount_minor'] = Variable<int>(amountMinor);
    map['date'] = Variable<DateTime>(date);
    map['account_id'] = Variable<String>(accountId);
    if (!nullToAbsent || toAccountId != null) {
      map['to_account_id'] = Variable<String>(toAccountId);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    if (!nullToAbsent || subcategoryId != null) {
      map['subcategory_id'] = Variable<String>(subcategoryId);
    }
    if (!nullToAbsent || paymentMethod != null) {
      map['payment_method'] = Variable<String>(paymentMethod);
    }
    if (!nullToAbsent || incomeSourceId != null) {
      map['income_source_id'] = Variable<String>(incomeSourceId);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['tags_json'] = Variable<String>(tagsJson);
    if (!nullToAbsent || attachmentPath != null) {
      map['attachment_path'] = Variable<String>(attachmentPath);
    }
    if (!nullToAbsent || allocationItemId != null) {
      map['allocation_item_id'] = Variable<String>(allocationItemId);
    }
    if (!nullToAbsent || goalId != null) {
      map['goal_id'] = Variable<String>(goalId);
    }
    if (!nullToAbsent || investmentId != null) {
      map['investment_id'] = Variable<String>(investmentId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      type: Value(type),
      amountMinor: Value(amountMinor),
      date: Value(date),
      accountId: Value(accountId),
      toAccountId: toAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(toAccountId),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      subcategoryId: subcategoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(subcategoryId),
      paymentMethod: paymentMethod == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentMethod),
      incomeSourceId: incomeSourceId == null && nullToAbsent
          ? const Value.absent()
          : Value(incomeSourceId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      tagsJson: Value(tagsJson),
      attachmentPath: attachmentPath == null && nullToAbsent
          ? const Value.absent()
          : Value(attachmentPath),
      allocationItemId: allocationItemId == null && nullToAbsent
          ? const Value.absent()
          : Value(allocationItemId),
      goalId: goalId == null && nullToAbsent
          ? const Value.absent()
          : Value(goalId),
      investmentId: investmentId == null && nullToAbsent
          ? const Value.absent()
          : Value(investmentId),
      createdAt: Value(createdAt),
    );
  }

  factory TransactionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionRow(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      amountMinor: serializer.fromJson<int>(json['amountMinor']),
      date: serializer.fromJson<DateTime>(json['date']),
      accountId: serializer.fromJson<String>(json['accountId']),
      toAccountId: serializer.fromJson<String?>(json['toAccountId']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      subcategoryId: serializer.fromJson<String?>(json['subcategoryId']),
      paymentMethod: serializer.fromJson<String?>(json['paymentMethod']),
      incomeSourceId: serializer.fromJson<String?>(json['incomeSourceId']),
      note: serializer.fromJson<String?>(json['note']),
      tagsJson: serializer.fromJson<String>(json['tagsJson']),
      attachmentPath: serializer.fromJson<String?>(json['attachmentPath']),
      allocationItemId: serializer.fromJson<String?>(json['allocationItemId']),
      goalId: serializer.fromJson<String?>(json['goalId']),
      investmentId: serializer.fromJson<String?>(json['investmentId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'amountMinor': serializer.toJson<int>(amountMinor),
      'date': serializer.toJson<DateTime>(date),
      'accountId': serializer.toJson<String>(accountId),
      'toAccountId': serializer.toJson<String?>(toAccountId),
      'categoryId': serializer.toJson<String?>(categoryId),
      'subcategoryId': serializer.toJson<String?>(subcategoryId),
      'paymentMethod': serializer.toJson<String?>(paymentMethod),
      'incomeSourceId': serializer.toJson<String?>(incomeSourceId),
      'note': serializer.toJson<String?>(note),
      'tagsJson': serializer.toJson<String>(tagsJson),
      'attachmentPath': serializer.toJson<String?>(attachmentPath),
      'allocationItemId': serializer.toJson<String?>(allocationItemId),
      'goalId': serializer.toJson<String?>(goalId),
      'investmentId': serializer.toJson<String?>(investmentId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  TransactionRow copyWith({
    String? id,
    String? type,
    int? amountMinor,
    DateTime? date,
    String? accountId,
    Value<String?> toAccountId = const Value.absent(),
    Value<String?> categoryId = const Value.absent(),
    Value<String?> subcategoryId = const Value.absent(),
    Value<String?> paymentMethod = const Value.absent(),
    Value<String?> incomeSourceId = const Value.absent(),
    Value<String?> note = const Value.absent(),
    String? tagsJson,
    Value<String?> attachmentPath = const Value.absent(),
    Value<String?> allocationItemId = const Value.absent(),
    Value<String?> goalId = const Value.absent(),
    Value<String?> investmentId = const Value.absent(),
    DateTime? createdAt,
  }) => TransactionRow(
    id: id ?? this.id,
    type: type ?? this.type,
    amountMinor: amountMinor ?? this.amountMinor,
    date: date ?? this.date,
    accountId: accountId ?? this.accountId,
    toAccountId: toAccountId.present ? toAccountId.value : this.toAccountId,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    subcategoryId: subcategoryId.present
        ? subcategoryId.value
        : this.subcategoryId,
    paymentMethod: paymentMethod.present
        ? paymentMethod.value
        : this.paymentMethod,
    incomeSourceId: incomeSourceId.present
        ? incomeSourceId.value
        : this.incomeSourceId,
    note: note.present ? note.value : this.note,
    tagsJson: tagsJson ?? this.tagsJson,
    attachmentPath: attachmentPath.present
        ? attachmentPath.value
        : this.attachmentPath,
    allocationItemId: allocationItemId.present
        ? allocationItemId.value
        : this.allocationItemId,
    goalId: goalId.present ? goalId.value : this.goalId,
    investmentId: investmentId.present ? investmentId.value : this.investmentId,
    createdAt: createdAt ?? this.createdAt,
  );
  TransactionRow copyWithCompanion(TransactionsCompanion data) {
    return TransactionRow(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      amountMinor: data.amountMinor.present
          ? data.amountMinor.value
          : this.amountMinor,
      date: data.date.present ? data.date.value : this.date,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      toAccountId: data.toAccountId.present
          ? data.toAccountId.value
          : this.toAccountId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      subcategoryId: data.subcategoryId.present
          ? data.subcategoryId.value
          : this.subcategoryId,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      incomeSourceId: data.incomeSourceId.present
          ? data.incomeSourceId.value
          : this.incomeSourceId,
      note: data.note.present ? data.note.value : this.note,
      tagsJson: data.tagsJson.present ? data.tagsJson.value : this.tagsJson,
      attachmentPath: data.attachmentPath.present
          ? data.attachmentPath.value
          : this.attachmentPath,
      allocationItemId: data.allocationItemId.present
          ? data.allocationItemId.value
          : this.allocationItemId,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      investmentId: data.investmentId.present
          ? data.investmentId.value
          : this.investmentId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionRow(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('date: $date, ')
          ..write('accountId: $accountId, ')
          ..write('toAccountId: $toAccountId, ')
          ..write('categoryId: $categoryId, ')
          ..write('subcategoryId: $subcategoryId, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('incomeSourceId: $incomeSourceId, ')
          ..write('note: $note, ')
          ..write('tagsJson: $tagsJson, ')
          ..write('attachmentPath: $attachmentPath, ')
          ..write('allocationItemId: $allocationItemId, ')
          ..write('goalId: $goalId, ')
          ..write('investmentId: $investmentId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    amountMinor,
    date,
    accountId,
    toAccountId,
    categoryId,
    subcategoryId,
    paymentMethod,
    incomeSourceId,
    note,
    tagsJson,
    attachmentPath,
    allocationItemId,
    goalId,
    investmentId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionRow &&
          other.id == this.id &&
          other.type == this.type &&
          other.amountMinor == this.amountMinor &&
          other.date == this.date &&
          other.accountId == this.accountId &&
          other.toAccountId == this.toAccountId &&
          other.categoryId == this.categoryId &&
          other.subcategoryId == this.subcategoryId &&
          other.paymentMethod == this.paymentMethod &&
          other.incomeSourceId == this.incomeSourceId &&
          other.note == this.note &&
          other.tagsJson == this.tagsJson &&
          other.attachmentPath == this.attachmentPath &&
          other.allocationItemId == this.allocationItemId &&
          other.goalId == this.goalId &&
          other.investmentId == this.investmentId &&
          other.createdAt == this.createdAt);
}

class TransactionsCompanion extends UpdateCompanion<TransactionRow> {
  final Value<String> id;
  final Value<String> type;
  final Value<int> amountMinor;
  final Value<DateTime> date;
  final Value<String> accountId;
  final Value<String?> toAccountId;
  final Value<String?> categoryId;
  final Value<String?> subcategoryId;
  final Value<String?> paymentMethod;
  final Value<String?> incomeSourceId;
  final Value<String?> note;
  final Value<String> tagsJson;
  final Value<String?> attachmentPath;
  final Value<String?> allocationItemId;
  final Value<String?> goalId;
  final Value<String?> investmentId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.amountMinor = const Value.absent(),
    this.date = const Value.absent(),
    this.accountId = const Value.absent(),
    this.toAccountId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.subcategoryId = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.incomeSourceId = const Value.absent(),
    this.note = const Value.absent(),
    this.tagsJson = const Value.absent(),
    this.attachmentPath = const Value.absent(),
    this.allocationItemId = const Value.absent(),
    this.goalId = const Value.absent(),
    this.investmentId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionsCompanion.insert({
    required String id,
    required String type,
    required int amountMinor,
    required DateTime date,
    required String accountId,
    this.toAccountId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.subcategoryId = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.incomeSourceId = const Value.absent(),
    this.note = const Value.absent(),
    this.tagsJson = const Value.absent(),
    this.attachmentPath = const Value.absent(),
    this.allocationItemId = const Value.absent(),
    this.goalId = const Value.absent(),
    this.investmentId = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type),
       amountMinor = Value(amountMinor),
       date = Value(date),
       accountId = Value(accountId),
       createdAt = Value(createdAt);
  static Insertable<TransactionRow> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<int>? amountMinor,
    Expression<DateTime>? date,
    Expression<String>? accountId,
    Expression<String>? toAccountId,
    Expression<String>? categoryId,
    Expression<String>? subcategoryId,
    Expression<String>? paymentMethod,
    Expression<String>? incomeSourceId,
    Expression<String>? note,
    Expression<String>? tagsJson,
    Expression<String>? attachmentPath,
    Expression<String>? allocationItemId,
    Expression<String>? goalId,
    Expression<String>? investmentId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (amountMinor != null) 'amount_minor': amountMinor,
      if (date != null) 'date': date,
      if (accountId != null) 'account_id': accountId,
      if (toAccountId != null) 'to_account_id': toAccountId,
      if (categoryId != null) 'category_id': categoryId,
      if (subcategoryId != null) 'subcategory_id': subcategoryId,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (incomeSourceId != null) 'income_source_id': incomeSourceId,
      if (note != null) 'note': note,
      if (tagsJson != null) 'tags_json': tagsJson,
      if (attachmentPath != null) 'attachment_path': attachmentPath,
      if (allocationItemId != null) 'allocation_item_id': allocationItemId,
      if (goalId != null) 'goal_id': goalId,
      if (investmentId != null) 'investment_id': investmentId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionsCompanion copyWith({
    Value<String>? id,
    Value<String>? type,
    Value<int>? amountMinor,
    Value<DateTime>? date,
    Value<String>? accountId,
    Value<String?>? toAccountId,
    Value<String?>? categoryId,
    Value<String?>? subcategoryId,
    Value<String?>? paymentMethod,
    Value<String?>? incomeSourceId,
    Value<String?>? note,
    Value<String>? tagsJson,
    Value<String?>? attachmentPath,
    Value<String?>? allocationItemId,
    Value<String?>? goalId,
    Value<String?>? investmentId,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return TransactionsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      amountMinor: amountMinor ?? this.amountMinor,
      date: date ?? this.date,
      accountId: accountId ?? this.accountId,
      toAccountId: toAccountId ?? this.toAccountId,
      categoryId: categoryId ?? this.categoryId,
      subcategoryId: subcategoryId ?? this.subcategoryId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      incomeSourceId: incomeSourceId ?? this.incomeSourceId,
      note: note ?? this.note,
      tagsJson: tagsJson ?? this.tagsJson,
      attachmentPath: attachmentPath ?? this.attachmentPath,
      allocationItemId: allocationItemId ?? this.allocationItemId,
      goalId: goalId ?? this.goalId,
      investmentId: investmentId ?? this.investmentId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (amountMinor.present) {
      map['amount_minor'] = Variable<int>(amountMinor.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (toAccountId.present) {
      map['to_account_id'] = Variable<String>(toAccountId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (subcategoryId.present) {
      map['subcategory_id'] = Variable<String>(subcategoryId.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (incomeSourceId.present) {
      map['income_source_id'] = Variable<String>(incomeSourceId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (tagsJson.present) {
      map['tags_json'] = Variable<String>(tagsJson.value);
    }
    if (attachmentPath.present) {
      map['attachment_path'] = Variable<String>(attachmentPath.value);
    }
    if (allocationItemId.present) {
      map['allocation_item_id'] = Variable<String>(allocationItemId.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<String>(goalId.value);
    }
    if (investmentId.present) {
      map['investment_id'] = Variable<String>(investmentId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('date: $date, ')
          ..write('accountId: $accountId, ')
          ..write('toAccountId: $toAccountId, ')
          ..write('categoryId: $categoryId, ')
          ..write('subcategoryId: $subcategoryId, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('incomeSourceId: $incomeSourceId, ')
          ..write('note: $note, ')
          ..write('tagsJson: $tagsJson, ')
          ..write('attachmentPath: $attachmentPath, ')
          ..write('allocationItemId: $allocationItemId, ')
          ..write('goalId: $goalId, ')
          ..write('investmentId: $investmentId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $IncomeSourcesTable extends IncomeSources
    with TableInfo<$IncomeSourcesTable, IncomeSourceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IncomeSourcesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _archivedMeta = const VerificationMeta(
    'archived',
  );
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
    'archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, archived];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'income_sources';
  @override
  VerificationContext validateIntegrity(
    Insertable<IncomeSourceRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('archived')) {
      context.handle(
        _archivedMeta,
        archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IncomeSourceRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IncomeSourceRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      archived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archived'],
      )!,
    );
  }

  @override
  $IncomeSourcesTable createAlias(String alias) {
    return $IncomeSourcesTable(attachedDatabase, alias);
  }
}

class IncomeSourceRow extends DataClass implements Insertable<IncomeSourceRow> {
  final String id;
  final String name;
  final bool archived;
  const IncomeSourceRow({
    required this.id,
    required this.name,
    required this.archived,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['archived'] = Variable<bool>(archived);
    return map;
  }

  IncomeSourcesCompanion toCompanion(bool nullToAbsent) {
    return IncomeSourcesCompanion(
      id: Value(id),
      name: Value(name),
      archived: Value(archived),
    );
  }

  factory IncomeSourceRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IncomeSourceRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      archived: serializer.fromJson<bool>(json['archived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'archived': serializer.toJson<bool>(archived),
    };
  }

  IncomeSourceRow copyWith({String? id, String? name, bool? archived}) =>
      IncomeSourceRow(
        id: id ?? this.id,
        name: name ?? this.name,
        archived: archived ?? this.archived,
      );
  IncomeSourceRow copyWithCompanion(IncomeSourcesCompanion data) {
    return IncomeSourceRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      archived: data.archived.present ? data.archived.value : this.archived,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IncomeSourceRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('archived: $archived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, archived);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IncomeSourceRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.archived == this.archived);
}

class IncomeSourcesCompanion extends UpdateCompanion<IncomeSourceRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<bool> archived;
  final Value<int> rowid;
  const IncomeSourcesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.archived = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  IncomeSourcesCompanion.insert({
    required String id,
    required String name,
    this.archived = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<IncomeSourceRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<bool>? archived,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (archived != null) 'archived': archived,
      if (rowid != null) 'rowid': rowid,
    });
  }

  IncomeSourcesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<bool>? archived,
    Value<int>? rowid,
  }) {
    return IncomeSourcesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      archived: archived ?? this.archived,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IncomeSourcesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('archived: $archived, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SalaryProfilesTable extends SalaryProfiles
    with TableInfo<$SalaryProfilesTable, SalaryProfileRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalaryProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseAmountMinorMeta = const VerificationMeta(
    'baseAmountMinor',
  );
  @override
  late final GeneratedColumn<int> baseAmountMinor = GeneratedColumn<int>(
    'base_amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payDayMeta = const VerificationMeta('payDay');
  @override
  late final GeneratedColumn<int> payDay = GeneratedColumn<int>(
    'pay_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _frequencyMeta = const VerificationMeta(
    'frequency',
  );
  @override
  late final GeneratedColumn<String> frequency = GeneratedColumn<String>(
    'frequency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('monthly'),
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('INR'),
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Employer'),
  );
  static const VerificationMeta _effectiveFromMeta = const VerificationMeta(
    'effectiveFrom',
  );
  @override
  late final GeneratedColumn<DateTime> effectiveFrom =
      GeneratedColumn<DateTime>(
        'effective_from',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    baseAmountMinor,
    payDay,
    frequency,
    currency,
    source,
    effectiveFrom,
    active,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'salary_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<SalaryProfileRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('base_amount_minor')) {
      context.handle(
        _baseAmountMinorMeta,
        baseAmountMinor.isAcceptableOrUnknown(
          data['base_amount_minor']!,
          _baseAmountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_baseAmountMinorMeta);
    }
    if (data.containsKey('pay_day')) {
      context.handle(
        _payDayMeta,
        payDay.isAcceptableOrUnknown(data['pay_day']!, _payDayMeta),
      );
    } else if (isInserting) {
      context.missing(_payDayMeta);
    }
    if (data.containsKey('frequency')) {
      context.handle(
        _frequencyMeta,
        frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('effective_from')) {
      context.handle(
        _effectiveFromMeta,
        effectiveFrom.isAcceptableOrUnknown(
          data['effective_from']!,
          _effectiveFromMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_effectiveFromMeta);
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SalaryProfileRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SalaryProfileRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      baseAmountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}base_amount_minor'],
      )!,
      payDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pay_day'],
      )!,
      frequency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}frequency'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      effectiveFrom: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}effective_from'],
      )!,
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
    );
  }

  @override
  $SalaryProfilesTable createAlias(String alias) {
    return $SalaryProfilesTable(attachedDatabase, alias);
  }
}

class SalaryProfileRow extends DataClass
    implements Insertable<SalaryProfileRow> {
  final String id;
  final int baseAmountMinor;
  final int payDay;
  final String frequency;
  final String currency;
  final String source;
  final DateTime effectiveFrom;
  final bool active;
  const SalaryProfileRow({
    required this.id,
    required this.baseAmountMinor,
    required this.payDay,
    required this.frequency,
    required this.currency,
    required this.source,
    required this.effectiveFrom,
    required this.active,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['base_amount_minor'] = Variable<int>(baseAmountMinor);
    map['pay_day'] = Variable<int>(payDay);
    map['frequency'] = Variable<String>(frequency);
    map['currency'] = Variable<String>(currency);
    map['source'] = Variable<String>(source);
    map['effective_from'] = Variable<DateTime>(effectiveFrom);
    map['active'] = Variable<bool>(active);
    return map;
  }

  SalaryProfilesCompanion toCompanion(bool nullToAbsent) {
    return SalaryProfilesCompanion(
      id: Value(id),
      baseAmountMinor: Value(baseAmountMinor),
      payDay: Value(payDay),
      frequency: Value(frequency),
      currency: Value(currency),
      source: Value(source),
      effectiveFrom: Value(effectiveFrom),
      active: Value(active),
    );
  }

  factory SalaryProfileRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SalaryProfileRow(
      id: serializer.fromJson<String>(json['id']),
      baseAmountMinor: serializer.fromJson<int>(json['baseAmountMinor']),
      payDay: serializer.fromJson<int>(json['payDay']),
      frequency: serializer.fromJson<String>(json['frequency']),
      currency: serializer.fromJson<String>(json['currency']),
      source: serializer.fromJson<String>(json['source']),
      effectiveFrom: serializer.fromJson<DateTime>(json['effectiveFrom']),
      active: serializer.fromJson<bool>(json['active']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'baseAmountMinor': serializer.toJson<int>(baseAmountMinor),
      'payDay': serializer.toJson<int>(payDay),
      'frequency': serializer.toJson<String>(frequency),
      'currency': serializer.toJson<String>(currency),
      'source': serializer.toJson<String>(source),
      'effectiveFrom': serializer.toJson<DateTime>(effectiveFrom),
      'active': serializer.toJson<bool>(active),
    };
  }

  SalaryProfileRow copyWith({
    String? id,
    int? baseAmountMinor,
    int? payDay,
    String? frequency,
    String? currency,
    String? source,
    DateTime? effectiveFrom,
    bool? active,
  }) => SalaryProfileRow(
    id: id ?? this.id,
    baseAmountMinor: baseAmountMinor ?? this.baseAmountMinor,
    payDay: payDay ?? this.payDay,
    frequency: frequency ?? this.frequency,
    currency: currency ?? this.currency,
    source: source ?? this.source,
    effectiveFrom: effectiveFrom ?? this.effectiveFrom,
    active: active ?? this.active,
  );
  SalaryProfileRow copyWithCompanion(SalaryProfilesCompanion data) {
    return SalaryProfileRow(
      id: data.id.present ? data.id.value : this.id,
      baseAmountMinor: data.baseAmountMinor.present
          ? data.baseAmountMinor.value
          : this.baseAmountMinor,
      payDay: data.payDay.present ? data.payDay.value : this.payDay,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      currency: data.currency.present ? data.currency.value : this.currency,
      source: data.source.present ? data.source.value : this.source,
      effectiveFrom: data.effectiveFrom.present
          ? data.effectiveFrom.value
          : this.effectiveFrom,
      active: data.active.present ? data.active.value : this.active,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SalaryProfileRow(')
          ..write('id: $id, ')
          ..write('baseAmountMinor: $baseAmountMinor, ')
          ..write('payDay: $payDay, ')
          ..write('frequency: $frequency, ')
          ..write('currency: $currency, ')
          ..write('source: $source, ')
          ..write('effectiveFrom: $effectiveFrom, ')
          ..write('active: $active')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    baseAmountMinor,
    payDay,
    frequency,
    currency,
    source,
    effectiveFrom,
    active,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SalaryProfileRow &&
          other.id == this.id &&
          other.baseAmountMinor == this.baseAmountMinor &&
          other.payDay == this.payDay &&
          other.frequency == this.frequency &&
          other.currency == this.currency &&
          other.source == this.source &&
          other.effectiveFrom == this.effectiveFrom &&
          other.active == this.active);
}

class SalaryProfilesCompanion extends UpdateCompanion<SalaryProfileRow> {
  final Value<String> id;
  final Value<int> baseAmountMinor;
  final Value<int> payDay;
  final Value<String> frequency;
  final Value<String> currency;
  final Value<String> source;
  final Value<DateTime> effectiveFrom;
  final Value<bool> active;
  final Value<int> rowid;
  const SalaryProfilesCompanion({
    this.id = const Value.absent(),
    this.baseAmountMinor = const Value.absent(),
    this.payDay = const Value.absent(),
    this.frequency = const Value.absent(),
    this.currency = const Value.absent(),
    this.source = const Value.absent(),
    this.effectiveFrom = const Value.absent(),
    this.active = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SalaryProfilesCompanion.insert({
    required String id,
    required int baseAmountMinor,
    required int payDay,
    this.frequency = const Value.absent(),
    this.currency = const Value.absent(),
    this.source = const Value.absent(),
    required DateTime effectiveFrom,
    this.active = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       baseAmountMinor = Value(baseAmountMinor),
       payDay = Value(payDay),
       effectiveFrom = Value(effectiveFrom);
  static Insertable<SalaryProfileRow> custom({
    Expression<String>? id,
    Expression<int>? baseAmountMinor,
    Expression<int>? payDay,
    Expression<String>? frequency,
    Expression<String>? currency,
    Expression<String>? source,
    Expression<DateTime>? effectiveFrom,
    Expression<bool>? active,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (baseAmountMinor != null) 'base_amount_minor': baseAmountMinor,
      if (payDay != null) 'pay_day': payDay,
      if (frequency != null) 'frequency': frequency,
      if (currency != null) 'currency': currency,
      if (source != null) 'source': source,
      if (effectiveFrom != null) 'effective_from': effectiveFrom,
      if (active != null) 'active': active,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SalaryProfilesCompanion copyWith({
    Value<String>? id,
    Value<int>? baseAmountMinor,
    Value<int>? payDay,
    Value<String>? frequency,
    Value<String>? currency,
    Value<String>? source,
    Value<DateTime>? effectiveFrom,
    Value<bool>? active,
    Value<int>? rowid,
  }) {
    return SalaryProfilesCompanion(
      id: id ?? this.id,
      baseAmountMinor: baseAmountMinor ?? this.baseAmountMinor,
      payDay: payDay ?? this.payDay,
      frequency: frequency ?? this.frequency,
      currency: currency ?? this.currency,
      source: source ?? this.source,
      effectiveFrom: effectiveFrom ?? this.effectiveFrom,
      active: active ?? this.active,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (baseAmountMinor.present) {
      map['base_amount_minor'] = Variable<int>(baseAmountMinor.value);
    }
    if (payDay.present) {
      map['pay_day'] = Variable<int>(payDay.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(frequency.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (effectiveFrom.present) {
      map['effective_from'] = Variable<DateTime>(effectiveFrom.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalaryProfilesCompanion(')
          ..write('id: $id, ')
          ..write('baseAmountMinor: $baseAmountMinor, ')
          ..write('payDay: $payDay, ')
          ..write('frequency: $frequency, ')
          ..write('currency: $currency, ')
          ..write('source: $source, ')
          ..write('effectiveFrom: $effectiveFrom, ')
          ..write('active: $active, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SalaryHistoryTable extends SalaryHistory
    with TableInfo<$SalaryHistoryTable, SalaryHistoryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalaryHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _previousAmountMinorMeta =
      const VerificationMeta('previousAmountMinor');
  @override
  late final GeneratedColumn<int> previousAmountMinor = GeneratedColumn<int>(
    'previous_amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _newAmountMinorMeta = const VerificationMeta(
    'newAmountMinor',
  );
  @override
  late final GeneratedColumn<int> newAmountMinor = GeneratedColumn<int>(
    'new_amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _effectiveDateMeta = const VerificationMeta(
    'effectiveDate',
  );
  @override
  late final GeneratedColumn<DateTime> effectiveDate =
      GeneratedColumn<DateTime>(
        'effective_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    previousAmountMinor,
    newAmountMinor,
    effectiveDate,
    reason,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'salary_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<SalaryHistoryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('previous_amount_minor')) {
      context.handle(
        _previousAmountMinorMeta,
        previousAmountMinor.isAcceptableOrUnknown(
          data['previous_amount_minor']!,
          _previousAmountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_previousAmountMinorMeta);
    }
    if (data.containsKey('new_amount_minor')) {
      context.handle(
        _newAmountMinorMeta,
        newAmountMinor.isAcceptableOrUnknown(
          data['new_amount_minor']!,
          _newAmountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_newAmountMinorMeta);
    }
    if (data.containsKey('effective_date')) {
      context.handle(
        _effectiveDateMeta,
        effectiveDate.isAcceptableOrUnknown(
          data['effective_date']!,
          _effectiveDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_effectiveDateMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SalaryHistoryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SalaryHistoryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      previousAmountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}previous_amount_minor'],
      )!,
      newAmountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}new_amount_minor'],
      )!,
      effectiveDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}effective_date'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $SalaryHistoryTable createAlias(String alias) {
    return $SalaryHistoryTable(attachedDatabase, alias);
  }
}

class SalaryHistoryRow extends DataClass
    implements Insertable<SalaryHistoryRow> {
  final String id;
  final int previousAmountMinor;
  final int newAmountMinor;
  final DateTime effectiveDate;
  final String? reason;
  final String? notes;
  const SalaryHistoryRow({
    required this.id,
    required this.previousAmountMinor,
    required this.newAmountMinor,
    required this.effectiveDate,
    this.reason,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['previous_amount_minor'] = Variable<int>(previousAmountMinor);
    map['new_amount_minor'] = Variable<int>(newAmountMinor);
    map['effective_date'] = Variable<DateTime>(effectiveDate);
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  SalaryHistoryCompanion toCompanion(bool nullToAbsent) {
    return SalaryHistoryCompanion(
      id: Value(id),
      previousAmountMinor: Value(previousAmountMinor),
      newAmountMinor: Value(newAmountMinor),
      effectiveDate: Value(effectiveDate),
      reason: reason == null && nullToAbsent
          ? const Value.absent()
          : Value(reason),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory SalaryHistoryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SalaryHistoryRow(
      id: serializer.fromJson<String>(json['id']),
      previousAmountMinor: serializer.fromJson<int>(
        json['previousAmountMinor'],
      ),
      newAmountMinor: serializer.fromJson<int>(json['newAmountMinor']),
      effectiveDate: serializer.fromJson<DateTime>(json['effectiveDate']),
      reason: serializer.fromJson<String?>(json['reason']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'previousAmountMinor': serializer.toJson<int>(previousAmountMinor),
      'newAmountMinor': serializer.toJson<int>(newAmountMinor),
      'effectiveDate': serializer.toJson<DateTime>(effectiveDate),
      'reason': serializer.toJson<String?>(reason),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  SalaryHistoryRow copyWith({
    String? id,
    int? previousAmountMinor,
    int? newAmountMinor,
    DateTime? effectiveDate,
    Value<String?> reason = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => SalaryHistoryRow(
    id: id ?? this.id,
    previousAmountMinor: previousAmountMinor ?? this.previousAmountMinor,
    newAmountMinor: newAmountMinor ?? this.newAmountMinor,
    effectiveDate: effectiveDate ?? this.effectiveDate,
    reason: reason.present ? reason.value : this.reason,
    notes: notes.present ? notes.value : this.notes,
  );
  SalaryHistoryRow copyWithCompanion(SalaryHistoryCompanion data) {
    return SalaryHistoryRow(
      id: data.id.present ? data.id.value : this.id,
      previousAmountMinor: data.previousAmountMinor.present
          ? data.previousAmountMinor.value
          : this.previousAmountMinor,
      newAmountMinor: data.newAmountMinor.present
          ? data.newAmountMinor.value
          : this.newAmountMinor,
      effectiveDate: data.effectiveDate.present
          ? data.effectiveDate.value
          : this.effectiveDate,
      reason: data.reason.present ? data.reason.value : this.reason,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SalaryHistoryRow(')
          ..write('id: $id, ')
          ..write('previousAmountMinor: $previousAmountMinor, ')
          ..write('newAmountMinor: $newAmountMinor, ')
          ..write('effectiveDate: $effectiveDate, ')
          ..write('reason: $reason, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    previousAmountMinor,
    newAmountMinor,
    effectiveDate,
    reason,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SalaryHistoryRow &&
          other.id == this.id &&
          other.previousAmountMinor == this.previousAmountMinor &&
          other.newAmountMinor == this.newAmountMinor &&
          other.effectiveDate == this.effectiveDate &&
          other.reason == this.reason &&
          other.notes == this.notes);
}

class SalaryHistoryCompanion extends UpdateCompanion<SalaryHistoryRow> {
  final Value<String> id;
  final Value<int> previousAmountMinor;
  final Value<int> newAmountMinor;
  final Value<DateTime> effectiveDate;
  final Value<String?> reason;
  final Value<String?> notes;
  final Value<int> rowid;
  const SalaryHistoryCompanion({
    this.id = const Value.absent(),
    this.previousAmountMinor = const Value.absent(),
    this.newAmountMinor = const Value.absent(),
    this.effectiveDate = const Value.absent(),
    this.reason = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SalaryHistoryCompanion.insert({
    required String id,
    required int previousAmountMinor,
    required int newAmountMinor,
    required DateTime effectiveDate,
    this.reason = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       previousAmountMinor = Value(previousAmountMinor),
       newAmountMinor = Value(newAmountMinor),
       effectiveDate = Value(effectiveDate);
  static Insertable<SalaryHistoryRow> custom({
    Expression<String>? id,
    Expression<int>? previousAmountMinor,
    Expression<int>? newAmountMinor,
    Expression<DateTime>? effectiveDate,
    Expression<String>? reason,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (previousAmountMinor != null)
        'previous_amount_minor': previousAmountMinor,
      if (newAmountMinor != null) 'new_amount_minor': newAmountMinor,
      if (effectiveDate != null) 'effective_date': effectiveDate,
      if (reason != null) 'reason': reason,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SalaryHistoryCompanion copyWith({
    Value<String>? id,
    Value<int>? previousAmountMinor,
    Value<int>? newAmountMinor,
    Value<DateTime>? effectiveDate,
    Value<String?>? reason,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return SalaryHistoryCompanion(
      id: id ?? this.id,
      previousAmountMinor: previousAmountMinor ?? this.previousAmountMinor,
      newAmountMinor: newAmountMinor ?? this.newAmountMinor,
      effectiveDate: effectiveDate ?? this.effectiveDate,
      reason: reason ?? this.reason,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (previousAmountMinor.present) {
      map['previous_amount_minor'] = Variable<int>(previousAmountMinor.value);
    }
    if (newAmountMinor.present) {
      map['new_amount_minor'] = Variable<int>(newAmountMinor.value);
    }
    if (effectiveDate.present) {
      map['effective_date'] = Variable<DateTime>(effectiveDate.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalaryHistoryCompanion(')
          ..write('id: $id, ')
          ..write('previousAmountMinor: $previousAmountMinor, ')
          ..write('newAmountMinor: $newAmountMinor, ')
          ..write('effectiveDate: $effectiveDate, ')
          ..write('reason: $reason, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MonthlyPlansTable extends MonthlyPlans
    with TableInfo<$MonthlyPlansTable, MonthlyPlanRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MonthlyPlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<int> month = GeneratedColumn<int>(
    'month',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expectedIncomeMinorMeta =
      const VerificationMeta('expectedIncomeMinor');
  @override
  late final GeneratedColumn<int> expectedIncomeMinor = GeneratedColumn<int>(
    'expected_income_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confirmedMeta = const VerificationMeta(
    'confirmed',
  );
  @override
  late final GeneratedColumn<bool> confirmed = GeneratedColumn<bool>(
    'confirmed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("confirmed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    year,
    month,
    expectedIncomeMinor,
    confirmed,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'monthly_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<MonthlyPlanRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('month')) {
      context.handle(
        _monthMeta,
        month.isAcceptableOrUnknown(data['month']!, _monthMeta),
      );
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('expected_income_minor')) {
      context.handle(
        _expectedIncomeMinorMeta,
        expectedIncomeMinor.isAcceptableOrUnknown(
          data['expected_income_minor']!,
          _expectedIncomeMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_expectedIncomeMinorMeta);
    }
    if (data.containsKey('confirmed')) {
      context.handle(
        _confirmedMeta,
        confirmed.isAcceptableOrUnknown(data['confirmed']!, _confirmedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MonthlyPlanRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MonthlyPlanRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      )!,
      month: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}month'],
      )!,
      expectedIncomeMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expected_income_minor'],
      )!,
      confirmed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}confirmed'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MonthlyPlansTable createAlias(String alias) {
    return $MonthlyPlansTable(attachedDatabase, alias);
  }
}

class MonthlyPlanRow extends DataClass implements Insertable<MonthlyPlanRow> {
  final String id;
  final int year;
  final int month;
  final int expectedIncomeMinor;
  final bool confirmed;
  final DateTime createdAt;
  const MonthlyPlanRow({
    required this.id,
    required this.year,
    required this.month,
    required this.expectedIncomeMinor,
    required this.confirmed,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['year'] = Variable<int>(year);
    map['month'] = Variable<int>(month);
    map['expected_income_minor'] = Variable<int>(expectedIncomeMinor);
    map['confirmed'] = Variable<bool>(confirmed);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MonthlyPlansCompanion toCompanion(bool nullToAbsent) {
    return MonthlyPlansCompanion(
      id: Value(id),
      year: Value(year),
      month: Value(month),
      expectedIncomeMinor: Value(expectedIncomeMinor),
      confirmed: Value(confirmed),
      createdAt: Value(createdAt),
    );
  }

  factory MonthlyPlanRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MonthlyPlanRow(
      id: serializer.fromJson<String>(json['id']),
      year: serializer.fromJson<int>(json['year']),
      month: serializer.fromJson<int>(json['month']),
      expectedIncomeMinor: serializer.fromJson<int>(
        json['expectedIncomeMinor'],
      ),
      confirmed: serializer.fromJson<bool>(json['confirmed']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'year': serializer.toJson<int>(year),
      'month': serializer.toJson<int>(month),
      'expectedIncomeMinor': serializer.toJson<int>(expectedIncomeMinor),
      'confirmed': serializer.toJson<bool>(confirmed),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MonthlyPlanRow copyWith({
    String? id,
    int? year,
    int? month,
    int? expectedIncomeMinor,
    bool? confirmed,
    DateTime? createdAt,
  }) => MonthlyPlanRow(
    id: id ?? this.id,
    year: year ?? this.year,
    month: month ?? this.month,
    expectedIncomeMinor: expectedIncomeMinor ?? this.expectedIncomeMinor,
    confirmed: confirmed ?? this.confirmed,
    createdAt: createdAt ?? this.createdAt,
  );
  MonthlyPlanRow copyWithCompanion(MonthlyPlansCompanion data) {
    return MonthlyPlanRow(
      id: data.id.present ? data.id.value : this.id,
      year: data.year.present ? data.year.value : this.year,
      month: data.month.present ? data.month.value : this.month,
      expectedIncomeMinor: data.expectedIncomeMinor.present
          ? data.expectedIncomeMinor.value
          : this.expectedIncomeMinor,
      confirmed: data.confirmed.present ? data.confirmed.value : this.confirmed,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyPlanRow(')
          ..write('id: $id, ')
          ..write('year: $year, ')
          ..write('month: $month, ')
          ..write('expectedIncomeMinor: $expectedIncomeMinor, ')
          ..write('confirmed: $confirmed, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, year, month, expectedIncomeMinor, confirmed, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MonthlyPlanRow &&
          other.id == this.id &&
          other.year == this.year &&
          other.month == this.month &&
          other.expectedIncomeMinor == this.expectedIncomeMinor &&
          other.confirmed == this.confirmed &&
          other.createdAt == this.createdAt);
}

class MonthlyPlansCompanion extends UpdateCompanion<MonthlyPlanRow> {
  final Value<String> id;
  final Value<int> year;
  final Value<int> month;
  final Value<int> expectedIncomeMinor;
  final Value<bool> confirmed;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const MonthlyPlansCompanion({
    this.id = const Value.absent(),
    this.year = const Value.absent(),
    this.month = const Value.absent(),
    this.expectedIncomeMinor = const Value.absent(),
    this.confirmed = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MonthlyPlansCompanion.insert({
    required String id,
    required int year,
    required int month,
    required int expectedIncomeMinor,
    this.confirmed = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       year = Value(year),
       month = Value(month),
       expectedIncomeMinor = Value(expectedIncomeMinor),
       createdAt = Value(createdAt);
  static Insertable<MonthlyPlanRow> custom({
    Expression<String>? id,
    Expression<int>? year,
    Expression<int>? month,
    Expression<int>? expectedIncomeMinor,
    Expression<bool>? confirmed,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (year != null) 'year': year,
      if (month != null) 'month': month,
      if (expectedIncomeMinor != null)
        'expected_income_minor': expectedIncomeMinor,
      if (confirmed != null) 'confirmed': confirmed,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MonthlyPlansCompanion copyWith({
    Value<String>? id,
    Value<int>? year,
    Value<int>? month,
    Value<int>? expectedIncomeMinor,
    Value<bool>? confirmed,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return MonthlyPlansCompanion(
      id: id ?? this.id,
      year: year ?? this.year,
      month: month ?? this.month,
      expectedIncomeMinor: expectedIncomeMinor ?? this.expectedIncomeMinor,
      confirmed: confirmed ?? this.confirmed,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (month.present) {
      map['month'] = Variable<int>(month.value);
    }
    if (expectedIncomeMinor.present) {
      map['expected_income_minor'] = Variable<int>(expectedIncomeMinor.value);
    }
    if (confirmed.present) {
      map['confirmed'] = Variable<bool>(confirmed.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyPlansCompanion(')
          ..write('id: $id, ')
          ..write('year: $year, ')
          ..write('month: $month, ')
          ..write('expectedIncomeMinor: $expectedIncomeMinor, ')
          ..write('confirmed: $confirmed, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AllocationItemsTable extends AllocationItems
    with TableInfo<$AllocationItemsTable, AllocationItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AllocationItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<String> planId = GeneratedColumn<String>(
    'plan_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _plannedAmountMinorMeta =
      const VerificationMeta('plannedAmountMinor');
  @override
  late final GeneratedColumn<int> plannedAmountMinor = GeneratedColumn<int>(
    'planned_amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actualAmountMinorMeta = const VerificationMeta(
    'actualAmountMinor',
  );
  @override
  late final GeneratedColumn<int> actualAmountMinor = GeneratedColumn<int>(
    'actual_amount_minor',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<String> goalId = GeneratedColumn<String>(
    'goal_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _investmentIdMeta = const VerificationMeta(
    'investmentId',
  );
  @override
  late final GeneratedColumn<String> investmentId = GeneratedColumn<String>(
    'investment_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _billIdMeta = const VerificationMeta('billId');
  @override
  late final GeneratedColumn<String> billId = GeneratedColumn<String>(
    'bill_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _loanIdMeta = const VerificationMeta('loanId');
  @override
  late final GeneratedColumn<String> loanId = GeneratedColumn<String>(
    'loan_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _skipReasonMeta = const VerificationMeta(
    'skipReason',
  );
  @override
  late final GeneratedColumn<String> skipReason = GeneratedColumn<String>(
    'skip_reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _skipNoteMeta = const VerificationMeta(
    'skipNote',
  );
  @override
  late final GeneratedColumn<String> skipNote = GeneratedColumn<String>(
    'skip_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    planId,
    name,
    kind,
    plannedAmountMinor,
    actualAmountMinor,
    status,
    categoryId,
    goalId,
    investmentId,
    billId,
    loanId,
    accountId,
    skipReason,
    skipNote,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'allocation_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<AllocationItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
      );
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('planned_amount_minor')) {
      context.handle(
        _plannedAmountMinorMeta,
        plannedAmountMinor.isAcceptableOrUnknown(
          data['planned_amount_minor']!,
          _plannedAmountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_plannedAmountMinorMeta);
    }
    if (data.containsKey('actual_amount_minor')) {
      context.handle(
        _actualAmountMinorMeta,
        actualAmountMinor.isAcceptableOrUnknown(
          data['actual_amount_minor']!,
          _actualAmountMinorMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('goal_id')) {
      context.handle(
        _goalIdMeta,
        goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta),
      );
    }
    if (data.containsKey('investment_id')) {
      context.handle(
        _investmentIdMeta,
        investmentId.isAcceptableOrUnknown(
          data['investment_id']!,
          _investmentIdMeta,
        ),
      );
    }
    if (data.containsKey('bill_id')) {
      context.handle(
        _billIdMeta,
        billId.isAcceptableOrUnknown(data['bill_id']!, _billIdMeta),
      );
    }
    if (data.containsKey('loan_id')) {
      context.handle(
        _loanIdMeta,
        loanId.isAcceptableOrUnknown(data['loan_id']!, _loanIdMeta),
      );
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    }
    if (data.containsKey('skip_reason')) {
      context.handle(
        _skipReasonMeta,
        skipReason.isAcceptableOrUnknown(data['skip_reason']!, _skipReasonMeta),
      );
    }
    if (data.containsKey('skip_note')) {
      context.handle(
        _skipNoteMeta,
        skipNote.isAcceptableOrUnknown(data['skip_note']!, _skipNoteMeta),
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
  AllocationItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AllocationItemRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      planId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      plannedAmountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}planned_amount_minor'],
      )!,
      actualAmountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}actual_amount_minor'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      goalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal_id'],
      ),
      investmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}investment_id'],
      ),
      billId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bill_id'],
      ),
      loanId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}loan_id'],
      ),
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      ),
      skipReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}skip_reason'],
      ),
      skipNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}skip_note'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $AllocationItemsTable createAlias(String alias) {
    return $AllocationItemsTable(attachedDatabase, alias);
  }
}

class AllocationItemRow extends DataClass
    implements Insertable<AllocationItemRow> {
  final String id;
  final String planId;
  final String name;
  final String kind;
  final int plannedAmountMinor;
  final int? actualAmountMinor;
  final String status;
  final String? categoryId;
  final String? goalId;
  final String? investmentId;
  final String? billId;
  final String? loanId;
  final String? accountId;
  final String? skipReason;
  final String? skipNote;
  final int sortOrder;
  const AllocationItemRow({
    required this.id,
    required this.planId,
    required this.name,
    required this.kind,
    required this.plannedAmountMinor,
    this.actualAmountMinor,
    required this.status,
    this.categoryId,
    this.goalId,
    this.investmentId,
    this.billId,
    this.loanId,
    this.accountId,
    this.skipReason,
    this.skipNote,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['plan_id'] = Variable<String>(planId);
    map['name'] = Variable<String>(name);
    map['kind'] = Variable<String>(kind);
    map['planned_amount_minor'] = Variable<int>(plannedAmountMinor);
    if (!nullToAbsent || actualAmountMinor != null) {
      map['actual_amount_minor'] = Variable<int>(actualAmountMinor);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    if (!nullToAbsent || goalId != null) {
      map['goal_id'] = Variable<String>(goalId);
    }
    if (!nullToAbsent || investmentId != null) {
      map['investment_id'] = Variable<String>(investmentId);
    }
    if (!nullToAbsent || billId != null) {
      map['bill_id'] = Variable<String>(billId);
    }
    if (!nullToAbsent || loanId != null) {
      map['loan_id'] = Variable<String>(loanId);
    }
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<String>(accountId);
    }
    if (!nullToAbsent || skipReason != null) {
      map['skip_reason'] = Variable<String>(skipReason);
    }
    if (!nullToAbsent || skipNote != null) {
      map['skip_note'] = Variable<String>(skipNote);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  AllocationItemsCompanion toCompanion(bool nullToAbsent) {
    return AllocationItemsCompanion(
      id: Value(id),
      planId: Value(planId),
      name: Value(name),
      kind: Value(kind),
      plannedAmountMinor: Value(plannedAmountMinor),
      actualAmountMinor: actualAmountMinor == null && nullToAbsent
          ? const Value.absent()
          : Value(actualAmountMinor),
      status: Value(status),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      goalId: goalId == null && nullToAbsent
          ? const Value.absent()
          : Value(goalId),
      investmentId: investmentId == null && nullToAbsent
          ? const Value.absent()
          : Value(investmentId),
      billId: billId == null && nullToAbsent
          ? const Value.absent()
          : Value(billId),
      loanId: loanId == null && nullToAbsent
          ? const Value.absent()
          : Value(loanId),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
      skipReason: skipReason == null && nullToAbsent
          ? const Value.absent()
          : Value(skipReason),
      skipNote: skipNote == null && nullToAbsent
          ? const Value.absent()
          : Value(skipNote),
      sortOrder: Value(sortOrder),
    );
  }

  factory AllocationItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AllocationItemRow(
      id: serializer.fromJson<String>(json['id']),
      planId: serializer.fromJson<String>(json['planId']),
      name: serializer.fromJson<String>(json['name']),
      kind: serializer.fromJson<String>(json['kind']),
      plannedAmountMinor: serializer.fromJson<int>(json['plannedAmountMinor']),
      actualAmountMinor: serializer.fromJson<int?>(json['actualAmountMinor']),
      status: serializer.fromJson<String>(json['status']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      goalId: serializer.fromJson<String?>(json['goalId']),
      investmentId: serializer.fromJson<String?>(json['investmentId']),
      billId: serializer.fromJson<String?>(json['billId']),
      loanId: serializer.fromJson<String?>(json['loanId']),
      accountId: serializer.fromJson<String?>(json['accountId']),
      skipReason: serializer.fromJson<String?>(json['skipReason']),
      skipNote: serializer.fromJson<String?>(json['skipNote']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'planId': serializer.toJson<String>(planId),
      'name': serializer.toJson<String>(name),
      'kind': serializer.toJson<String>(kind),
      'plannedAmountMinor': serializer.toJson<int>(plannedAmountMinor),
      'actualAmountMinor': serializer.toJson<int?>(actualAmountMinor),
      'status': serializer.toJson<String>(status),
      'categoryId': serializer.toJson<String?>(categoryId),
      'goalId': serializer.toJson<String?>(goalId),
      'investmentId': serializer.toJson<String?>(investmentId),
      'billId': serializer.toJson<String?>(billId),
      'loanId': serializer.toJson<String?>(loanId),
      'accountId': serializer.toJson<String?>(accountId),
      'skipReason': serializer.toJson<String?>(skipReason),
      'skipNote': serializer.toJson<String?>(skipNote),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  AllocationItemRow copyWith({
    String? id,
    String? planId,
    String? name,
    String? kind,
    int? plannedAmountMinor,
    Value<int?> actualAmountMinor = const Value.absent(),
    String? status,
    Value<String?> categoryId = const Value.absent(),
    Value<String?> goalId = const Value.absent(),
    Value<String?> investmentId = const Value.absent(),
    Value<String?> billId = const Value.absent(),
    Value<String?> loanId = const Value.absent(),
    Value<String?> accountId = const Value.absent(),
    Value<String?> skipReason = const Value.absent(),
    Value<String?> skipNote = const Value.absent(),
    int? sortOrder,
  }) => AllocationItemRow(
    id: id ?? this.id,
    planId: planId ?? this.planId,
    name: name ?? this.name,
    kind: kind ?? this.kind,
    plannedAmountMinor: plannedAmountMinor ?? this.plannedAmountMinor,
    actualAmountMinor: actualAmountMinor.present
        ? actualAmountMinor.value
        : this.actualAmountMinor,
    status: status ?? this.status,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    goalId: goalId.present ? goalId.value : this.goalId,
    investmentId: investmentId.present ? investmentId.value : this.investmentId,
    billId: billId.present ? billId.value : this.billId,
    loanId: loanId.present ? loanId.value : this.loanId,
    accountId: accountId.present ? accountId.value : this.accountId,
    skipReason: skipReason.present ? skipReason.value : this.skipReason,
    skipNote: skipNote.present ? skipNote.value : this.skipNote,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  AllocationItemRow copyWithCompanion(AllocationItemsCompanion data) {
    return AllocationItemRow(
      id: data.id.present ? data.id.value : this.id,
      planId: data.planId.present ? data.planId.value : this.planId,
      name: data.name.present ? data.name.value : this.name,
      kind: data.kind.present ? data.kind.value : this.kind,
      plannedAmountMinor: data.plannedAmountMinor.present
          ? data.plannedAmountMinor.value
          : this.plannedAmountMinor,
      actualAmountMinor: data.actualAmountMinor.present
          ? data.actualAmountMinor.value
          : this.actualAmountMinor,
      status: data.status.present ? data.status.value : this.status,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      investmentId: data.investmentId.present
          ? data.investmentId.value
          : this.investmentId,
      billId: data.billId.present ? data.billId.value : this.billId,
      loanId: data.loanId.present ? data.loanId.value : this.loanId,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      skipReason: data.skipReason.present
          ? data.skipReason.value
          : this.skipReason,
      skipNote: data.skipNote.present ? data.skipNote.value : this.skipNote,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AllocationItemRow(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('plannedAmountMinor: $plannedAmountMinor, ')
          ..write('actualAmountMinor: $actualAmountMinor, ')
          ..write('status: $status, ')
          ..write('categoryId: $categoryId, ')
          ..write('goalId: $goalId, ')
          ..write('investmentId: $investmentId, ')
          ..write('billId: $billId, ')
          ..write('loanId: $loanId, ')
          ..write('accountId: $accountId, ')
          ..write('skipReason: $skipReason, ')
          ..write('skipNote: $skipNote, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    planId,
    name,
    kind,
    plannedAmountMinor,
    actualAmountMinor,
    status,
    categoryId,
    goalId,
    investmentId,
    billId,
    loanId,
    accountId,
    skipReason,
    skipNote,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AllocationItemRow &&
          other.id == this.id &&
          other.planId == this.planId &&
          other.name == this.name &&
          other.kind == this.kind &&
          other.plannedAmountMinor == this.plannedAmountMinor &&
          other.actualAmountMinor == this.actualAmountMinor &&
          other.status == this.status &&
          other.categoryId == this.categoryId &&
          other.goalId == this.goalId &&
          other.investmentId == this.investmentId &&
          other.billId == this.billId &&
          other.loanId == this.loanId &&
          other.accountId == this.accountId &&
          other.skipReason == this.skipReason &&
          other.skipNote == this.skipNote &&
          other.sortOrder == this.sortOrder);
}

class AllocationItemsCompanion extends UpdateCompanion<AllocationItemRow> {
  final Value<String> id;
  final Value<String> planId;
  final Value<String> name;
  final Value<String> kind;
  final Value<int> plannedAmountMinor;
  final Value<int?> actualAmountMinor;
  final Value<String> status;
  final Value<String?> categoryId;
  final Value<String?> goalId;
  final Value<String?> investmentId;
  final Value<String?> billId;
  final Value<String?> loanId;
  final Value<String?> accountId;
  final Value<String?> skipReason;
  final Value<String?> skipNote;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const AllocationItemsCompanion({
    this.id = const Value.absent(),
    this.planId = const Value.absent(),
    this.name = const Value.absent(),
    this.kind = const Value.absent(),
    this.plannedAmountMinor = const Value.absent(),
    this.actualAmountMinor = const Value.absent(),
    this.status = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.goalId = const Value.absent(),
    this.investmentId = const Value.absent(),
    this.billId = const Value.absent(),
    this.loanId = const Value.absent(),
    this.accountId = const Value.absent(),
    this.skipReason = const Value.absent(),
    this.skipNote = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AllocationItemsCompanion.insert({
    required String id,
    required String planId,
    required String name,
    required String kind,
    required int plannedAmountMinor,
    this.actualAmountMinor = const Value.absent(),
    this.status = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.goalId = const Value.absent(),
    this.investmentId = const Value.absent(),
    this.billId = const Value.absent(),
    this.loanId = const Value.absent(),
    this.accountId = const Value.absent(),
    this.skipReason = const Value.absent(),
    this.skipNote = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       planId = Value(planId),
       name = Value(name),
       kind = Value(kind),
       plannedAmountMinor = Value(plannedAmountMinor);
  static Insertable<AllocationItemRow> custom({
    Expression<String>? id,
    Expression<String>? planId,
    Expression<String>? name,
    Expression<String>? kind,
    Expression<int>? plannedAmountMinor,
    Expression<int>? actualAmountMinor,
    Expression<String>? status,
    Expression<String>? categoryId,
    Expression<String>? goalId,
    Expression<String>? investmentId,
    Expression<String>? billId,
    Expression<String>? loanId,
    Expression<String>? accountId,
    Expression<String>? skipReason,
    Expression<String>? skipNote,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (planId != null) 'plan_id': planId,
      if (name != null) 'name': name,
      if (kind != null) 'kind': kind,
      if (plannedAmountMinor != null)
        'planned_amount_minor': plannedAmountMinor,
      if (actualAmountMinor != null) 'actual_amount_minor': actualAmountMinor,
      if (status != null) 'status': status,
      if (categoryId != null) 'category_id': categoryId,
      if (goalId != null) 'goal_id': goalId,
      if (investmentId != null) 'investment_id': investmentId,
      if (billId != null) 'bill_id': billId,
      if (loanId != null) 'loan_id': loanId,
      if (accountId != null) 'account_id': accountId,
      if (skipReason != null) 'skip_reason': skipReason,
      if (skipNote != null) 'skip_note': skipNote,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AllocationItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? planId,
    Value<String>? name,
    Value<String>? kind,
    Value<int>? plannedAmountMinor,
    Value<int?>? actualAmountMinor,
    Value<String>? status,
    Value<String?>? categoryId,
    Value<String?>? goalId,
    Value<String?>? investmentId,
    Value<String?>? billId,
    Value<String?>? loanId,
    Value<String?>? accountId,
    Value<String?>? skipReason,
    Value<String?>? skipNote,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return AllocationItemsCompanion(
      id: id ?? this.id,
      planId: planId ?? this.planId,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      plannedAmountMinor: plannedAmountMinor ?? this.plannedAmountMinor,
      actualAmountMinor: actualAmountMinor ?? this.actualAmountMinor,
      status: status ?? this.status,
      categoryId: categoryId ?? this.categoryId,
      goalId: goalId ?? this.goalId,
      investmentId: investmentId ?? this.investmentId,
      billId: billId ?? this.billId,
      loanId: loanId ?? this.loanId,
      accountId: accountId ?? this.accountId,
      skipReason: skipReason ?? this.skipReason,
      skipNote: skipNote ?? this.skipNote,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<String>(planId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (plannedAmountMinor.present) {
      map['planned_amount_minor'] = Variable<int>(plannedAmountMinor.value);
    }
    if (actualAmountMinor.present) {
      map['actual_amount_minor'] = Variable<int>(actualAmountMinor.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<String>(goalId.value);
    }
    if (investmentId.present) {
      map['investment_id'] = Variable<String>(investmentId.value);
    }
    if (billId.present) {
      map['bill_id'] = Variable<String>(billId.value);
    }
    if (loanId.present) {
      map['loan_id'] = Variable<String>(loanId.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (skipReason.present) {
      map['skip_reason'] = Variable<String>(skipReason.value);
    }
    if (skipNote.present) {
      map['skip_note'] = Variable<String>(skipNote.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AllocationItemsCompanion(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('plannedAmountMinor: $plannedAmountMinor, ')
          ..write('actualAmountMinor: $actualAmountMinor, ')
          ..write('status: $status, ')
          ..write('categoryId: $categoryId, ')
          ..write('goalId: $goalId, ')
          ..write('investmentId: $investmentId, ')
          ..write('billId: $billId, ')
          ..write('loanId: $loanId, ')
          ..write('accountId: $accountId, ')
          ..write('skipReason: $skipReason, ')
          ..write('skipNote: $skipNote, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AllocationTemplatesTable extends AllocationTemplates
    with TableInfo<$AllocationTemplatesTable, AllocationTemplateRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AllocationTemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _plannedAmountMinorMeta =
      const VerificationMeta('plannedAmountMinor');
  @override
  late final GeneratedColumn<int> plannedAmountMinor = GeneratedColumn<int>(
    'planned_amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<String> goalId = GeneratedColumn<String>(
    'goal_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _investmentIdMeta = const VerificationMeta(
    'investmentId',
  );
  @override
  late final GeneratedColumn<String> investmentId = GeneratedColumn<String>(
    'investment_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _billIdMeta = const VerificationMeta('billId');
  @override
  late final GeneratedColumn<String> billId = GeneratedColumn<String>(
    'bill_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _loanIdMeta = const VerificationMeta('loanId');
  @override
  late final GeneratedColumn<String> loanId = GeneratedColumn<String>(
    'loan_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    name,
    kind,
    plannedAmountMinor,
    categoryId,
    goalId,
    investmentId,
    billId,
    loanId,
    accountId,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'allocation_templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<AllocationTemplateRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('planned_amount_minor')) {
      context.handle(
        _plannedAmountMinorMeta,
        plannedAmountMinor.isAcceptableOrUnknown(
          data['planned_amount_minor']!,
          _plannedAmountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_plannedAmountMinorMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('goal_id')) {
      context.handle(
        _goalIdMeta,
        goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta),
      );
    }
    if (data.containsKey('investment_id')) {
      context.handle(
        _investmentIdMeta,
        investmentId.isAcceptableOrUnknown(
          data['investment_id']!,
          _investmentIdMeta,
        ),
      );
    }
    if (data.containsKey('bill_id')) {
      context.handle(
        _billIdMeta,
        billId.isAcceptableOrUnknown(data['bill_id']!, _billIdMeta),
      );
    }
    if (data.containsKey('loan_id')) {
      context.handle(
        _loanIdMeta,
        loanId.isAcceptableOrUnknown(data['loan_id']!, _loanIdMeta),
      );
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
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
  AllocationTemplateRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AllocationTemplateRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      plannedAmountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}planned_amount_minor'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      goalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal_id'],
      ),
      investmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}investment_id'],
      ),
      billId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bill_id'],
      ),
      loanId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}loan_id'],
      ),
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $AllocationTemplatesTable createAlias(String alias) {
    return $AllocationTemplatesTable(attachedDatabase, alias);
  }
}

class AllocationTemplateRow extends DataClass
    implements Insertable<AllocationTemplateRow> {
  final String id;
  final String name;
  final String kind;
  final int plannedAmountMinor;
  final String? categoryId;
  final String? goalId;
  final String? investmentId;
  final String? billId;
  final String? loanId;
  final String? accountId;
  final int sortOrder;
  const AllocationTemplateRow({
    required this.id,
    required this.name,
    required this.kind,
    required this.plannedAmountMinor,
    this.categoryId,
    this.goalId,
    this.investmentId,
    this.billId,
    this.loanId,
    this.accountId,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['kind'] = Variable<String>(kind);
    map['planned_amount_minor'] = Variable<int>(plannedAmountMinor);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    if (!nullToAbsent || goalId != null) {
      map['goal_id'] = Variable<String>(goalId);
    }
    if (!nullToAbsent || investmentId != null) {
      map['investment_id'] = Variable<String>(investmentId);
    }
    if (!nullToAbsent || billId != null) {
      map['bill_id'] = Variable<String>(billId);
    }
    if (!nullToAbsent || loanId != null) {
      map['loan_id'] = Variable<String>(loanId);
    }
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<String>(accountId);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  AllocationTemplatesCompanion toCompanion(bool nullToAbsent) {
    return AllocationTemplatesCompanion(
      id: Value(id),
      name: Value(name),
      kind: Value(kind),
      plannedAmountMinor: Value(plannedAmountMinor),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      goalId: goalId == null && nullToAbsent
          ? const Value.absent()
          : Value(goalId),
      investmentId: investmentId == null && nullToAbsent
          ? const Value.absent()
          : Value(investmentId),
      billId: billId == null && nullToAbsent
          ? const Value.absent()
          : Value(billId),
      loanId: loanId == null && nullToAbsent
          ? const Value.absent()
          : Value(loanId),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
      sortOrder: Value(sortOrder),
    );
  }

  factory AllocationTemplateRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AllocationTemplateRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      kind: serializer.fromJson<String>(json['kind']),
      plannedAmountMinor: serializer.fromJson<int>(json['plannedAmountMinor']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      goalId: serializer.fromJson<String?>(json['goalId']),
      investmentId: serializer.fromJson<String?>(json['investmentId']),
      billId: serializer.fromJson<String?>(json['billId']),
      loanId: serializer.fromJson<String?>(json['loanId']),
      accountId: serializer.fromJson<String?>(json['accountId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'kind': serializer.toJson<String>(kind),
      'plannedAmountMinor': serializer.toJson<int>(plannedAmountMinor),
      'categoryId': serializer.toJson<String?>(categoryId),
      'goalId': serializer.toJson<String?>(goalId),
      'investmentId': serializer.toJson<String?>(investmentId),
      'billId': serializer.toJson<String?>(billId),
      'loanId': serializer.toJson<String?>(loanId),
      'accountId': serializer.toJson<String?>(accountId),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  AllocationTemplateRow copyWith({
    String? id,
    String? name,
    String? kind,
    int? plannedAmountMinor,
    Value<String?> categoryId = const Value.absent(),
    Value<String?> goalId = const Value.absent(),
    Value<String?> investmentId = const Value.absent(),
    Value<String?> billId = const Value.absent(),
    Value<String?> loanId = const Value.absent(),
    Value<String?> accountId = const Value.absent(),
    int? sortOrder,
  }) => AllocationTemplateRow(
    id: id ?? this.id,
    name: name ?? this.name,
    kind: kind ?? this.kind,
    plannedAmountMinor: plannedAmountMinor ?? this.plannedAmountMinor,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    goalId: goalId.present ? goalId.value : this.goalId,
    investmentId: investmentId.present ? investmentId.value : this.investmentId,
    billId: billId.present ? billId.value : this.billId,
    loanId: loanId.present ? loanId.value : this.loanId,
    accountId: accountId.present ? accountId.value : this.accountId,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  AllocationTemplateRow copyWithCompanion(AllocationTemplatesCompanion data) {
    return AllocationTemplateRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      kind: data.kind.present ? data.kind.value : this.kind,
      plannedAmountMinor: data.plannedAmountMinor.present
          ? data.plannedAmountMinor.value
          : this.plannedAmountMinor,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      investmentId: data.investmentId.present
          ? data.investmentId.value
          : this.investmentId,
      billId: data.billId.present ? data.billId.value : this.billId,
      loanId: data.loanId.present ? data.loanId.value : this.loanId,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AllocationTemplateRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('plannedAmountMinor: $plannedAmountMinor, ')
          ..write('categoryId: $categoryId, ')
          ..write('goalId: $goalId, ')
          ..write('investmentId: $investmentId, ')
          ..write('billId: $billId, ')
          ..write('loanId: $loanId, ')
          ..write('accountId: $accountId, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    kind,
    plannedAmountMinor,
    categoryId,
    goalId,
    investmentId,
    billId,
    loanId,
    accountId,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AllocationTemplateRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.kind == this.kind &&
          other.plannedAmountMinor == this.plannedAmountMinor &&
          other.categoryId == this.categoryId &&
          other.goalId == this.goalId &&
          other.investmentId == this.investmentId &&
          other.billId == this.billId &&
          other.loanId == this.loanId &&
          other.accountId == this.accountId &&
          other.sortOrder == this.sortOrder);
}

class AllocationTemplatesCompanion
    extends UpdateCompanion<AllocationTemplateRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> kind;
  final Value<int> plannedAmountMinor;
  final Value<String?> categoryId;
  final Value<String?> goalId;
  final Value<String?> investmentId;
  final Value<String?> billId;
  final Value<String?> loanId;
  final Value<String?> accountId;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const AllocationTemplatesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.kind = const Value.absent(),
    this.plannedAmountMinor = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.goalId = const Value.absent(),
    this.investmentId = const Value.absent(),
    this.billId = const Value.absent(),
    this.loanId = const Value.absent(),
    this.accountId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AllocationTemplatesCompanion.insert({
    required String id,
    required String name,
    required String kind,
    required int plannedAmountMinor,
    this.categoryId = const Value.absent(),
    this.goalId = const Value.absent(),
    this.investmentId = const Value.absent(),
    this.billId = const Value.absent(),
    this.loanId = const Value.absent(),
    this.accountId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       kind = Value(kind),
       plannedAmountMinor = Value(plannedAmountMinor);
  static Insertable<AllocationTemplateRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? kind,
    Expression<int>? plannedAmountMinor,
    Expression<String>? categoryId,
    Expression<String>? goalId,
    Expression<String>? investmentId,
    Expression<String>? billId,
    Expression<String>? loanId,
    Expression<String>? accountId,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (kind != null) 'kind': kind,
      if (plannedAmountMinor != null)
        'planned_amount_minor': plannedAmountMinor,
      if (categoryId != null) 'category_id': categoryId,
      if (goalId != null) 'goal_id': goalId,
      if (investmentId != null) 'investment_id': investmentId,
      if (billId != null) 'bill_id': billId,
      if (loanId != null) 'loan_id': loanId,
      if (accountId != null) 'account_id': accountId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AllocationTemplatesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? kind,
    Value<int>? plannedAmountMinor,
    Value<String?>? categoryId,
    Value<String?>? goalId,
    Value<String?>? investmentId,
    Value<String?>? billId,
    Value<String?>? loanId,
    Value<String?>? accountId,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return AllocationTemplatesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      plannedAmountMinor: plannedAmountMinor ?? this.plannedAmountMinor,
      categoryId: categoryId ?? this.categoryId,
      goalId: goalId ?? this.goalId,
      investmentId: investmentId ?? this.investmentId,
      billId: billId ?? this.billId,
      loanId: loanId ?? this.loanId,
      accountId: accountId ?? this.accountId,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (plannedAmountMinor.present) {
      map['planned_amount_minor'] = Variable<int>(plannedAmountMinor.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<String>(goalId.value);
    }
    if (investmentId.present) {
      map['investment_id'] = Variable<String>(investmentId.value);
    }
    if (billId.present) {
      map['bill_id'] = Variable<String>(billId.value);
    }
    if (loanId.present) {
      map['loan_id'] = Variable<String>(loanId.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AllocationTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('plannedAmountMinor: $plannedAmountMinor, ')
          ..write('categoryId: $categoryId, ')
          ..write('goalId: $goalId, ')
          ..write('investmentId: $investmentId, ')
          ..write('billId: $billId, ')
          ..write('loanId: $loanId, ')
          ..write('accountId: $accountId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SavingsGoalsTable extends SavingsGoals
    with TableInfo<$SavingsGoalsTable, SavingsGoalRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavingsGoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetAmountMinorMeta = const VerificationMeta(
    'targetAmountMinor',
  );
  @override
  late final GeneratedColumn<int> targetAmountMinor = GeneratedColumn<int>(
    'target_amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentAmountMinorMeta =
      const VerificationMeta('currentAmountMinor');
  @override
  late final GeneratedColumn<int> currentAmountMinor = GeneratedColumn<int>(
    'current_amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _targetDateMeta = const VerificationMeta(
    'targetDate',
  );
  @override
  late final GeneratedColumn<DateTime> targetDate = GeneratedColumn<DateTime>(
    'target_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _monthlyContributionMinorMeta =
      const VerificationMeta('monthlyContributionMinor');
  @override
  late final GeneratedColumn<int> monthlyContributionMinor =
      GeneratedColumn<int>(
        'monthly_contribution_minor',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _archivedMeta = const VerificationMeta(
    'archived',
  );
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
    'archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    targetAmountMinor,
    currentAmountMinor,
    targetDate,
    monthlyContributionMinor,
    priority,
    notes,
    archived,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'savings_goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<SavingsGoalRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('target_amount_minor')) {
      context.handle(
        _targetAmountMinorMeta,
        targetAmountMinor.isAcceptableOrUnknown(
          data['target_amount_minor']!,
          _targetAmountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetAmountMinorMeta);
    }
    if (data.containsKey('current_amount_minor')) {
      context.handle(
        _currentAmountMinorMeta,
        currentAmountMinor.isAcceptableOrUnknown(
          data['current_amount_minor']!,
          _currentAmountMinorMeta,
        ),
      );
    }
    if (data.containsKey('target_date')) {
      context.handle(
        _targetDateMeta,
        targetDate.isAcceptableOrUnknown(data['target_date']!, _targetDateMeta),
      );
    }
    if (data.containsKey('monthly_contribution_minor')) {
      context.handle(
        _monthlyContributionMinorMeta,
        monthlyContributionMinor.isAcceptableOrUnknown(
          data['monthly_contribution_minor']!,
          _monthlyContributionMinorMeta,
        ),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('archived')) {
      context.handle(
        _archivedMeta,
        archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavingsGoalRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavingsGoalRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      targetAmountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_amount_minor'],
      )!,
      currentAmountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_amount_minor'],
      )!,
      targetDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}target_date'],
      ),
      monthlyContributionMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}monthly_contribution_minor'],
      ),
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      archived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archived'],
      )!,
    );
  }

  @override
  $SavingsGoalsTable createAlias(String alias) {
    return $SavingsGoalsTable(attachedDatabase, alias);
  }
}

class SavingsGoalRow extends DataClass implements Insertable<SavingsGoalRow> {
  final String id;
  final String name;
  final int targetAmountMinor;
  final int currentAmountMinor;
  final DateTime? targetDate;
  final int? monthlyContributionMinor;
  final int priority;
  final String? notes;
  final bool archived;
  const SavingsGoalRow({
    required this.id,
    required this.name,
    required this.targetAmountMinor,
    required this.currentAmountMinor,
    this.targetDate,
    this.monthlyContributionMinor,
    required this.priority,
    this.notes,
    required this.archived,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['target_amount_minor'] = Variable<int>(targetAmountMinor);
    map['current_amount_minor'] = Variable<int>(currentAmountMinor);
    if (!nullToAbsent || targetDate != null) {
      map['target_date'] = Variable<DateTime>(targetDate);
    }
    if (!nullToAbsent || monthlyContributionMinor != null) {
      map['monthly_contribution_minor'] = Variable<int>(
        monthlyContributionMinor,
      );
    }
    map['priority'] = Variable<int>(priority);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['archived'] = Variable<bool>(archived);
    return map;
  }

  SavingsGoalsCompanion toCompanion(bool nullToAbsent) {
    return SavingsGoalsCompanion(
      id: Value(id),
      name: Value(name),
      targetAmountMinor: Value(targetAmountMinor),
      currentAmountMinor: Value(currentAmountMinor),
      targetDate: targetDate == null && nullToAbsent
          ? const Value.absent()
          : Value(targetDate),
      monthlyContributionMinor: monthlyContributionMinor == null && nullToAbsent
          ? const Value.absent()
          : Value(monthlyContributionMinor),
      priority: Value(priority),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      archived: Value(archived),
    );
  }

  factory SavingsGoalRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavingsGoalRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      targetAmountMinor: serializer.fromJson<int>(json['targetAmountMinor']),
      currentAmountMinor: serializer.fromJson<int>(json['currentAmountMinor']),
      targetDate: serializer.fromJson<DateTime?>(json['targetDate']),
      monthlyContributionMinor: serializer.fromJson<int?>(
        json['monthlyContributionMinor'],
      ),
      priority: serializer.fromJson<int>(json['priority']),
      notes: serializer.fromJson<String?>(json['notes']),
      archived: serializer.fromJson<bool>(json['archived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'targetAmountMinor': serializer.toJson<int>(targetAmountMinor),
      'currentAmountMinor': serializer.toJson<int>(currentAmountMinor),
      'targetDate': serializer.toJson<DateTime?>(targetDate),
      'monthlyContributionMinor': serializer.toJson<int?>(
        monthlyContributionMinor,
      ),
      'priority': serializer.toJson<int>(priority),
      'notes': serializer.toJson<String?>(notes),
      'archived': serializer.toJson<bool>(archived),
    };
  }

  SavingsGoalRow copyWith({
    String? id,
    String? name,
    int? targetAmountMinor,
    int? currentAmountMinor,
    Value<DateTime?> targetDate = const Value.absent(),
    Value<int?> monthlyContributionMinor = const Value.absent(),
    int? priority,
    Value<String?> notes = const Value.absent(),
    bool? archived,
  }) => SavingsGoalRow(
    id: id ?? this.id,
    name: name ?? this.name,
    targetAmountMinor: targetAmountMinor ?? this.targetAmountMinor,
    currentAmountMinor: currentAmountMinor ?? this.currentAmountMinor,
    targetDate: targetDate.present ? targetDate.value : this.targetDate,
    monthlyContributionMinor: monthlyContributionMinor.present
        ? monthlyContributionMinor.value
        : this.monthlyContributionMinor,
    priority: priority ?? this.priority,
    notes: notes.present ? notes.value : this.notes,
    archived: archived ?? this.archived,
  );
  SavingsGoalRow copyWithCompanion(SavingsGoalsCompanion data) {
    return SavingsGoalRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      targetAmountMinor: data.targetAmountMinor.present
          ? data.targetAmountMinor.value
          : this.targetAmountMinor,
      currentAmountMinor: data.currentAmountMinor.present
          ? data.currentAmountMinor.value
          : this.currentAmountMinor,
      targetDate: data.targetDate.present
          ? data.targetDate.value
          : this.targetDate,
      monthlyContributionMinor: data.monthlyContributionMinor.present
          ? data.monthlyContributionMinor.value
          : this.monthlyContributionMinor,
      priority: data.priority.present ? data.priority.value : this.priority,
      notes: data.notes.present ? data.notes.value : this.notes,
      archived: data.archived.present ? data.archived.value : this.archived,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavingsGoalRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('targetAmountMinor: $targetAmountMinor, ')
          ..write('currentAmountMinor: $currentAmountMinor, ')
          ..write('targetDate: $targetDate, ')
          ..write('monthlyContributionMinor: $monthlyContributionMinor, ')
          ..write('priority: $priority, ')
          ..write('notes: $notes, ')
          ..write('archived: $archived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    targetAmountMinor,
    currentAmountMinor,
    targetDate,
    monthlyContributionMinor,
    priority,
    notes,
    archived,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavingsGoalRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.targetAmountMinor == this.targetAmountMinor &&
          other.currentAmountMinor == this.currentAmountMinor &&
          other.targetDate == this.targetDate &&
          other.monthlyContributionMinor == this.monthlyContributionMinor &&
          other.priority == this.priority &&
          other.notes == this.notes &&
          other.archived == this.archived);
}

class SavingsGoalsCompanion extends UpdateCompanion<SavingsGoalRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> targetAmountMinor;
  final Value<int> currentAmountMinor;
  final Value<DateTime?> targetDate;
  final Value<int?> monthlyContributionMinor;
  final Value<int> priority;
  final Value<String?> notes;
  final Value<bool> archived;
  final Value<int> rowid;
  const SavingsGoalsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.targetAmountMinor = const Value.absent(),
    this.currentAmountMinor = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.monthlyContributionMinor = const Value.absent(),
    this.priority = const Value.absent(),
    this.notes = const Value.absent(),
    this.archived = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SavingsGoalsCompanion.insert({
    required String id,
    required String name,
    required int targetAmountMinor,
    this.currentAmountMinor = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.monthlyContributionMinor = const Value.absent(),
    this.priority = const Value.absent(),
    this.notes = const Value.absent(),
    this.archived = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       targetAmountMinor = Value(targetAmountMinor);
  static Insertable<SavingsGoalRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? targetAmountMinor,
    Expression<int>? currentAmountMinor,
    Expression<DateTime>? targetDate,
    Expression<int>? monthlyContributionMinor,
    Expression<int>? priority,
    Expression<String>? notes,
    Expression<bool>? archived,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (targetAmountMinor != null) 'target_amount_minor': targetAmountMinor,
      if (currentAmountMinor != null)
        'current_amount_minor': currentAmountMinor,
      if (targetDate != null) 'target_date': targetDate,
      if (monthlyContributionMinor != null)
        'monthly_contribution_minor': monthlyContributionMinor,
      if (priority != null) 'priority': priority,
      if (notes != null) 'notes': notes,
      if (archived != null) 'archived': archived,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SavingsGoalsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? targetAmountMinor,
    Value<int>? currentAmountMinor,
    Value<DateTime?>? targetDate,
    Value<int?>? monthlyContributionMinor,
    Value<int>? priority,
    Value<String?>? notes,
    Value<bool>? archived,
    Value<int>? rowid,
  }) {
    return SavingsGoalsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      targetAmountMinor: targetAmountMinor ?? this.targetAmountMinor,
      currentAmountMinor: currentAmountMinor ?? this.currentAmountMinor,
      targetDate: targetDate ?? this.targetDate,
      monthlyContributionMinor:
          monthlyContributionMinor ?? this.monthlyContributionMinor,
      priority: priority ?? this.priority,
      notes: notes ?? this.notes,
      archived: archived ?? this.archived,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (targetAmountMinor.present) {
      map['target_amount_minor'] = Variable<int>(targetAmountMinor.value);
    }
    if (currentAmountMinor.present) {
      map['current_amount_minor'] = Variable<int>(currentAmountMinor.value);
    }
    if (targetDate.present) {
      map['target_date'] = Variable<DateTime>(targetDate.value);
    }
    if (monthlyContributionMinor.present) {
      map['monthly_contribution_minor'] = Variable<int>(
        monthlyContributionMinor.value,
      );
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavingsGoalsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('targetAmountMinor: $targetAmountMinor, ')
          ..write('currentAmountMinor: $currentAmountMinor, ')
          ..write('targetDate: $targetDate, ')
          ..write('monthlyContributionMinor: $monthlyContributionMinor, ')
          ..write('priority: $priority, ')
          ..write('notes: $notes, ')
          ..write('archived: $archived, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InvestmentsTable extends Investments
    with TableInfo<$InvestmentsTable, InvestmentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvestmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMinorMeta = const VerificationMeta(
    'amountMinor',
  );
  @override
  late final GeneratedColumn<int> amountMinor = GeneratedColumn<int>(
    'amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentValueMinorMeta = const VerificationMeta(
    'currentValueMinor',
  );
  @override
  late final GeneratedColumn<int> currentValueMinor = GeneratedColumn<int>(
    'current_value_minor',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    type,
    amountMinor,
    date,
    accountId,
    currentValueMinor,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'investments';
  @override
  VerificationContext validateIntegrity(
    Insertable<InvestmentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('amount_minor')) {
      context.handle(
        _amountMinorMeta,
        amountMinor.isAcceptableOrUnknown(
          data['amount_minor']!,
          _amountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountMinorMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    }
    if (data.containsKey('current_value_minor')) {
      context.handle(
        _currentValueMinorMeta,
        currentValueMinor.isAcceptableOrUnknown(
          data['current_value_minor']!,
          _currentValueMinorMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvestmentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvestmentRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      amountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_minor'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      ),
      currentValueMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_value_minor'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $InvestmentsTable createAlias(String alias) {
    return $InvestmentsTable(attachedDatabase, alias);
  }
}

class InvestmentRow extends DataClass implements Insertable<InvestmentRow> {
  final String id;
  final String name;
  final String type;
  final int amountMinor;
  final DateTime date;
  final String? accountId;
  final int? currentValueMinor;
  final String? notes;
  const InvestmentRow({
    required this.id,
    required this.name,
    required this.type,
    required this.amountMinor,
    required this.date,
    this.accountId,
    this.currentValueMinor,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['amount_minor'] = Variable<int>(amountMinor);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<String>(accountId);
    }
    if (!nullToAbsent || currentValueMinor != null) {
      map['current_value_minor'] = Variable<int>(currentValueMinor);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  InvestmentsCompanion toCompanion(bool nullToAbsent) {
    return InvestmentsCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      amountMinor: Value(amountMinor),
      date: Value(date),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
      currentValueMinor: currentValueMinor == null && nullToAbsent
          ? const Value.absent()
          : Value(currentValueMinor),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory InvestmentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvestmentRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      amountMinor: serializer.fromJson<int>(json['amountMinor']),
      date: serializer.fromJson<DateTime>(json['date']),
      accountId: serializer.fromJson<String?>(json['accountId']),
      currentValueMinor: serializer.fromJson<int?>(json['currentValueMinor']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'amountMinor': serializer.toJson<int>(amountMinor),
      'date': serializer.toJson<DateTime>(date),
      'accountId': serializer.toJson<String?>(accountId),
      'currentValueMinor': serializer.toJson<int?>(currentValueMinor),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  InvestmentRow copyWith({
    String? id,
    String? name,
    String? type,
    int? amountMinor,
    DateTime? date,
    Value<String?> accountId = const Value.absent(),
    Value<int?> currentValueMinor = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => InvestmentRow(
    id: id ?? this.id,
    name: name ?? this.name,
    type: type ?? this.type,
    amountMinor: amountMinor ?? this.amountMinor,
    date: date ?? this.date,
    accountId: accountId.present ? accountId.value : this.accountId,
    currentValueMinor: currentValueMinor.present
        ? currentValueMinor.value
        : this.currentValueMinor,
    notes: notes.present ? notes.value : this.notes,
  );
  InvestmentRow copyWithCompanion(InvestmentsCompanion data) {
    return InvestmentRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      amountMinor: data.amountMinor.present
          ? data.amountMinor.value
          : this.amountMinor,
      date: data.date.present ? data.date.value : this.date,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      currentValueMinor: data.currentValueMinor.present
          ? data.currentValueMinor.value
          : this.currentValueMinor,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvestmentRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('date: $date, ')
          ..write('accountId: $accountId, ')
          ..write('currentValueMinor: $currentValueMinor, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    type,
    amountMinor,
    date,
    accountId,
    currentValueMinor,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvestmentRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.amountMinor == this.amountMinor &&
          other.date == this.date &&
          other.accountId == this.accountId &&
          other.currentValueMinor == this.currentValueMinor &&
          other.notes == this.notes);
}

class InvestmentsCompanion extends UpdateCompanion<InvestmentRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> type;
  final Value<int> amountMinor;
  final Value<DateTime> date;
  final Value<String?> accountId;
  final Value<int?> currentValueMinor;
  final Value<String?> notes;
  final Value<int> rowid;
  const InvestmentsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.amountMinor = const Value.absent(),
    this.date = const Value.absent(),
    this.accountId = const Value.absent(),
    this.currentValueMinor = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InvestmentsCompanion.insert({
    required String id,
    required String name,
    required String type,
    required int amountMinor,
    required DateTime date,
    this.accountId = const Value.absent(),
    this.currentValueMinor = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       type = Value(type),
       amountMinor = Value(amountMinor),
       date = Value(date);
  static Insertable<InvestmentRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<int>? amountMinor,
    Expression<DateTime>? date,
    Expression<String>? accountId,
    Expression<int>? currentValueMinor,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (amountMinor != null) 'amount_minor': amountMinor,
      if (date != null) 'date': date,
      if (accountId != null) 'account_id': accountId,
      if (currentValueMinor != null) 'current_value_minor': currentValueMinor,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InvestmentsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? type,
    Value<int>? amountMinor,
    Value<DateTime>? date,
    Value<String?>? accountId,
    Value<int?>? currentValueMinor,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return InvestmentsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      amountMinor: amountMinor ?? this.amountMinor,
      date: date ?? this.date,
      accountId: accountId ?? this.accountId,
      currentValueMinor: currentValueMinor ?? this.currentValueMinor,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (amountMinor.present) {
      map['amount_minor'] = Variable<int>(amountMinor.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (currentValueMinor.present) {
      map['current_value_minor'] = Variable<int>(currentValueMinor.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvestmentsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('date: $date, ')
          ..write('accountId: $accountId, ')
          ..write('currentValueMinor: $currentValueMinor, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BudgetsTable extends Budgets with TableInfo<$BudgetsTable, BudgetRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMinorMeta = const VerificationMeta(
    'amountMinor',
  );
  @override
  late final GeneratedColumn<int> amountMinor = GeneratedColumn<int>(
    'amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<int> month = GeneratedColumn<int>(
    'month',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _warn75Meta = const VerificationMeta('warn75');
  @override
  late final GeneratedColumn<bool> warn75 = GeneratedColumn<bool>(
    'warn75',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("warn75" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _warn90Meta = const VerificationMeta('warn90');
  @override
  late final GeneratedColumn<bool> warn90 = GeneratedColumn<bool>(
    'warn90',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("warn90" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _warn100Meta = const VerificationMeta(
    'warn100',
  );
  @override
  late final GeneratedColumn<bool> warn100 = GeneratedColumn<bool>(
    'warn100',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("warn100" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    categoryId,
    amountMinor,
    year,
    month,
    warn75,
    warn90,
    warn100,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budgets';
  @override
  VerificationContext validateIntegrity(
    Insertable<BudgetRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('amount_minor')) {
      context.handle(
        _amountMinorMeta,
        amountMinor.isAcceptableOrUnknown(
          data['amount_minor']!,
          _amountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountMinorMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('month')) {
      context.handle(
        _monthMeta,
        month.isAcceptableOrUnknown(data['month']!, _monthMeta),
      );
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('warn75')) {
      context.handle(
        _warn75Meta,
        warn75.isAcceptableOrUnknown(data['warn75']!, _warn75Meta),
      );
    }
    if (data.containsKey('warn90')) {
      context.handle(
        _warn90Meta,
        warn90.isAcceptableOrUnknown(data['warn90']!, _warn90Meta),
      );
    }
    if (data.containsKey('warn100')) {
      context.handle(
        _warn100Meta,
        warn100.isAcceptableOrUnknown(data['warn100']!, _warn100Meta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BudgetRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      amountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_minor'],
      )!,
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      )!,
      month: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}month'],
      )!,
      warn75: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}warn75'],
      )!,
      warn90: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}warn90'],
      )!,
      warn100: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}warn100'],
      )!,
    );
  }

  @override
  $BudgetsTable createAlias(String alias) {
    return $BudgetsTable(attachedDatabase, alias);
  }
}

class BudgetRow extends DataClass implements Insertable<BudgetRow> {
  final String id;
  final String categoryId;
  final int amountMinor;
  final int year;
  final int month;
  final bool warn75;
  final bool warn90;
  final bool warn100;
  const BudgetRow({
    required this.id,
    required this.categoryId,
    required this.amountMinor,
    required this.year,
    required this.month,
    required this.warn75,
    required this.warn90,
    required this.warn100,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['category_id'] = Variable<String>(categoryId);
    map['amount_minor'] = Variable<int>(amountMinor);
    map['year'] = Variable<int>(year);
    map['month'] = Variable<int>(month);
    map['warn75'] = Variable<bool>(warn75);
    map['warn90'] = Variable<bool>(warn90);
    map['warn100'] = Variable<bool>(warn100);
    return map;
  }

  BudgetsCompanion toCompanion(bool nullToAbsent) {
    return BudgetsCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      amountMinor: Value(amountMinor),
      year: Value(year),
      month: Value(month),
      warn75: Value(warn75),
      warn90: Value(warn90),
      warn100: Value(warn100),
    );
  }

  factory BudgetRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetRow(
      id: serializer.fromJson<String>(json['id']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      amountMinor: serializer.fromJson<int>(json['amountMinor']),
      year: serializer.fromJson<int>(json['year']),
      month: serializer.fromJson<int>(json['month']),
      warn75: serializer.fromJson<bool>(json['warn75']),
      warn90: serializer.fromJson<bool>(json['warn90']),
      warn100: serializer.fromJson<bool>(json['warn100']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'categoryId': serializer.toJson<String>(categoryId),
      'amountMinor': serializer.toJson<int>(amountMinor),
      'year': serializer.toJson<int>(year),
      'month': serializer.toJson<int>(month),
      'warn75': serializer.toJson<bool>(warn75),
      'warn90': serializer.toJson<bool>(warn90),
      'warn100': serializer.toJson<bool>(warn100),
    };
  }

  BudgetRow copyWith({
    String? id,
    String? categoryId,
    int? amountMinor,
    int? year,
    int? month,
    bool? warn75,
    bool? warn90,
    bool? warn100,
  }) => BudgetRow(
    id: id ?? this.id,
    categoryId: categoryId ?? this.categoryId,
    amountMinor: amountMinor ?? this.amountMinor,
    year: year ?? this.year,
    month: month ?? this.month,
    warn75: warn75 ?? this.warn75,
    warn90: warn90 ?? this.warn90,
    warn100: warn100 ?? this.warn100,
  );
  BudgetRow copyWithCompanion(BudgetsCompanion data) {
    return BudgetRow(
      id: data.id.present ? data.id.value : this.id,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      amountMinor: data.amountMinor.present
          ? data.amountMinor.value
          : this.amountMinor,
      year: data.year.present ? data.year.value : this.year,
      month: data.month.present ? data.month.value : this.month,
      warn75: data.warn75.present ? data.warn75.value : this.warn75,
      warn90: data.warn90.present ? data.warn90.value : this.warn90,
      warn100: data.warn100.present ? data.warn100.value : this.warn100,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BudgetRow(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('year: $year, ')
          ..write('month: $month, ')
          ..write('warn75: $warn75, ')
          ..write('warn90: $warn90, ')
          ..write('warn100: $warn100')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    categoryId,
    amountMinor,
    year,
    month,
    warn75,
    warn90,
    warn100,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetRow &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.amountMinor == this.amountMinor &&
          other.year == this.year &&
          other.month == this.month &&
          other.warn75 == this.warn75 &&
          other.warn90 == this.warn90 &&
          other.warn100 == this.warn100);
}

class BudgetsCompanion extends UpdateCompanion<BudgetRow> {
  final Value<String> id;
  final Value<String> categoryId;
  final Value<int> amountMinor;
  final Value<int> year;
  final Value<int> month;
  final Value<bool> warn75;
  final Value<bool> warn90;
  final Value<bool> warn100;
  final Value<int> rowid;
  const BudgetsCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.amountMinor = const Value.absent(),
    this.year = const Value.absent(),
    this.month = const Value.absent(),
    this.warn75 = const Value.absent(),
    this.warn90 = const Value.absent(),
    this.warn100 = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BudgetsCompanion.insert({
    required String id,
    required String categoryId,
    required int amountMinor,
    required int year,
    required int month,
    this.warn75 = const Value.absent(),
    this.warn90 = const Value.absent(),
    this.warn100 = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       categoryId = Value(categoryId),
       amountMinor = Value(amountMinor),
       year = Value(year),
       month = Value(month);
  static Insertable<BudgetRow> custom({
    Expression<String>? id,
    Expression<String>? categoryId,
    Expression<int>? amountMinor,
    Expression<int>? year,
    Expression<int>? month,
    Expression<bool>? warn75,
    Expression<bool>? warn90,
    Expression<bool>? warn100,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (amountMinor != null) 'amount_minor': amountMinor,
      if (year != null) 'year': year,
      if (month != null) 'month': month,
      if (warn75 != null) 'warn75': warn75,
      if (warn90 != null) 'warn90': warn90,
      if (warn100 != null) 'warn100': warn100,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BudgetsCompanion copyWith({
    Value<String>? id,
    Value<String>? categoryId,
    Value<int>? amountMinor,
    Value<int>? year,
    Value<int>? month,
    Value<bool>? warn75,
    Value<bool>? warn90,
    Value<bool>? warn100,
    Value<int>? rowid,
  }) {
    return BudgetsCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      amountMinor: amountMinor ?? this.amountMinor,
      year: year ?? this.year,
      month: month ?? this.month,
      warn75: warn75 ?? this.warn75,
      warn90: warn90 ?? this.warn90,
      warn100: warn100 ?? this.warn100,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (amountMinor.present) {
      map['amount_minor'] = Variable<int>(amountMinor.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (month.present) {
      map['month'] = Variable<int>(month.value);
    }
    if (warn75.present) {
      map['warn75'] = Variable<bool>(warn75.value);
    }
    if (warn90.present) {
      map['warn90'] = Variable<bool>(warn90.value);
    }
    if (warn100.present) {
      map['warn100'] = Variable<bool>(warn100.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetsCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('year: $year, ')
          ..write('month: $month, ')
          ..write('warn75: $warn75, ')
          ..write('warn90: $warn90, ')
          ..write('warn100: $warn100, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BillsTable extends Bills with TableInfo<$BillsTable, BillRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BillsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMinorMeta = const VerificationMeta(
    'amountMinor',
  );
  @override
  late final GeneratedColumn<int> amountMinor = GeneratedColumn<int>(
    'amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueDayMeta = const VerificationMeta('dueDay');
  @override
  late final GeneratedColumn<int> dueDay = GeneratedColumn<int>(
    'due_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _frequencyMeta = const VerificationMeta(
    'frequency',
  );
  @override
  late final GeneratedColumn<String> frequency = GeneratedColumn<String>(
    'frequency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('monthly'),
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reminderMeta = const VerificationMeta(
    'reminder',
  );
  @override
  late final GeneratedColumn<bool> reminder = GeneratedColumn<bool>(
    'reminder',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("reminder" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _autoPlanMeta = const VerificationMeta(
    'autoPlan',
  );
  @override
  late final GeneratedColumn<bool> autoPlan = GeneratedColumn<bool>(
    'auto_plan',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("auto_plan" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _archivedMeta = const VerificationMeta(
    'archived',
  );
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
    'archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    amountMinor,
    dueDay,
    frequency,
    accountId,
    categoryId,
    reminder,
    autoPlan,
    archived,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bills';
  @override
  VerificationContext validateIntegrity(
    Insertable<BillRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('amount_minor')) {
      context.handle(
        _amountMinorMeta,
        amountMinor.isAcceptableOrUnknown(
          data['amount_minor']!,
          _amountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountMinorMeta);
    }
    if (data.containsKey('due_day')) {
      context.handle(
        _dueDayMeta,
        dueDay.isAcceptableOrUnknown(data['due_day']!, _dueDayMeta),
      );
    } else if (isInserting) {
      context.missing(_dueDayMeta);
    }
    if (data.containsKey('frequency')) {
      context.handle(
        _frequencyMeta,
        frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta),
      );
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('reminder')) {
      context.handle(
        _reminderMeta,
        reminder.isAcceptableOrUnknown(data['reminder']!, _reminderMeta),
      );
    }
    if (data.containsKey('auto_plan')) {
      context.handle(
        _autoPlanMeta,
        autoPlan.isAcceptableOrUnknown(data['auto_plan']!, _autoPlanMeta),
      );
    }
    if (data.containsKey('archived')) {
      context.handle(
        _archivedMeta,
        archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BillRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BillRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      amountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_minor'],
      )!,
      dueDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}due_day'],
      )!,
      frequency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}frequency'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      ),
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      reminder: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reminder'],
      )!,
      autoPlan: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}auto_plan'],
      )!,
      archived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archived'],
      )!,
    );
  }

  @override
  $BillsTable createAlias(String alias) {
    return $BillsTable(attachedDatabase, alias);
  }
}

class BillRow extends DataClass implements Insertable<BillRow> {
  final String id;
  final String name;
  final int amountMinor;
  final int dueDay;
  final String frequency;
  final String? accountId;
  final String? categoryId;
  final bool reminder;
  final bool autoPlan;
  final bool archived;
  const BillRow({
    required this.id,
    required this.name,
    required this.amountMinor,
    required this.dueDay,
    required this.frequency,
    this.accountId,
    this.categoryId,
    required this.reminder,
    required this.autoPlan,
    required this.archived,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['amount_minor'] = Variable<int>(amountMinor);
    map['due_day'] = Variable<int>(dueDay);
    map['frequency'] = Variable<String>(frequency);
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<String>(accountId);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    map['reminder'] = Variable<bool>(reminder);
    map['auto_plan'] = Variable<bool>(autoPlan);
    map['archived'] = Variable<bool>(archived);
    return map;
  }

  BillsCompanion toCompanion(bool nullToAbsent) {
    return BillsCompanion(
      id: Value(id),
      name: Value(name),
      amountMinor: Value(amountMinor),
      dueDay: Value(dueDay),
      frequency: Value(frequency),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      reminder: Value(reminder),
      autoPlan: Value(autoPlan),
      archived: Value(archived),
    );
  }

  factory BillRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BillRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      amountMinor: serializer.fromJson<int>(json['amountMinor']),
      dueDay: serializer.fromJson<int>(json['dueDay']),
      frequency: serializer.fromJson<String>(json['frequency']),
      accountId: serializer.fromJson<String?>(json['accountId']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      reminder: serializer.fromJson<bool>(json['reminder']),
      autoPlan: serializer.fromJson<bool>(json['autoPlan']),
      archived: serializer.fromJson<bool>(json['archived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'amountMinor': serializer.toJson<int>(amountMinor),
      'dueDay': serializer.toJson<int>(dueDay),
      'frequency': serializer.toJson<String>(frequency),
      'accountId': serializer.toJson<String?>(accountId),
      'categoryId': serializer.toJson<String?>(categoryId),
      'reminder': serializer.toJson<bool>(reminder),
      'autoPlan': serializer.toJson<bool>(autoPlan),
      'archived': serializer.toJson<bool>(archived),
    };
  }

  BillRow copyWith({
    String? id,
    String? name,
    int? amountMinor,
    int? dueDay,
    String? frequency,
    Value<String?> accountId = const Value.absent(),
    Value<String?> categoryId = const Value.absent(),
    bool? reminder,
    bool? autoPlan,
    bool? archived,
  }) => BillRow(
    id: id ?? this.id,
    name: name ?? this.name,
    amountMinor: amountMinor ?? this.amountMinor,
    dueDay: dueDay ?? this.dueDay,
    frequency: frequency ?? this.frequency,
    accountId: accountId.present ? accountId.value : this.accountId,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    reminder: reminder ?? this.reminder,
    autoPlan: autoPlan ?? this.autoPlan,
    archived: archived ?? this.archived,
  );
  BillRow copyWithCompanion(BillsCompanion data) {
    return BillRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      amountMinor: data.amountMinor.present
          ? data.amountMinor.value
          : this.amountMinor,
      dueDay: data.dueDay.present ? data.dueDay.value : this.dueDay,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      reminder: data.reminder.present ? data.reminder.value : this.reminder,
      autoPlan: data.autoPlan.present ? data.autoPlan.value : this.autoPlan,
      archived: data.archived.present ? data.archived.value : this.archived,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BillRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('dueDay: $dueDay, ')
          ..write('frequency: $frequency, ')
          ..write('accountId: $accountId, ')
          ..write('categoryId: $categoryId, ')
          ..write('reminder: $reminder, ')
          ..write('autoPlan: $autoPlan, ')
          ..write('archived: $archived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    amountMinor,
    dueDay,
    frequency,
    accountId,
    categoryId,
    reminder,
    autoPlan,
    archived,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.amountMinor == this.amountMinor &&
          other.dueDay == this.dueDay &&
          other.frequency == this.frequency &&
          other.accountId == this.accountId &&
          other.categoryId == this.categoryId &&
          other.reminder == this.reminder &&
          other.autoPlan == this.autoPlan &&
          other.archived == this.archived);
}

class BillsCompanion extends UpdateCompanion<BillRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> amountMinor;
  final Value<int> dueDay;
  final Value<String> frequency;
  final Value<String?> accountId;
  final Value<String?> categoryId;
  final Value<bool> reminder;
  final Value<bool> autoPlan;
  final Value<bool> archived;
  final Value<int> rowid;
  const BillsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.amountMinor = const Value.absent(),
    this.dueDay = const Value.absent(),
    this.frequency = const Value.absent(),
    this.accountId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.reminder = const Value.absent(),
    this.autoPlan = const Value.absent(),
    this.archived = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BillsCompanion.insert({
    required String id,
    required String name,
    required int amountMinor,
    required int dueDay,
    this.frequency = const Value.absent(),
    this.accountId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.reminder = const Value.absent(),
    this.autoPlan = const Value.absent(),
    this.archived = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       amountMinor = Value(amountMinor),
       dueDay = Value(dueDay);
  static Insertable<BillRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? amountMinor,
    Expression<int>? dueDay,
    Expression<String>? frequency,
    Expression<String>? accountId,
    Expression<String>? categoryId,
    Expression<bool>? reminder,
    Expression<bool>? autoPlan,
    Expression<bool>? archived,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (amountMinor != null) 'amount_minor': amountMinor,
      if (dueDay != null) 'due_day': dueDay,
      if (frequency != null) 'frequency': frequency,
      if (accountId != null) 'account_id': accountId,
      if (categoryId != null) 'category_id': categoryId,
      if (reminder != null) 'reminder': reminder,
      if (autoPlan != null) 'auto_plan': autoPlan,
      if (archived != null) 'archived': archived,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BillsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? amountMinor,
    Value<int>? dueDay,
    Value<String>? frequency,
    Value<String?>? accountId,
    Value<String?>? categoryId,
    Value<bool>? reminder,
    Value<bool>? autoPlan,
    Value<bool>? archived,
    Value<int>? rowid,
  }) {
    return BillsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      amountMinor: amountMinor ?? this.amountMinor,
      dueDay: dueDay ?? this.dueDay,
      frequency: frequency ?? this.frequency,
      accountId: accountId ?? this.accountId,
      categoryId: categoryId ?? this.categoryId,
      reminder: reminder ?? this.reminder,
      autoPlan: autoPlan ?? this.autoPlan,
      archived: archived ?? this.archived,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (amountMinor.present) {
      map['amount_minor'] = Variable<int>(amountMinor.value);
    }
    if (dueDay.present) {
      map['due_day'] = Variable<int>(dueDay.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(frequency.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (reminder.present) {
      map['reminder'] = Variable<bool>(reminder.value);
    }
    if (autoPlan.present) {
      map['auto_plan'] = Variable<bool>(autoPlan.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('dueDay: $dueDay, ')
          ..write('frequency: $frequency, ')
          ..write('accountId: $accountId, ')
          ..write('categoryId: $categoryId, ')
          ..write('reminder: $reminder, ')
          ..write('autoPlan: $autoPlan, ')
          ..write('archived: $archived, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LoansTable extends Loans with TableInfo<$LoansTable, LoanRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LoansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _principalMinorMeta = const VerificationMeta(
    'principalMinor',
  );
  @override
  late final GeneratedColumn<int> principalMinor = GeneratedColumn<int>(
    'principal_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _interestRateMeta = const VerificationMeta(
    'interestRate',
  );
  @override
  late final GeneratedColumn<double> interestRate = GeneratedColumn<double>(
    'interest_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emiMinorMeta = const VerificationMeta(
    'emiMinor',
  );
  @override
  late final GeneratedColumn<int> emiMinor = GeneratedColumn<int>(
    'emi_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remainingMinorMeta = const VerificationMeta(
    'remainingMinor',
  );
  @override
  late final GeneratedColumn<int> remainingMinor = GeneratedColumn<int>(
    'remaining_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _archivedMeta = const VerificationMeta(
    'archived',
  );
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
    'archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    principalMinor,
    interestRate,
    emiMinor,
    startDate,
    endDate,
    remainingMinor,
    accountId,
    archived,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'loans';
  @override
  VerificationContext validateIntegrity(
    Insertable<LoanRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('principal_minor')) {
      context.handle(
        _principalMinorMeta,
        principalMinor.isAcceptableOrUnknown(
          data['principal_minor']!,
          _principalMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_principalMinorMeta);
    }
    if (data.containsKey('interest_rate')) {
      context.handle(
        _interestRateMeta,
        interestRate.isAcceptableOrUnknown(
          data['interest_rate']!,
          _interestRateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_interestRateMeta);
    }
    if (data.containsKey('emi_minor')) {
      context.handle(
        _emiMinorMeta,
        emiMinor.isAcceptableOrUnknown(data['emi_minor']!, _emiMinorMeta),
      );
    } else if (isInserting) {
      context.missing(_emiMinorMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    if (data.containsKey('remaining_minor')) {
      context.handle(
        _remainingMinorMeta,
        remainingMinor.isAcceptableOrUnknown(
          data['remaining_minor']!,
          _remainingMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_remainingMinorMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    }
    if (data.containsKey('archived')) {
      context.handle(
        _archivedMeta,
        archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LoanRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LoanRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      principalMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}principal_minor'],
      )!,
      interestRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}interest_rate'],
      )!,
      emiMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}emi_minor'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      )!,
      remainingMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remaining_minor'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      ),
      archived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archived'],
      )!,
    );
  }

  @override
  $LoansTable createAlias(String alias) {
    return $LoansTable(attachedDatabase, alias);
  }
}

class LoanRow extends DataClass implements Insertable<LoanRow> {
  final String id;
  final String name;
  final int principalMinor;
  final double interestRate;
  final int emiMinor;
  final DateTime startDate;
  final DateTime endDate;
  final int remainingMinor;
  final String? accountId;
  final bool archived;
  const LoanRow({
    required this.id,
    required this.name,
    required this.principalMinor,
    required this.interestRate,
    required this.emiMinor,
    required this.startDate,
    required this.endDate,
    required this.remainingMinor,
    this.accountId,
    required this.archived,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['principal_minor'] = Variable<int>(principalMinor);
    map['interest_rate'] = Variable<double>(interestRate);
    map['emi_minor'] = Variable<int>(emiMinor);
    map['start_date'] = Variable<DateTime>(startDate);
    map['end_date'] = Variable<DateTime>(endDate);
    map['remaining_minor'] = Variable<int>(remainingMinor);
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<String>(accountId);
    }
    map['archived'] = Variable<bool>(archived);
    return map;
  }

  LoansCompanion toCompanion(bool nullToAbsent) {
    return LoansCompanion(
      id: Value(id),
      name: Value(name),
      principalMinor: Value(principalMinor),
      interestRate: Value(interestRate),
      emiMinor: Value(emiMinor),
      startDate: Value(startDate),
      endDate: Value(endDate),
      remainingMinor: Value(remainingMinor),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
      archived: Value(archived),
    );
  }

  factory LoanRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LoanRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      principalMinor: serializer.fromJson<int>(json['principalMinor']),
      interestRate: serializer.fromJson<double>(json['interestRate']),
      emiMinor: serializer.fromJson<int>(json['emiMinor']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
      remainingMinor: serializer.fromJson<int>(json['remainingMinor']),
      accountId: serializer.fromJson<String?>(json['accountId']),
      archived: serializer.fromJson<bool>(json['archived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'principalMinor': serializer.toJson<int>(principalMinor),
      'interestRate': serializer.toJson<double>(interestRate),
      'emiMinor': serializer.toJson<int>(emiMinor),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
      'remainingMinor': serializer.toJson<int>(remainingMinor),
      'accountId': serializer.toJson<String?>(accountId),
      'archived': serializer.toJson<bool>(archived),
    };
  }

  LoanRow copyWith({
    String? id,
    String? name,
    int? principalMinor,
    double? interestRate,
    int? emiMinor,
    DateTime? startDate,
    DateTime? endDate,
    int? remainingMinor,
    Value<String?> accountId = const Value.absent(),
    bool? archived,
  }) => LoanRow(
    id: id ?? this.id,
    name: name ?? this.name,
    principalMinor: principalMinor ?? this.principalMinor,
    interestRate: interestRate ?? this.interestRate,
    emiMinor: emiMinor ?? this.emiMinor,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    remainingMinor: remainingMinor ?? this.remainingMinor,
    accountId: accountId.present ? accountId.value : this.accountId,
    archived: archived ?? this.archived,
  );
  LoanRow copyWithCompanion(LoansCompanion data) {
    return LoanRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      principalMinor: data.principalMinor.present
          ? data.principalMinor.value
          : this.principalMinor,
      interestRate: data.interestRate.present
          ? data.interestRate.value
          : this.interestRate,
      emiMinor: data.emiMinor.present ? data.emiMinor.value : this.emiMinor,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      remainingMinor: data.remainingMinor.present
          ? data.remainingMinor.value
          : this.remainingMinor,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      archived: data.archived.present ? data.archived.value : this.archived,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LoanRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('principalMinor: $principalMinor, ')
          ..write('interestRate: $interestRate, ')
          ..write('emiMinor: $emiMinor, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('remainingMinor: $remainingMinor, ')
          ..write('accountId: $accountId, ')
          ..write('archived: $archived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    principalMinor,
    interestRate,
    emiMinor,
    startDate,
    endDate,
    remainingMinor,
    accountId,
    archived,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoanRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.principalMinor == this.principalMinor &&
          other.interestRate == this.interestRate &&
          other.emiMinor == this.emiMinor &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.remainingMinor == this.remainingMinor &&
          other.accountId == this.accountId &&
          other.archived == this.archived);
}

class LoansCompanion extends UpdateCompanion<LoanRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> principalMinor;
  final Value<double> interestRate;
  final Value<int> emiMinor;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  final Value<int> remainingMinor;
  final Value<String?> accountId;
  final Value<bool> archived;
  final Value<int> rowid;
  const LoansCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.principalMinor = const Value.absent(),
    this.interestRate = const Value.absent(),
    this.emiMinor = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.remainingMinor = const Value.absent(),
    this.accountId = const Value.absent(),
    this.archived = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LoansCompanion.insert({
    required String id,
    required String name,
    required int principalMinor,
    required double interestRate,
    required int emiMinor,
    required DateTime startDate,
    required DateTime endDate,
    required int remainingMinor,
    this.accountId = const Value.absent(),
    this.archived = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       principalMinor = Value(principalMinor),
       interestRate = Value(interestRate),
       emiMinor = Value(emiMinor),
       startDate = Value(startDate),
       endDate = Value(endDate),
       remainingMinor = Value(remainingMinor);
  static Insertable<LoanRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? principalMinor,
    Expression<double>? interestRate,
    Expression<int>? emiMinor,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<int>? remainingMinor,
    Expression<String>? accountId,
    Expression<bool>? archived,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (principalMinor != null) 'principal_minor': principalMinor,
      if (interestRate != null) 'interest_rate': interestRate,
      if (emiMinor != null) 'emi_minor': emiMinor,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (remainingMinor != null) 'remaining_minor': remainingMinor,
      if (accountId != null) 'account_id': accountId,
      if (archived != null) 'archived': archived,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LoansCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? principalMinor,
    Value<double>? interestRate,
    Value<int>? emiMinor,
    Value<DateTime>? startDate,
    Value<DateTime>? endDate,
    Value<int>? remainingMinor,
    Value<String?>? accountId,
    Value<bool>? archived,
    Value<int>? rowid,
  }) {
    return LoansCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      principalMinor: principalMinor ?? this.principalMinor,
      interestRate: interestRate ?? this.interestRate,
      emiMinor: emiMinor ?? this.emiMinor,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      remainingMinor: remainingMinor ?? this.remainingMinor,
      accountId: accountId ?? this.accountId,
      archived: archived ?? this.archived,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (principalMinor.present) {
      map['principal_minor'] = Variable<int>(principalMinor.value);
    }
    if (interestRate.present) {
      map['interest_rate'] = Variable<double>(interestRate.value);
    }
    if (emiMinor.present) {
      map['emi_minor'] = Variable<int>(emiMinor.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (remainingMinor.present) {
      map['remaining_minor'] = Variable<int>(remainingMinor.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LoansCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('principalMinor: $principalMinor, ')
          ..write('interestRate: $interestRate, ')
          ..write('emiMinor: $emiMinor, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('remainingMinor: $remainingMinor, ')
          ..write('accountId: $accountId, ')
          ..write('archived: $archived, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FinancialGoalsTable extends FinancialGoals
    with TableInfo<$FinancialGoalsTable, FinancialGoalRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FinancialGoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetAmountMinorMeta = const VerificationMeta(
    'targetAmountMinor',
  );
  @override
  late final GeneratedColumn<int> targetAmountMinor = GeneratedColumn<int>(
    'target_amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentAmountMinorMeta =
      const VerificationMeta('currentAmountMinor');
  @override
  late final GeneratedColumn<int> currentAmountMinor = GeneratedColumn<int>(
    'current_amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _deadlineMeta = const VerificationMeta(
    'deadline',
  );
  @override
  late final GeneratedColumn<DateTime> deadline = GeneratedColumn<DateTime>(
    'deadline',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _requiredMonthlyMinorMeta =
      const VerificationMeta('requiredMonthlyMinor');
  @override
  late final GeneratedColumn<int> requiredMonthlyMinor = GeneratedColumn<int>(
    'required_monthly_minor',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('general'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    targetAmountMinor,
    currentAmountMinor,
    deadline,
    requiredMonthlyMinor,
    kind,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'financial_goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<FinancialGoalRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('target_amount_minor')) {
      context.handle(
        _targetAmountMinorMeta,
        targetAmountMinor.isAcceptableOrUnknown(
          data['target_amount_minor']!,
          _targetAmountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetAmountMinorMeta);
    }
    if (data.containsKey('current_amount_minor')) {
      context.handle(
        _currentAmountMinorMeta,
        currentAmountMinor.isAcceptableOrUnknown(
          data['current_amount_minor']!,
          _currentAmountMinorMeta,
        ),
      );
    }
    if (data.containsKey('deadline')) {
      context.handle(
        _deadlineMeta,
        deadline.isAcceptableOrUnknown(data['deadline']!, _deadlineMeta),
      );
    }
    if (data.containsKey('required_monthly_minor')) {
      context.handle(
        _requiredMonthlyMinorMeta,
        requiredMonthlyMinor.isAcceptableOrUnknown(
          data['required_monthly_minor']!,
          _requiredMonthlyMinorMeta,
        ),
      );
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FinancialGoalRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FinancialGoalRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      targetAmountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_amount_minor'],
      )!,
      currentAmountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_amount_minor'],
      )!,
      deadline: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deadline'],
      ),
      requiredMonthlyMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}required_monthly_minor'],
      ),
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $FinancialGoalsTable createAlias(String alias) {
    return $FinancialGoalsTable(attachedDatabase, alias);
  }
}

class FinancialGoalRow extends DataClass
    implements Insertable<FinancialGoalRow> {
  final String id;
  final String name;
  final int targetAmountMinor;
  final int currentAmountMinor;
  final DateTime? deadline;
  final int? requiredMonthlyMinor;
  final String kind;
  final String? notes;
  const FinancialGoalRow({
    required this.id,
    required this.name,
    required this.targetAmountMinor,
    required this.currentAmountMinor,
    this.deadline,
    this.requiredMonthlyMinor,
    required this.kind,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['target_amount_minor'] = Variable<int>(targetAmountMinor);
    map['current_amount_minor'] = Variable<int>(currentAmountMinor);
    if (!nullToAbsent || deadline != null) {
      map['deadline'] = Variable<DateTime>(deadline);
    }
    if (!nullToAbsent || requiredMonthlyMinor != null) {
      map['required_monthly_minor'] = Variable<int>(requiredMonthlyMinor);
    }
    map['kind'] = Variable<String>(kind);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  FinancialGoalsCompanion toCompanion(bool nullToAbsent) {
    return FinancialGoalsCompanion(
      id: Value(id),
      name: Value(name),
      targetAmountMinor: Value(targetAmountMinor),
      currentAmountMinor: Value(currentAmountMinor),
      deadline: deadline == null && nullToAbsent
          ? const Value.absent()
          : Value(deadline),
      requiredMonthlyMinor: requiredMonthlyMinor == null && nullToAbsent
          ? const Value.absent()
          : Value(requiredMonthlyMinor),
      kind: Value(kind),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory FinancialGoalRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FinancialGoalRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      targetAmountMinor: serializer.fromJson<int>(json['targetAmountMinor']),
      currentAmountMinor: serializer.fromJson<int>(json['currentAmountMinor']),
      deadline: serializer.fromJson<DateTime?>(json['deadline']),
      requiredMonthlyMinor: serializer.fromJson<int?>(
        json['requiredMonthlyMinor'],
      ),
      kind: serializer.fromJson<String>(json['kind']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'targetAmountMinor': serializer.toJson<int>(targetAmountMinor),
      'currentAmountMinor': serializer.toJson<int>(currentAmountMinor),
      'deadline': serializer.toJson<DateTime?>(deadline),
      'requiredMonthlyMinor': serializer.toJson<int?>(requiredMonthlyMinor),
      'kind': serializer.toJson<String>(kind),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  FinancialGoalRow copyWith({
    String? id,
    String? name,
    int? targetAmountMinor,
    int? currentAmountMinor,
    Value<DateTime?> deadline = const Value.absent(),
    Value<int?> requiredMonthlyMinor = const Value.absent(),
    String? kind,
    Value<String?> notes = const Value.absent(),
  }) => FinancialGoalRow(
    id: id ?? this.id,
    name: name ?? this.name,
    targetAmountMinor: targetAmountMinor ?? this.targetAmountMinor,
    currentAmountMinor: currentAmountMinor ?? this.currentAmountMinor,
    deadline: deadline.present ? deadline.value : this.deadline,
    requiredMonthlyMinor: requiredMonthlyMinor.present
        ? requiredMonthlyMinor.value
        : this.requiredMonthlyMinor,
    kind: kind ?? this.kind,
    notes: notes.present ? notes.value : this.notes,
  );
  FinancialGoalRow copyWithCompanion(FinancialGoalsCompanion data) {
    return FinancialGoalRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      targetAmountMinor: data.targetAmountMinor.present
          ? data.targetAmountMinor.value
          : this.targetAmountMinor,
      currentAmountMinor: data.currentAmountMinor.present
          ? data.currentAmountMinor.value
          : this.currentAmountMinor,
      deadline: data.deadline.present ? data.deadline.value : this.deadline,
      requiredMonthlyMinor: data.requiredMonthlyMinor.present
          ? data.requiredMonthlyMinor.value
          : this.requiredMonthlyMinor,
      kind: data.kind.present ? data.kind.value : this.kind,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FinancialGoalRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('targetAmountMinor: $targetAmountMinor, ')
          ..write('currentAmountMinor: $currentAmountMinor, ')
          ..write('deadline: $deadline, ')
          ..write('requiredMonthlyMinor: $requiredMonthlyMinor, ')
          ..write('kind: $kind, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    targetAmountMinor,
    currentAmountMinor,
    deadline,
    requiredMonthlyMinor,
    kind,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FinancialGoalRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.targetAmountMinor == this.targetAmountMinor &&
          other.currentAmountMinor == this.currentAmountMinor &&
          other.deadline == this.deadline &&
          other.requiredMonthlyMinor == this.requiredMonthlyMinor &&
          other.kind == this.kind &&
          other.notes == this.notes);
}

class FinancialGoalsCompanion extends UpdateCompanion<FinancialGoalRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> targetAmountMinor;
  final Value<int> currentAmountMinor;
  final Value<DateTime?> deadline;
  final Value<int?> requiredMonthlyMinor;
  final Value<String> kind;
  final Value<String?> notes;
  final Value<int> rowid;
  const FinancialGoalsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.targetAmountMinor = const Value.absent(),
    this.currentAmountMinor = const Value.absent(),
    this.deadline = const Value.absent(),
    this.requiredMonthlyMinor = const Value.absent(),
    this.kind = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FinancialGoalsCompanion.insert({
    required String id,
    required String name,
    required int targetAmountMinor,
    this.currentAmountMinor = const Value.absent(),
    this.deadline = const Value.absent(),
    this.requiredMonthlyMinor = const Value.absent(),
    this.kind = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       targetAmountMinor = Value(targetAmountMinor);
  static Insertable<FinancialGoalRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? targetAmountMinor,
    Expression<int>? currentAmountMinor,
    Expression<DateTime>? deadline,
    Expression<int>? requiredMonthlyMinor,
    Expression<String>? kind,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (targetAmountMinor != null) 'target_amount_minor': targetAmountMinor,
      if (currentAmountMinor != null)
        'current_amount_minor': currentAmountMinor,
      if (deadline != null) 'deadline': deadline,
      if (requiredMonthlyMinor != null)
        'required_monthly_minor': requiredMonthlyMinor,
      if (kind != null) 'kind': kind,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FinancialGoalsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? targetAmountMinor,
    Value<int>? currentAmountMinor,
    Value<DateTime?>? deadline,
    Value<int?>? requiredMonthlyMinor,
    Value<String>? kind,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return FinancialGoalsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      targetAmountMinor: targetAmountMinor ?? this.targetAmountMinor,
      currentAmountMinor: currentAmountMinor ?? this.currentAmountMinor,
      deadline: deadline ?? this.deadline,
      requiredMonthlyMinor: requiredMonthlyMinor ?? this.requiredMonthlyMinor,
      kind: kind ?? this.kind,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (targetAmountMinor.present) {
      map['target_amount_minor'] = Variable<int>(targetAmountMinor.value);
    }
    if (currentAmountMinor.present) {
      map['current_amount_minor'] = Variable<int>(currentAmountMinor.value);
    }
    if (deadline.present) {
      map['deadline'] = Variable<DateTime>(deadline.value);
    }
    if (requiredMonthlyMinor.present) {
      map['required_monthly_minor'] = Variable<int>(requiredMonthlyMinor.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FinancialGoalsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('targetAmountMinor: $targetAmountMinor, ')
          ..write('currentAmountMinor: $currentAmountMinor, ')
          ..write('deadline: $deadline, ')
          ..write('requiredMonthlyMinor: $requiredMonthlyMinor, ')
          ..write('kind: $kind, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotesTable extends Notes with TableInfo<$NotesTable, NoteRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transactionIdMeta = const VerificationMeta(
    'transactionId',
  );
  @override
  late final GeneratedColumn<String> transactionId = GeneratedColumn<String>(
    'transaction_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _allocationIdMeta = const VerificationMeta(
    'allocationId',
  );
  @override
  late final GeneratedColumn<String> allocationId = GeneratedColumn<String>(
    'allocation_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<String> goalId = GeneratedColumn<String>(
    'goal_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _monthKeyMeta = const VerificationMeta(
    'monthKey',
  );
  @override
  late final GeneratedColumn<String> monthKey = GeneratedColumn<String>(
    'month_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    body,
    createdAt,
    transactionId,
    allocationId,
    goalId,
    monthKey,
    accountId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<NoteRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
        _transactionIdMeta,
        transactionId.isAcceptableOrUnknown(
          data['transaction_id']!,
          _transactionIdMeta,
        ),
      );
    }
    if (data.containsKey('allocation_id')) {
      context.handle(
        _allocationIdMeta,
        allocationId.isAcceptableOrUnknown(
          data['allocation_id']!,
          _allocationIdMeta,
        ),
      );
    }
    if (data.containsKey('goal_id')) {
      context.handle(
        _goalIdMeta,
        goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta),
      );
    }
    if (data.containsKey('month_key')) {
      context.handle(
        _monthKeyMeta,
        monthKey.isAcceptableOrUnknown(data['month_key']!, _monthKeyMeta),
      );
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NoteRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NoteRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      transactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_id'],
      ),
      allocationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}allocation_id'],
      ),
      goalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal_id'],
      ),
      monthKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}month_key'],
      ),
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      ),
    );
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(attachedDatabase, alias);
  }
}

class NoteRow extends DataClass implements Insertable<NoteRow> {
  final String id;
  final String body;
  final DateTime createdAt;
  final String? transactionId;
  final String? allocationId;
  final String? goalId;
  final String? monthKey;
  final String? accountId;
  const NoteRow({
    required this.id,
    required this.body,
    required this.createdAt,
    this.transactionId,
    this.allocationId,
    this.goalId,
    this.monthKey,
    this.accountId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['body'] = Variable<String>(body);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || transactionId != null) {
      map['transaction_id'] = Variable<String>(transactionId);
    }
    if (!nullToAbsent || allocationId != null) {
      map['allocation_id'] = Variable<String>(allocationId);
    }
    if (!nullToAbsent || goalId != null) {
      map['goal_id'] = Variable<String>(goalId);
    }
    if (!nullToAbsent || monthKey != null) {
      map['month_key'] = Variable<String>(monthKey);
    }
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<String>(accountId);
    }
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: Value(id),
      body: Value(body),
      createdAt: Value(createdAt),
      transactionId: transactionId == null && nullToAbsent
          ? const Value.absent()
          : Value(transactionId),
      allocationId: allocationId == null && nullToAbsent
          ? const Value.absent()
          : Value(allocationId),
      goalId: goalId == null && nullToAbsent
          ? const Value.absent()
          : Value(goalId),
      monthKey: monthKey == null && nullToAbsent
          ? const Value.absent()
          : Value(monthKey),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
    );
  }

  factory NoteRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NoteRow(
      id: serializer.fromJson<String>(json['id']),
      body: serializer.fromJson<String>(json['body']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      transactionId: serializer.fromJson<String?>(json['transactionId']),
      allocationId: serializer.fromJson<String?>(json['allocationId']),
      goalId: serializer.fromJson<String?>(json['goalId']),
      monthKey: serializer.fromJson<String?>(json['monthKey']),
      accountId: serializer.fromJson<String?>(json['accountId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'body': serializer.toJson<String>(body),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'transactionId': serializer.toJson<String?>(transactionId),
      'allocationId': serializer.toJson<String?>(allocationId),
      'goalId': serializer.toJson<String?>(goalId),
      'monthKey': serializer.toJson<String?>(monthKey),
      'accountId': serializer.toJson<String?>(accountId),
    };
  }

  NoteRow copyWith({
    String? id,
    String? body,
    DateTime? createdAt,
    Value<String?> transactionId = const Value.absent(),
    Value<String?> allocationId = const Value.absent(),
    Value<String?> goalId = const Value.absent(),
    Value<String?> monthKey = const Value.absent(),
    Value<String?> accountId = const Value.absent(),
  }) => NoteRow(
    id: id ?? this.id,
    body: body ?? this.body,
    createdAt: createdAt ?? this.createdAt,
    transactionId: transactionId.present
        ? transactionId.value
        : this.transactionId,
    allocationId: allocationId.present ? allocationId.value : this.allocationId,
    goalId: goalId.present ? goalId.value : this.goalId,
    monthKey: monthKey.present ? monthKey.value : this.monthKey,
    accountId: accountId.present ? accountId.value : this.accountId,
  );
  NoteRow copyWithCompanion(NotesCompanion data) {
    return NoteRow(
      id: data.id.present ? data.id.value : this.id,
      body: data.body.present ? data.body.value : this.body,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      allocationId: data.allocationId.present
          ? data.allocationId.value
          : this.allocationId,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      monthKey: data.monthKey.present ? data.monthKey.value : this.monthKey,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NoteRow(')
          ..write('id: $id, ')
          ..write('body: $body, ')
          ..write('createdAt: $createdAt, ')
          ..write('transactionId: $transactionId, ')
          ..write('allocationId: $allocationId, ')
          ..write('goalId: $goalId, ')
          ..write('monthKey: $monthKey, ')
          ..write('accountId: $accountId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    body,
    createdAt,
    transactionId,
    allocationId,
    goalId,
    monthKey,
    accountId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NoteRow &&
          other.id == this.id &&
          other.body == this.body &&
          other.createdAt == this.createdAt &&
          other.transactionId == this.transactionId &&
          other.allocationId == this.allocationId &&
          other.goalId == this.goalId &&
          other.monthKey == this.monthKey &&
          other.accountId == this.accountId);
}

class NotesCompanion extends UpdateCompanion<NoteRow> {
  final Value<String> id;
  final Value<String> body;
  final Value<DateTime> createdAt;
  final Value<String?> transactionId;
  final Value<String?> allocationId;
  final Value<String?> goalId;
  final Value<String?> monthKey;
  final Value<String?> accountId;
  final Value<int> rowid;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.body = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.allocationId = const Value.absent(),
    this.goalId = const Value.absent(),
    this.monthKey = const Value.absent(),
    this.accountId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotesCompanion.insert({
    required String id,
    required String body,
    required DateTime createdAt,
    this.transactionId = const Value.absent(),
    this.allocationId = const Value.absent(),
    this.goalId = const Value.absent(),
    this.monthKey = const Value.absent(),
    this.accountId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       body = Value(body),
       createdAt = Value(createdAt);
  static Insertable<NoteRow> custom({
    Expression<String>? id,
    Expression<String>? body,
    Expression<DateTime>? createdAt,
    Expression<String>? transactionId,
    Expression<String>? allocationId,
    Expression<String>? goalId,
    Expression<String>? monthKey,
    Expression<String>? accountId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (body != null) 'body': body,
      if (createdAt != null) 'created_at': createdAt,
      if (transactionId != null) 'transaction_id': transactionId,
      if (allocationId != null) 'allocation_id': allocationId,
      if (goalId != null) 'goal_id': goalId,
      if (monthKey != null) 'month_key': monthKey,
      if (accountId != null) 'account_id': accountId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotesCompanion copyWith({
    Value<String>? id,
    Value<String>? body,
    Value<DateTime>? createdAt,
    Value<String?>? transactionId,
    Value<String?>? allocationId,
    Value<String?>? goalId,
    Value<String?>? monthKey,
    Value<String?>? accountId,
    Value<int>? rowid,
  }) {
    return NotesCompanion(
      id: id ?? this.id,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      transactionId: transactionId ?? this.transactionId,
      allocationId: allocationId ?? this.allocationId,
      goalId: goalId ?? this.goalId,
      monthKey: monthKey ?? this.monthKey,
      accountId: accountId ?? this.accountId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<String>(transactionId.value);
    }
    if (allocationId.present) {
      map['allocation_id'] = Variable<String>(allocationId.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<String>(goalId.value);
    }
    if (monthKey.present) {
      map['month_key'] = Variable<String>(monthKey.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('id: $id, ')
          ..write('body: $body, ')
          ..write('createdAt: $createdAt, ')
          ..write('transactionId: $transactionId, ')
          ..write('allocationId: $allocationId, ')
          ..write('goalId: $goalId, ')
          ..write('monthKey: $monthKey, ')
          ..write('accountId: $accountId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AuditLogsTable extends AuditLogs
    with TableInfo<$AuditLogsTable, AuditLogRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _atMeta = const VerificationMeta('at');
  @override
  late final GeneratedColumn<DateTime> at = GeneratedColumn<DateTime>(
    'at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, action, at, payload];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<AuditLogRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('at')) {
      context.handle(_atMeta, at.isAcceptableOrUnknown(data['at']!, _atMeta));
    } else if (isInserting) {
      context.missing(_atMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuditLogRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditLogRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      at: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}at'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      ),
    );
  }

  @override
  $AuditLogsTable createAlias(String alias) {
    return $AuditLogsTable(attachedDatabase, alias);
  }
}

class AuditLogRow extends DataClass implements Insertable<AuditLogRow> {
  final String id;
  final String action;
  final DateTime at;
  final String? payload;
  const AuditLogRow({
    required this.id,
    required this.action,
    required this.at,
    this.payload,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['action'] = Variable<String>(action);
    map['at'] = Variable<DateTime>(at);
    if (!nullToAbsent || payload != null) {
      map['payload'] = Variable<String>(payload);
    }
    return map;
  }

  AuditLogsCompanion toCompanion(bool nullToAbsent) {
    return AuditLogsCompanion(
      id: Value(id),
      action: Value(action),
      at: Value(at),
      payload: payload == null && nullToAbsent
          ? const Value.absent()
          : Value(payload),
    );
  }

  factory AuditLogRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditLogRow(
      id: serializer.fromJson<String>(json['id']),
      action: serializer.fromJson<String>(json['action']),
      at: serializer.fromJson<DateTime>(json['at']),
      payload: serializer.fromJson<String?>(json['payload']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'action': serializer.toJson<String>(action),
      'at': serializer.toJson<DateTime>(at),
      'payload': serializer.toJson<String?>(payload),
    };
  }

  AuditLogRow copyWith({
    String? id,
    String? action,
    DateTime? at,
    Value<String?> payload = const Value.absent(),
  }) => AuditLogRow(
    id: id ?? this.id,
    action: action ?? this.action,
    at: at ?? this.at,
    payload: payload.present ? payload.value : this.payload,
  );
  AuditLogRow copyWithCompanion(AuditLogsCompanion data) {
    return AuditLogRow(
      id: data.id.present ? data.id.value : this.id,
      action: data.action.present ? data.action.value : this.action,
      at: data.at.present ? data.at.value : this.at,
      payload: data.payload.present ? data.payload.value : this.payload,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogRow(')
          ..write('id: $id, ')
          ..write('action: $action, ')
          ..write('at: $at, ')
          ..write('payload: $payload')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, action, at, payload);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditLogRow &&
          other.id == this.id &&
          other.action == this.action &&
          other.at == this.at &&
          other.payload == this.payload);
}

class AuditLogsCompanion extends UpdateCompanion<AuditLogRow> {
  final Value<String> id;
  final Value<String> action;
  final Value<DateTime> at;
  final Value<String?> payload;
  final Value<int> rowid;
  const AuditLogsCompanion({
    this.id = const Value.absent(),
    this.action = const Value.absent(),
    this.at = const Value.absent(),
    this.payload = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AuditLogsCompanion.insert({
    required String id,
    required String action,
    required DateTime at,
    this.payload = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       action = Value(action),
       at = Value(at);
  static Insertable<AuditLogRow> custom({
    Expression<String>? id,
    Expression<String>? action,
    Expression<DateTime>? at,
    Expression<String>? payload,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (action != null) 'action': action,
      if (at != null) 'at': at,
      if (payload != null) 'payload': payload,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AuditLogsCompanion copyWith({
    Value<String>? id,
    Value<String>? action,
    Value<DateTime>? at,
    Value<String?>? payload,
    Value<int>? rowid,
  }) {
    return AuditLogsCompanion(
      id: id ?? this.id,
      action: action ?? this.action,
      at: at ?? this.at,
      payload: payload ?? this.payload,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (at.present) {
      map['at'] = Variable<DateTime>(at.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogsCompanion(')
          ..write('id: $id, ')
          ..write('action: $action, ')
          ..write('at: $at, ')
          ..write('payload: $payload, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FeatureSettingsTable extends FeatureSettings
    with TableInfo<$FeatureSettingsTable, FeatureSettingRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeatureSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _featureKeyMeta = const VerificationMeta(
    'featureKey',
  );
  @override
  late final GeneratedColumn<String> featureKey = GeneratedColumn<String>(
    'feature_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [featureKey, enabled];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feature_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<FeatureSettingRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('feature_key')) {
      context.handle(
        _featureKeyMeta,
        featureKey.isAcceptableOrUnknown(data['feature_key']!, _featureKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_featureKeyMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    } else if (isInserting) {
      context.missing(_enabledMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {featureKey};
  @override
  FeatureSettingRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeatureSettingRow(
      featureKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}feature_key'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
    );
  }

  @override
  $FeatureSettingsTable createAlias(String alias) {
    return $FeatureSettingsTable(attachedDatabase, alias);
  }
}

class FeatureSettingRow extends DataClass
    implements Insertable<FeatureSettingRow> {
  final String featureKey;
  final bool enabled;
  const FeatureSettingRow({required this.featureKey, required this.enabled});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['feature_key'] = Variable<String>(featureKey);
    map['enabled'] = Variable<bool>(enabled);
    return map;
  }

  FeatureSettingsCompanion toCompanion(bool nullToAbsent) {
    return FeatureSettingsCompanion(
      featureKey: Value(featureKey),
      enabled: Value(enabled),
    );
  }

  factory FeatureSettingRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeatureSettingRow(
      featureKey: serializer.fromJson<String>(json['featureKey']),
      enabled: serializer.fromJson<bool>(json['enabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'featureKey': serializer.toJson<String>(featureKey),
      'enabled': serializer.toJson<bool>(enabled),
    };
  }

  FeatureSettingRow copyWith({String? featureKey, bool? enabled}) =>
      FeatureSettingRow(
        featureKey: featureKey ?? this.featureKey,
        enabled: enabled ?? this.enabled,
      );
  FeatureSettingRow copyWithCompanion(FeatureSettingsCompanion data) {
    return FeatureSettingRow(
      featureKey: data.featureKey.present
          ? data.featureKey.value
          : this.featureKey,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeatureSettingRow(')
          ..write('featureKey: $featureKey, ')
          ..write('enabled: $enabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(featureKey, enabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeatureSettingRow &&
          other.featureKey == this.featureKey &&
          other.enabled == this.enabled);
}

class FeatureSettingsCompanion extends UpdateCompanion<FeatureSettingRow> {
  final Value<String> featureKey;
  final Value<bool> enabled;
  final Value<int> rowid;
  const FeatureSettingsCompanion({
    this.featureKey = const Value.absent(),
    this.enabled = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FeatureSettingsCompanion.insert({
    required String featureKey,
    required bool enabled,
    this.rowid = const Value.absent(),
  }) : featureKey = Value(featureKey),
       enabled = Value(enabled);
  static Insertable<FeatureSettingRow> custom({
    Expression<String>? featureKey,
    Expression<bool>? enabled,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (featureKey != null) 'feature_key': featureKey,
      if (enabled != null) 'enabled': enabled,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FeatureSettingsCompanion copyWith({
    Value<String>? featureKey,
    Value<bool>? enabled,
    Value<int>? rowid,
  }) {
    return FeatureSettingsCompanion(
      featureKey: featureKey ?? this.featureKey,
      enabled: enabled ?? this.enabled,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (featureKey.present) {
      map['feature_key'] = Variable<String>(featureKey.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeatureSettingsCompanion(')
          ..write('featureKey: $featureKey, ')
          ..write('enabled: $enabled, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSettingRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSettingRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSettingRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSettingRow(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSettingRow extends DataClass implements Insertable<AppSettingRow> {
  final String key;
  final String value;
  const AppSettingRow({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(key: Value(key), value: Value(value));
  }

  factory AppSettingRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSettingRow(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  AppSettingRow copyWith({String? key, String? value}) =>
      AppSettingRow(key: key ?? this.key, value: value ?? this.value);
  AppSettingRow copyWithCompanion(AppSettingsCompanion data) {
    return AppSettingRow(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingRow(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSettingRow &&
          other.key == this.key &&
          other.value == this.value);
}

class AppSettingsCompanion extends UpdateCompanion<AppSettingRow> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<AppSettingRow> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NetWorthSnapshotsTable extends NetWorthSnapshots
    with TableInfo<$NetWorthSnapshotsTable, NetWorthSnapshotRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NetWorthSnapshotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _atMeta = const VerificationMeta('at');
  @override
  late final GeneratedColumn<DateTime> at = GeneratedColumn<DateTime>(
    'at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _assetsMinorMeta = const VerificationMeta(
    'assetsMinor',
  );
  @override
  late final GeneratedColumn<int> assetsMinor = GeneratedColumn<int>(
    'assets_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _liabilitiesMinorMeta = const VerificationMeta(
    'liabilitiesMinor',
  );
  @override
  late final GeneratedColumn<int> liabilitiesMinor = GeneratedColumn<int>(
    'liabilities_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _netMinorMeta = const VerificationMeta(
    'netMinor',
  );
  @override
  late final GeneratedColumn<int> netMinor = GeneratedColumn<int>(
    'net_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    at,
    assetsMinor,
    liabilitiesMinor,
    netMinor,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'net_worth_snapshots';
  @override
  VerificationContext validateIntegrity(
    Insertable<NetWorthSnapshotRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('at')) {
      context.handle(_atMeta, at.isAcceptableOrUnknown(data['at']!, _atMeta));
    } else if (isInserting) {
      context.missing(_atMeta);
    }
    if (data.containsKey('assets_minor')) {
      context.handle(
        _assetsMinorMeta,
        assetsMinor.isAcceptableOrUnknown(
          data['assets_minor']!,
          _assetsMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_assetsMinorMeta);
    }
    if (data.containsKey('liabilities_minor')) {
      context.handle(
        _liabilitiesMinorMeta,
        liabilitiesMinor.isAcceptableOrUnknown(
          data['liabilities_minor']!,
          _liabilitiesMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_liabilitiesMinorMeta);
    }
    if (data.containsKey('net_minor')) {
      context.handle(
        _netMinorMeta,
        netMinor.isAcceptableOrUnknown(data['net_minor']!, _netMinorMeta),
      );
    } else if (isInserting) {
      context.missing(_netMinorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NetWorthSnapshotRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NetWorthSnapshotRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      at: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}at'],
      )!,
      assetsMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}assets_minor'],
      )!,
      liabilitiesMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}liabilities_minor'],
      )!,
      netMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}net_minor'],
      )!,
    );
  }

  @override
  $NetWorthSnapshotsTable createAlias(String alias) {
    return $NetWorthSnapshotsTable(attachedDatabase, alias);
  }
}

class NetWorthSnapshotRow extends DataClass
    implements Insertable<NetWorthSnapshotRow> {
  final String id;
  final DateTime at;
  final int assetsMinor;
  final int liabilitiesMinor;
  final int netMinor;
  const NetWorthSnapshotRow({
    required this.id,
    required this.at,
    required this.assetsMinor,
    required this.liabilitiesMinor,
    required this.netMinor,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['at'] = Variable<DateTime>(at);
    map['assets_minor'] = Variable<int>(assetsMinor);
    map['liabilities_minor'] = Variable<int>(liabilitiesMinor);
    map['net_minor'] = Variable<int>(netMinor);
    return map;
  }

  NetWorthSnapshotsCompanion toCompanion(bool nullToAbsent) {
    return NetWorthSnapshotsCompanion(
      id: Value(id),
      at: Value(at),
      assetsMinor: Value(assetsMinor),
      liabilitiesMinor: Value(liabilitiesMinor),
      netMinor: Value(netMinor),
    );
  }

  factory NetWorthSnapshotRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NetWorthSnapshotRow(
      id: serializer.fromJson<String>(json['id']),
      at: serializer.fromJson<DateTime>(json['at']),
      assetsMinor: serializer.fromJson<int>(json['assetsMinor']),
      liabilitiesMinor: serializer.fromJson<int>(json['liabilitiesMinor']),
      netMinor: serializer.fromJson<int>(json['netMinor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'at': serializer.toJson<DateTime>(at),
      'assetsMinor': serializer.toJson<int>(assetsMinor),
      'liabilitiesMinor': serializer.toJson<int>(liabilitiesMinor),
      'netMinor': serializer.toJson<int>(netMinor),
    };
  }

  NetWorthSnapshotRow copyWith({
    String? id,
    DateTime? at,
    int? assetsMinor,
    int? liabilitiesMinor,
    int? netMinor,
  }) => NetWorthSnapshotRow(
    id: id ?? this.id,
    at: at ?? this.at,
    assetsMinor: assetsMinor ?? this.assetsMinor,
    liabilitiesMinor: liabilitiesMinor ?? this.liabilitiesMinor,
    netMinor: netMinor ?? this.netMinor,
  );
  NetWorthSnapshotRow copyWithCompanion(NetWorthSnapshotsCompanion data) {
    return NetWorthSnapshotRow(
      id: data.id.present ? data.id.value : this.id,
      at: data.at.present ? data.at.value : this.at,
      assetsMinor: data.assetsMinor.present
          ? data.assetsMinor.value
          : this.assetsMinor,
      liabilitiesMinor: data.liabilitiesMinor.present
          ? data.liabilitiesMinor.value
          : this.liabilitiesMinor,
      netMinor: data.netMinor.present ? data.netMinor.value : this.netMinor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NetWorthSnapshotRow(')
          ..write('id: $id, ')
          ..write('at: $at, ')
          ..write('assetsMinor: $assetsMinor, ')
          ..write('liabilitiesMinor: $liabilitiesMinor, ')
          ..write('netMinor: $netMinor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, at, assetsMinor, liabilitiesMinor, netMinor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NetWorthSnapshotRow &&
          other.id == this.id &&
          other.at == this.at &&
          other.assetsMinor == this.assetsMinor &&
          other.liabilitiesMinor == this.liabilitiesMinor &&
          other.netMinor == this.netMinor);
}

class NetWorthSnapshotsCompanion extends UpdateCompanion<NetWorthSnapshotRow> {
  final Value<String> id;
  final Value<DateTime> at;
  final Value<int> assetsMinor;
  final Value<int> liabilitiesMinor;
  final Value<int> netMinor;
  final Value<int> rowid;
  const NetWorthSnapshotsCompanion({
    this.id = const Value.absent(),
    this.at = const Value.absent(),
    this.assetsMinor = const Value.absent(),
    this.liabilitiesMinor = const Value.absent(),
    this.netMinor = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NetWorthSnapshotsCompanion.insert({
    required String id,
    required DateTime at,
    required int assetsMinor,
    required int liabilitiesMinor,
    required int netMinor,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       at = Value(at),
       assetsMinor = Value(assetsMinor),
       liabilitiesMinor = Value(liabilitiesMinor),
       netMinor = Value(netMinor);
  static Insertable<NetWorthSnapshotRow> custom({
    Expression<String>? id,
    Expression<DateTime>? at,
    Expression<int>? assetsMinor,
    Expression<int>? liabilitiesMinor,
    Expression<int>? netMinor,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (at != null) 'at': at,
      if (assetsMinor != null) 'assets_minor': assetsMinor,
      if (liabilitiesMinor != null) 'liabilities_minor': liabilitiesMinor,
      if (netMinor != null) 'net_minor': netMinor,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NetWorthSnapshotsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? at,
    Value<int>? assetsMinor,
    Value<int>? liabilitiesMinor,
    Value<int>? netMinor,
    Value<int>? rowid,
  }) {
    return NetWorthSnapshotsCompanion(
      id: id ?? this.id,
      at: at ?? this.at,
      assetsMinor: assetsMinor ?? this.assetsMinor,
      liabilitiesMinor: liabilitiesMinor ?? this.liabilitiesMinor,
      netMinor: netMinor ?? this.netMinor,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (at.present) {
      map['at'] = Variable<DateTime>(at.value);
    }
    if (assetsMinor.present) {
      map['assets_minor'] = Variable<int>(assetsMinor.value);
    }
    if (liabilitiesMinor.present) {
      map['liabilities_minor'] = Variable<int>(liabilitiesMinor.value);
    }
    if (netMinor.present) {
      map['net_minor'] = Variable<int>(netMinor.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NetWorthSnapshotsCompanion(')
          ..write('id: $id, ')
          ..write('at: $at, ')
          ..write('assetsMinor: $assetsMinor, ')
          ..write('liabilitiesMinor: $liabilitiesMinor, ')
          ..write('netMinor: $netMinor, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AccountsTable accounts = $AccountsTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $IncomeSourcesTable incomeSources = $IncomeSourcesTable(this);
  late final $SalaryProfilesTable salaryProfiles = $SalaryProfilesTable(this);
  late final $SalaryHistoryTable salaryHistory = $SalaryHistoryTable(this);
  late final $MonthlyPlansTable monthlyPlans = $MonthlyPlansTable(this);
  late final $AllocationItemsTable allocationItems = $AllocationItemsTable(
    this,
  );
  late final $AllocationTemplatesTable allocationTemplates =
      $AllocationTemplatesTable(this);
  late final $SavingsGoalsTable savingsGoals = $SavingsGoalsTable(this);
  late final $InvestmentsTable investments = $InvestmentsTable(this);
  late final $BudgetsTable budgets = $BudgetsTable(this);
  late final $BillsTable bills = $BillsTable(this);
  late final $LoansTable loans = $LoansTable(this);
  late final $FinancialGoalsTable financialGoals = $FinancialGoalsTable(this);
  late final $NotesTable notes = $NotesTable(this);
  late final $AuditLogsTable auditLogs = $AuditLogsTable(this);
  late final $FeatureSettingsTable featureSettings = $FeatureSettingsTable(
    this,
  );
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $NetWorthSnapshotsTable netWorthSnapshots =
      $NetWorthSnapshotsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    accounts,
    categories,
    transactions,
    incomeSources,
    salaryProfiles,
    salaryHistory,
    monthlyPlans,
    allocationItems,
    allocationTemplates,
    savingsGoals,
    investments,
    budgets,
    bills,
    loans,
    financialGoals,
    notes,
    auditLogs,
    featureSettings,
    appSettings,
    netWorthSnapshots,
  ];
}

typedef $$AccountsTableCreateCompanionBuilder =
    AccountsCompanion Function({
      required String id,
      required String name,
      required String type,
      required int openingBalanceMinor,
      Value<String> currency,
      Value<String?> notes,
      Value<bool> archived,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$AccountsTableUpdateCompanionBuilder =
    AccountsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> type,
      Value<int> openingBalanceMinor,
      Value<String> currency,
      Value<String?> notes,
      Value<bool> archived,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$AccountsTableFilterComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get openingBalanceMinor => $composableBuilder(
    column: $table.openingBalanceMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get openingBalanceMinor => $composableBuilder(
    column: $table.openingBalanceMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get openingBalanceMinor => $composableBuilder(
    column: $table.openingBalanceMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AccountsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AccountsTable,
          AccountRow,
          $$AccountsTableFilterComposer,
          $$AccountsTableOrderingComposer,
          $$AccountsTableAnnotationComposer,
          $$AccountsTableCreateCompanionBuilder,
          $$AccountsTableUpdateCompanionBuilder,
          (
            AccountRow,
            BaseReferences<_$AppDatabase, $AccountsTable, AccountRow>,
          ),
          AccountRow,
          PrefetchHooks Function()
        > {
  $$AccountsTableTableManager(_$AppDatabase db, $AccountsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> openingBalanceMinor = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AccountsCompanion(
                id: id,
                name: name,
                type: type,
                openingBalanceMinor: openingBalanceMinor,
                currency: currency,
                notes: notes,
                archived: archived,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String type,
                required int openingBalanceMinor,
                Value<String> currency = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => AccountsCompanion.insert(
                id: id,
                name: name,
                type: type,
                openingBalanceMinor: openingBalanceMinor,
                currency: currency,
                notes: notes,
                archived: archived,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AccountsTable,
      AccountRow,
      $$AccountsTableFilterComposer,
      $$AccountsTableOrderingComposer,
      $$AccountsTableAnnotationComposer,
      $$AccountsTableCreateCompanionBuilder,
      $$AccountsTableUpdateCompanionBuilder,
      (AccountRow, BaseReferences<_$AppDatabase, $AccountsTable, AccountRow>),
      AccountRow,
      PrefetchHooks Function()
    >;
typedef $$CategoriesTableCreateCompanionBuilder =
    CategoriesCompanion Function({
      required String id,
      required String name,
      required String kind,
      Value<String?> parentId,
      Value<String> icon,
      Value<int> sortOrder,
      Value<bool> archived,
      Value<int> rowid,
    });
typedef $$CategoriesTableUpdateCompanionBuilder =
    CategoriesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> kind,
      Value<String?> parentId,
      Value<String> icon,
      Value<int> sortOrder,
      Value<bool> archived,
      Value<int> rowid,
    });

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parentId => $composableBuilder(
    column: $table.parentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parentId => $composableBuilder(
    column: $table.parentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get parentId =>
      $composableBuilder(column: $table.parentId, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          CategoryRow,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (
            CategoryRow,
            BaseReferences<_$AppDatabase, $CategoriesTable, CategoryRow>,
          ),
          CategoryRow,
          PrefetchHooks Function()
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String?> parentId = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                name: name,
                kind: kind,
                parentId: parentId,
                icon: icon,
                sortOrder: sortOrder,
                archived: archived,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String kind,
                Value<String?> parentId = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion.insert(
                id: id,
                name: name,
                kind: kind,
                parentId: parentId,
                icon: icon,
                sortOrder: sortOrder,
                archived: archived,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      CategoryRow,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (
        CategoryRow,
        BaseReferences<_$AppDatabase, $CategoriesTable, CategoryRow>,
      ),
      CategoryRow,
      PrefetchHooks Function()
    >;
typedef $$TransactionsTableCreateCompanionBuilder =
    TransactionsCompanion Function({
      required String id,
      required String type,
      required int amountMinor,
      required DateTime date,
      required String accountId,
      Value<String?> toAccountId,
      Value<String?> categoryId,
      Value<String?> subcategoryId,
      Value<String?> paymentMethod,
      Value<String?> incomeSourceId,
      Value<String?> note,
      Value<String> tagsJson,
      Value<String?> attachmentPath,
      Value<String?> allocationItemId,
      Value<String?> goalId,
      Value<String?> investmentId,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$TransactionsTableUpdateCompanionBuilder =
    TransactionsCompanion Function({
      Value<String> id,
      Value<String> type,
      Value<int> amountMinor,
      Value<DateTime> date,
      Value<String> accountId,
      Value<String?> toAccountId,
      Value<String?> categoryId,
      Value<String?> subcategoryId,
      Value<String?> paymentMethod,
      Value<String?> incomeSourceId,
      Value<String?> note,
      Value<String> tagsJson,
      Value<String?> attachmentPath,
      Value<String?> allocationItemId,
      Value<String?> goalId,
      Value<String?> investmentId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$TransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toAccountId => $composableBuilder(
    column: $table.toAccountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subcategoryId => $composableBuilder(
    column: $table.subcategoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get incomeSourceId => $composableBuilder(
    column: $table.incomeSourceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tagsJson => $composableBuilder(
    column: $table.tagsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get attachmentPath => $composableBuilder(
    column: $table.attachmentPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get allocationItemId => $composableBuilder(
    column: $table.allocationItemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goalId => $composableBuilder(
    column: $table.goalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get investmentId => $composableBuilder(
    column: $table.investmentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toAccountId => $composableBuilder(
    column: $table.toAccountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subcategoryId => $composableBuilder(
    column: $table.subcategoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get incomeSourceId => $composableBuilder(
    column: $table.incomeSourceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tagsJson => $composableBuilder(
    column: $table.tagsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attachmentPath => $composableBuilder(
    column: $table.attachmentPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get allocationItemId => $composableBuilder(
    column: $table.allocationItemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goalId => $composableBuilder(
    column: $table.goalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get investmentId => $composableBuilder(
    column: $table.investmentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<String> get toAccountId => $composableBuilder(
    column: $table.toAccountId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get subcategoryId => $composableBuilder(
    column: $table.subcategoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get incomeSourceId => $composableBuilder(
    column: $table.incomeSourceId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get tagsJson =>
      $composableBuilder(column: $table.tagsJson, builder: (column) => column);

  GeneratedColumn<String> get attachmentPath => $composableBuilder(
    column: $table.attachmentPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get allocationItemId => $composableBuilder(
    column: $table.allocationItemId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get goalId =>
      $composableBuilder(column: $table.goalId, builder: (column) => column);

  GeneratedColumn<String> get investmentId => $composableBuilder(
    column: $table.investmentId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$TransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionsTable,
          TransactionRow,
          $$TransactionsTableFilterComposer,
          $$TransactionsTableOrderingComposer,
          $$TransactionsTableAnnotationComposer,
          $$TransactionsTableCreateCompanionBuilder,
          $$TransactionsTableUpdateCompanionBuilder,
          (
            TransactionRow,
            BaseReferences<_$AppDatabase, $TransactionsTable, TransactionRow>,
          ),
          TransactionRow,
          PrefetchHooks Function()
        > {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> amountMinor = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<String?> toAccountId = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> subcategoryId = const Value.absent(),
                Value<String?> paymentMethod = const Value.absent(),
                Value<String?> incomeSourceId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> tagsJson = const Value.absent(),
                Value<String?> attachmentPath = const Value.absent(),
                Value<String?> allocationItemId = const Value.absent(),
                Value<String?> goalId = const Value.absent(),
                Value<String?> investmentId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionsCompanion(
                id: id,
                type: type,
                amountMinor: amountMinor,
                date: date,
                accountId: accountId,
                toAccountId: toAccountId,
                categoryId: categoryId,
                subcategoryId: subcategoryId,
                paymentMethod: paymentMethod,
                incomeSourceId: incomeSourceId,
                note: note,
                tagsJson: tagsJson,
                attachmentPath: attachmentPath,
                allocationItemId: allocationItemId,
                goalId: goalId,
                investmentId: investmentId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String type,
                required int amountMinor,
                required DateTime date,
                required String accountId,
                Value<String?> toAccountId = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> subcategoryId = const Value.absent(),
                Value<String?> paymentMethod = const Value.absent(),
                Value<String?> incomeSourceId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> tagsJson = const Value.absent(),
                Value<String?> attachmentPath = const Value.absent(),
                Value<String?> allocationItemId = const Value.absent(),
                Value<String?> goalId = const Value.absent(),
                Value<String?> investmentId = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => TransactionsCompanion.insert(
                id: id,
                type: type,
                amountMinor: amountMinor,
                date: date,
                accountId: accountId,
                toAccountId: toAccountId,
                categoryId: categoryId,
                subcategoryId: subcategoryId,
                paymentMethod: paymentMethod,
                incomeSourceId: incomeSourceId,
                note: note,
                tagsJson: tagsJson,
                attachmentPath: attachmentPath,
                allocationItemId: allocationItemId,
                goalId: goalId,
                investmentId: investmentId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionsTable,
      TransactionRow,
      $$TransactionsTableFilterComposer,
      $$TransactionsTableOrderingComposer,
      $$TransactionsTableAnnotationComposer,
      $$TransactionsTableCreateCompanionBuilder,
      $$TransactionsTableUpdateCompanionBuilder,
      (
        TransactionRow,
        BaseReferences<_$AppDatabase, $TransactionsTable, TransactionRow>,
      ),
      TransactionRow,
      PrefetchHooks Function()
    >;
typedef $$IncomeSourcesTableCreateCompanionBuilder =
    IncomeSourcesCompanion Function({
      required String id,
      required String name,
      Value<bool> archived,
      Value<int> rowid,
    });
typedef $$IncomeSourcesTableUpdateCompanionBuilder =
    IncomeSourcesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<bool> archived,
      Value<int> rowid,
    });

class $$IncomeSourcesTableFilterComposer
    extends Composer<_$AppDatabase, $IncomeSourcesTable> {
  $$IncomeSourcesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnFilters(column),
  );
}

class $$IncomeSourcesTableOrderingComposer
    extends Composer<_$AppDatabase, $IncomeSourcesTable> {
  $$IncomeSourcesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$IncomeSourcesTableAnnotationComposer
    extends Composer<_$AppDatabase, $IncomeSourcesTable> {
  $$IncomeSourcesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);
}

class $$IncomeSourcesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $IncomeSourcesTable,
          IncomeSourceRow,
          $$IncomeSourcesTableFilterComposer,
          $$IncomeSourcesTableOrderingComposer,
          $$IncomeSourcesTableAnnotationComposer,
          $$IncomeSourcesTableCreateCompanionBuilder,
          $$IncomeSourcesTableUpdateCompanionBuilder,
          (
            IncomeSourceRow,
            BaseReferences<_$AppDatabase, $IncomeSourcesTable, IncomeSourceRow>,
          ),
          IncomeSourceRow,
          PrefetchHooks Function()
        > {
  $$IncomeSourcesTableTableManager(_$AppDatabase db, $IncomeSourcesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IncomeSourcesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IncomeSourcesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IncomeSourcesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => IncomeSourcesCompanion(
                id: id,
                name: name,
                archived: archived,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<bool> archived = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => IncomeSourcesCompanion.insert(
                id: id,
                name: name,
                archived: archived,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$IncomeSourcesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $IncomeSourcesTable,
      IncomeSourceRow,
      $$IncomeSourcesTableFilterComposer,
      $$IncomeSourcesTableOrderingComposer,
      $$IncomeSourcesTableAnnotationComposer,
      $$IncomeSourcesTableCreateCompanionBuilder,
      $$IncomeSourcesTableUpdateCompanionBuilder,
      (
        IncomeSourceRow,
        BaseReferences<_$AppDatabase, $IncomeSourcesTable, IncomeSourceRow>,
      ),
      IncomeSourceRow,
      PrefetchHooks Function()
    >;
typedef $$SalaryProfilesTableCreateCompanionBuilder =
    SalaryProfilesCompanion Function({
      required String id,
      required int baseAmountMinor,
      required int payDay,
      Value<String> frequency,
      Value<String> currency,
      Value<String> source,
      required DateTime effectiveFrom,
      Value<bool> active,
      Value<int> rowid,
    });
typedef $$SalaryProfilesTableUpdateCompanionBuilder =
    SalaryProfilesCompanion Function({
      Value<String> id,
      Value<int> baseAmountMinor,
      Value<int> payDay,
      Value<String> frequency,
      Value<String> currency,
      Value<String> source,
      Value<DateTime> effectiveFrom,
      Value<bool> active,
      Value<int> rowid,
    });

class $$SalaryProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $SalaryProfilesTable> {
  $$SalaryProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get baseAmountMinor => $composableBuilder(
    column: $table.baseAmountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get payDay => $composableBuilder(
    column: $table.payDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get effectiveFrom => $composableBuilder(
    column: $table.effectiveFrom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SalaryProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $SalaryProfilesTable> {
  $$SalaryProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get baseAmountMinor => $composableBuilder(
    column: $table.baseAmountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get payDay => $composableBuilder(
    column: $table.payDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get effectiveFrom => $composableBuilder(
    column: $table.effectiveFrom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SalaryProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalaryProfilesTable> {
  $$SalaryProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get baseAmountMinor => $composableBuilder(
    column: $table.baseAmountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get payDay =>
      $composableBuilder(column: $table.payDay, builder: (column) => column);

  GeneratedColumn<String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<DateTime> get effectiveFrom => $composableBuilder(
    column: $table.effectiveFrom,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);
}

class $$SalaryProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SalaryProfilesTable,
          SalaryProfileRow,
          $$SalaryProfilesTableFilterComposer,
          $$SalaryProfilesTableOrderingComposer,
          $$SalaryProfilesTableAnnotationComposer,
          $$SalaryProfilesTableCreateCompanionBuilder,
          $$SalaryProfilesTableUpdateCompanionBuilder,
          (
            SalaryProfileRow,
            BaseReferences<
              _$AppDatabase,
              $SalaryProfilesTable,
              SalaryProfileRow
            >,
          ),
          SalaryProfileRow,
          PrefetchHooks Function()
        > {
  $$SalaryProfilesTableTableManager(
    _$AppDatabase db,
    $SalaryProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalaryProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalaryProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalaryProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> baseAmountMinor = const Value.absent(),
                Value<int> payDay = const Value.absent(),
                Value<String> frequency = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<DateTime> effectiveFrom = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SalaryProfilesCompanion(
                id: id,
                baseAmountMinor: baseAmountMinor,
                payDay: payDay,
                frequency: frequency,
                currency: currency,
                source: source,
                effectiveFrom: effectiveFrom,
                active: active,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int baseAmountMinor,
                required int payDay,
                Value<String> frequency = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String> source = const Value.absent(),
                required DateTime effectiveFrom,
                Value<bool> active = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SalaryProfilesCompanion.insert(
                id: id,
                baseAmountMinor: baseAmountMinor,
                payDay: payDay,
                frequency: frequency,
                currency: currency,
                source: source,
                effectiveFrom: effectiveFrom,
                active: active,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SalaryProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SalaryProfilesTable,
      SalaryProfileRow,
      $$SalaryProfilesTableFilterComposer,
      $$SalaryProfilesTableOrderingComposer,
      $$SalaryProfilesTableAnnotationComposer,
      $$SalaryProfilesTableCreateCompanionBuilder,
      $$SalaryProfilesTableUpdateCompanionBuilder,
      (
        SalaryProfileRow,
        BaseReferences<_$AppDatabase, $SalaryProfilesTable, SalaryProfileRow>,
      ),
      SalaryProfileRow,
      PrefetchHooks Function()
    >;
typedef $$SalaryHistoryTableCreateCompanionBuilder =
    SalaryHistoryCompanion Function({
      required String id,
      required int previousAmountMinor,
      required int newAmountMinor,
      required DateTime effectiveDate,
      Value<String?> reason,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$SalaryHistoryTableUpdateCompanionBuilder =
    SalaryHistoryCompanion Function({
      Value<String> id,
      Value<int> previousAmountMinor,
      Value<int> newAmountMinor,
      Value<DateTime> effectiveDate,
      Value<String?> reason,
      Value<String?> notes,
      Value<int> rowid,
    });

class $$SalaryHistoryTableFilterComposer
    extends Composer<_$AppDatabase, $SalaryHistoryTable> {
  $$SalaryHistoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get previousAmountMinor => $composableBuilder(
    column: $table.previousAmountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get newAmountMinor => $composableBuilder(
    column: $table.newAmountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get effectiveDate => $composableBuilder(
    column: $table.effectiveDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SalaryHistoryTableOrderingComposer
    extends Composer<_$AppDatabase, $SalaryHistoryTable> {
  $$SalaryHistoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get previousAmountMinor => $composableBuilder(
    column: $table.previousAmountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get newAmountMinor => $composableBuilder(
    column: $table.newAmountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get effectiveDate => $composableBuilder(
    column: $table.effectiveDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SalaryHistoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalaryHistoryTable> {
  $$SalaryHistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get previousAmountMinor => $composableBuilder(
    column: $table.previousAmountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get newAmountMinor => $composableBuilder(
    column: $table.newAmountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get effectiveDate => $composableBuilder(
    column: $table.effectiveDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$SalaryHistoryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SalaryHistoryTable,
          SalaryHistoryRow,
          $$SalaryHistoryTableFilterComposer,
          $$SalaryHistoryTableOrderingComposer,
          $$SalaryHistoryTableAnnotationComposer,
          $$SalaryHistoryTableCreateCompanionBuilder,
          $$SalaryHistoryTableUpdateCompanionBuilder,
          (
            SalaryHistoryRow,
            BaseReferences<
              _$AppDatabase,
              $SalaryHistoryTable,
              SalaryHistoryRow
            >,
          ),
          SalaryHistoryRow,
          PrefetchHooks Function()
        > {
  $$SalaryHistoryTableTableManager(_$AppDatabase db, $SalaryHistoryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalaryHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalaryHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalaryHistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> previousAmountMinor = const Value.absent(),
                Value<int> newAmountMinor = const Value.absent(),
                Value<DateTime> effectiveDate = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SalaryHistoryCompanion(
                id: id,
                previousAmountMinor: previousAmountMinor,
                newAmountMinor: newAmountMinor,
                effectiveDate: effectiveDate,
                reason: reason,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int previousAmountMinor,
                required int newAmountMinor,
                required DateTime effectiveDate,
                Value<String?> reason = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SalaryHistoryCompanion.insert(
                id: id,
                previousAmountMinor: previousAmountMinor,
                newAmountMinor: newAmountMinor,
                effectiveDate: effectiveDate,
                reason: reason,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SalaryHistoryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SalaryHistoryTable,
      SalaryHistoryRow,
      $$SalaryHistoryTableFilterComposer,
      $$SalaryHistoryTableOrderingComposer,
      $$SalaryHistoryTableAnnotationComposer,
      $$SalaryHistoryTableCreateCompanionBuilder,
      $$SalaryHistoryTableUpdateCompanionBuilder,
      (
        SalaryHistoryRow,
        BaseReferences<_$AppDatabase, $SalaryHistoryTable, SalaryHistoryRow>,
      ),
      SalaryHistoryRow,
      PrefetchHooks Function()
    >;
typedef $$MonthlyPlansTableCreateCompanionBuilder =
    MonthlyPlansCompanion Function({
      required String id,
      required int year,
      required int month,
      required int expectedIncomeMinor,
      Value<bool> confirmed,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$MonthlyPlansTableUpdateCompanionBuilder =
    MonthlyPlansCompanion Function({
      Value<String> id,
      Value<int> year,
      Value<int> month,
      Value<int> expectedIncomeMinor,
      Value<bool> confirmed,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$MonthlyPlansTableFilterComposer
    extends Composer<_$AppDatabase, $MonthlyPlansTable> {
  $$MonthlyPlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get month => $composableBuilder(
    column: $table.month,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get expectedIncomeMinor => $composableBuilder(
    column: $table.expectedIncomeMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get confirmed => $composableBuilder(
    column: $table.confirmed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MonthlyPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $MonthlyPlansTable> {
  $$MonthlyPlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get month => $composableBuilder(
    column: $table.month,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get expectedIncomeMinor => $composableBuilder(
    column: $table.expectedIncomeMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get confirmed => $composableBuilder(
    column: $table.confirmed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MonthlyPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $MonthlyPlansTable> {
  $$MonthlyPlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<int> get month =>
      $composableBuilder(column: $table.month, builder: (column) => column);

  GeneratedColumn<int> get expectedIncomeMinor => $composableBuilder(
    column: $table.expectedIncomeMinor,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get confirmed =>
      $composableBuilder(column: $table.confirmed, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$MonthlyPlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MonthlyPlansTable,
          MonthlyPlanRow,
          $$MonthlyPlansTableFilterComposer,
          $$MonthlyPlansTableOrderingComposer,
          $$MonthlyPlansTableAnnotationComposer,
          $$MonthlyPlansTableCreateCompanionBuilder,
          $$MonthlyPlansTableUpdateCompanionBuilder,
          (
            MonthlyPlanRow,
            BaseReferences<_$AppDatabase, $MonthlyPlansTable, MonthlyPlanRow>,
          ),
          MonthlyPlanRow,
          PrefetchHooks Function()
        > {
  $$MonthlyPlansTableTableManager(_$AppDatabase db, $MonthlyPlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MonthlyPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MonthlyPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MonthlyPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> year = const Value.absent(),
                Value<int> month = const Value.absent(),
                Value<int> expectedIncomeMinor = const Value.absent(),
                Value<bool> confirmed = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MonthlyPlansCompanion(
                id: id,
                year: year,
                month: month,
                expectedIncomeMinor: expectedIncomeMinor,
                confirmed: confirmed,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int year,
                required int month,
                required int expectedIncomeMinor,
                Value<bool> confirmed = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => MonthlyPlansCompanion.insert(
                id: id,
                year: year,
                month: month,
                expectedIncomeMinor: expectedIncomeMinor,
                confirmed: confirmed,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MonthlyPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MonthlyPlansTable,
      MonthlyPlanRow,
      $$MonthlyPlansTableFilterComposer,
      $$MonthlyPlansTableOrderingComposer,
      $$MonthlyPlansTableAnnotationComposer,
      $$MonthlyPlansTableCreateCompanionBuilder,
      $$MonthlyPlansTableUpdateCompanionBuilder,
      (
        MonthlyPlanRow,
        BaseReferences<_$AppDatabase, $MonthlyPlansTable, MonthlyPlanRow>,
      ),
      MonthlyPlanRow,
      PrefetchHooks Function()
    >;
typedef $$AllocationItemsTableCreateCompanionBuilder =
    AllocationItemsCompanion Function({
      required String id,
      required String planId,
      required String name,
      required String kind,
      required int plannedAmountMinor,
      Value<int?> actualAmountMinor,
      Value<String> status,
      Value<String?> categoryId,
      Value<String?> goalId,
      Value<String?> investmentId,
      Value<String?> billId,
      Value<String?> loanId,
      Value<String?> accountId,
      Value<String?> skipReason,
      Value<String?> skipNote,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$AllocationItemsTableUpdateCompanionBuilder =
    AllocationItemsCompanion Function({
      Value<String> id,
      Value<String> planId,
      Value<String> name,
      Value<String> kind,
      Value<int> plannedAmountMinor,
      Value<int?> actualAmountMinor,
      Value<String> status,
      Value<String?> categoryId,
      Value<String?> goalId,
      Value<String?> investmentId,
      Value<String?> billId,
      Value<String?> loanId,
      Value<String?> accountId,
      Value<String?> skipReason,
      Value<String?> skipNote,
      Value<int> sortOrder,
      Value<int> rowid,
    });

class $$AllocationItemsTableFilterComposer
    extends Composer<_$AppDatabase, $AllocationItemsTable> {
  $$AllocationItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get planId => $composableBuilder(
    column: $table.planId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get plannedAmountMinor => $composableBuilder(
    column: $table.plannedAmountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get actualAmountMinor => $composableBuilder(
    column: $table.actualAmountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goalId => $composableBuilder(
    column: $table.goalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get investmentId => $composableBuilder(
    column: $table.investmentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get billId => $composableBuilder(
    column: $table.billId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get loanId => $composableBuilder(
    column: $table.loanId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get skipReason => $composableBuilder(
    column: $table.skipReason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get skipNote => $composableBuilder(
    column: $table.skipNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AllocationItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $AllocationItemsTable> {
  $$AllocationItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get planId => $composableBuilder(
    column: $table.planId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get plannedAmountMinor => $composableBuilder(
    column: $table.plannedAmountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get actualAmountMinor => $composableBuilder(
    column: $table.actualAmountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goalId => $composableBuilder(
    column: $table.goalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get investmentId => $composableBuilder(
    column: $table.investmentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get billId => $composableBuilder(
    column: $table.billId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get loanId => $composableBuilder(
    column: $table.loanId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get skipReason => $composableBuilder(
    column: $table.skipReason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get skipNote => $composableBuilder(
    column: $table.skipNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AllocationItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AllocationItemsTable> {
  $$AllocationItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get planId =>
      $composableBuilder(column: $table.planId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get plannedAmountMinor => $composableBuilder(
    column: $table.plannedAmountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get actualAmountMinor => $composableBuilder(
    column: $table.actualAmountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get goalId =>
      $composableBuilder(column: $table.goalId, builder: (column) => column);

  GeneratedColumn<String> get investmentId => $composableBuilder(
    column: $table.investmentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get billId =>
      $composableBuilder(column: $table.billId, builder: (column) => column);

  GeneratedColumn<String> get loanId =>
      $composableBuilder(column: $table.loanId, builder: (column) => column);

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<String> get skipReason => $composableBuilder(
    column: $table.skipReason,
    builder: (column) => column,
  );

  GeneratedColumn<String> get skipNote =>
      $composableBuilder(column: $table.skipNote, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$AllocationItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AllocationItemsTable,
          AllocationItemRow,
          $$AllocationItemsTableFilterComposer,
          $$AllocationItemsTableOrderingComposer,
          $$AllocationItemsTableAnnotationComposer,
          $$AllocationItemsTableCreateCompanionBuilder,
          $$AllocationItemsTableUpdateCompanionBuilder,
          (
            AllocationItemRow,
            BaseReferences<
              _$AppDatabase,
              $AllocationItemsTable,
              AllocationItemRow
            >,
          ),
          AllocationItemRow,
          PrefetchHooks Function()
        > {
  $$AllocationItemsTableTableManager(
    _$AppDatabase db,
    $AllocationItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AllocationItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AllocationItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AllocationItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> planId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<int> plannedAmountMinor = const Value.absent(),
                Value<int?> actualAmountMinor = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> goalId = const Value.absent(),
                Value<String?> investmentId = const Value.absent(),
                Value<String?> billId = const Value.absent(),
                Value<String?> loanId = const Value.absent(),
                Value<String?> accountId = const Value.absent(),
                Value<String?> skipReason = const Value.absent(),
                Value<String?> skipNote = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AllocationItemsCompanion(
                id: id,
                planId: planId,
                name: name,
                kind: kind,
                plannedAmountMinor: plannedAmountMinor,
                actualAmountMinor: actualAmountMinor,
                status: status,
                categoryId: categoryId,
                goalId: goalId,
                investmentId: investmentId,
                billId: billId,
                loanId: loanId,
                accountId: accountId,
                skipReason: skipReason,
                skipNote: skipNote,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String planId,
                required String name,
                required String kind,
                required int plannedAmountMinor,
                Value<int?> actualAmountMinor = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> goalId = const Value.absent(),
                Value<String?> investmentId = const Value.absent(),
                Value<String?> billId = const Value.absent(),
                Value<String?> loanId = const Value.absent(),
                Value<String?> accountId = const Value.absent(),
                Value<String?> skipReason = const Value.absent(),
                Value<String?> skipNote = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AllocationItemsCompanion.insert(
                id: id,
                planId: planId,
                name: name,
                kind: kind,
                plannedAmountMinor: plannedAmountMinor,
                actualAmountMinor: actualAmountMinor,
                status: status,
                categoryId: categoryId,
                goalId: goalId,
                investmentId: investmentId,
                billId: billId,
                loanId: loanId,
                accountId: accountId,
                skipReason: skipReason,
                skipNote: skipNote,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AllocationItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AllocationItemsTable,
      AllocationItemRow,
      $$AllocationItemsTableFilterComposer,
      $$AllocationItemsTableOrderingComposer,
      $$AllocationItemsTableAnnotationComposer,
      $$AllocationItemsTableCreateCompanionBuilder,
      $$AllocationItemsTableUpdateCompanionBuilder,
      (
        AllocationItemRow,
        BaseReferences<_$AppDatabase, $AllocationItemsTable, AllocationItemRow>,
      ),
      AllocationItemRow,
      PrefetchHooks Function()
    >;
typedef $$AllocationTemplatesTableCreateCompanionBuilder =
    AllocationTemplatesCompanion Function({
      required String id,
      required String name,
      required String kind,
      required int plannedAmountMinor,
      Value<String?> categoryId,
      Value<String?> goalId,
      Value<String?> investmentId,
      Value<String?> billId,
      Value<String?> loanId,
      Value<String?> accountId,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$AllocationTemplatesTableUpdateCompanionBuilder =
    AllocationTemplatesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> kind,
      Value<int> plannedAmountMinor,
      Value<String?> categoryId,
      Value<String?> goalId,
      Value<String?> investmentId,
      Value<String?> billId,
      Value<String?> loanId,
      Value<String?> accountId,
      Value<int> sortOrder,
      Value<int> rowid,
    });

class $$AllocationTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $AllocationTemplatesTable> {
  $$AllocationTemplatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get plannedAmountMinor => $composableBuilder(
    column: $table.plannedAmountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goalId => $composableBuilder(
    column: $table.goalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get investmentId => $composableBuilder(
    column: $table.investmentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get billId => $composableBuilder(
    column: $table.billId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get loanId => $composableBuilder(
    column: $table.loanId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AllocationTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $AllocationTemplatesTable> {
  $$AllocationTemplatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get plannedAmountMinor => $composableBuilder(
    column: $table.plannedAmountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goalId => $composableBuilder(
    column: $table.goalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get investmentId => $composableBuilder(
    column: $table.investmentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get billId => $composableBuilder(
    column: $table.billId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get loanId => $composableBuilder(
    column: $table.loanId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AllocationTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AllocationTemplatesTable> {
  $$AllocationTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get plannedAmountMinor => $composableBuilder(
    column: $table.plannedAmountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get goalId =>
      $composableBuilder(column: $table.goalId, builder: (column) => column);

  GeneratedColumn<String> get investmentId => $composableBuilder(
    column: $table.investmentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get billId =>
      $composableBuilder(column: $table.billId, builder: (column) => column);

  GeneratedColumn<String> get loanId =>
      $composableBuilder(column: $table.loanId, builder: (column) => column);

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$AllocationTemplatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AllocationTemplatesTable,
          AllocationTemplateRow,
          $$AllocationTemplatesTableFilterComposer,
          $$AllocationTemplatesTableOrderingComposer,
          $$AllocationTemplatesTableAnnotationComposer,
          $$AllocationTemplatesTableCreateCompanionBuilder,
          $$AllocationTemplatesTableUpdateCompanionBuilder,
          (
            AllocationTemplateRow,
            BaseReferences<
              _$AppDatabase,
              $AllocationTemplatesTable,
              AllocationTemplateRow
            >,
          ),
          AllocationTemplateRow,
          PrefetchHooks Function()
        > {
  $$AllocationTemplatesTableTableManager(
    _$AppDatabase db,
    $AllocationTemplatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AllocationTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AllocationTemplatesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$AllocationTemplatesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<int> plannedAmountMinor = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> goalId = const Value.absent(),
                Value<String?> investmentId = const Value.absent(),
                Value<String?> billId = const Value.absent(),
                Value<String?> loanId = const Value.absent(),
                Value<String?> accountId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AllocationTemplatesCompanion(
                id: id,
                name: name,
                kind: kind,
                plannedAmountMinor: plannedAmountMinor,
                categoryId: categoryId,
                goalId: goalId,
                investmentId: investmentId,
                billId: billId,
                loanId: loanId,
                accountId: accountId,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String kind,
                required int plannedAmountMinor,
                Value<String?> categoryId = const Value.absent(),
                Value<String?> goalId = const Value.absent(),
                Value<String?> investmentId = const Value.absent(),
                Value<String?> billId = const Value.absent(),
                Value<String?> loanId = const Value.absent(),
                Value<String?> accountId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AllocationTemplatesCompanion.insert(
                id: id,
                name: name,
                kind: kind,
                plannedAmountMinor: plannedAmountMinor,
                categoryId: categoryId,
                goalId: goalId,
                investmentId: investmentId,
                billId: billId,
                loanId: loanId,
                accountId: accountId,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AllocationTemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AllocationTemplatesTable,
      AllocationTemplateRow,
      $$AllocationTemplatesTableFilterComposer,
      $$AllocationTemplatesTableOrderingComposer,
      $$AllocationTemplatesTableAnnotationComposer,
      $$AllocationTemplatesTableCreateCompanionBuilder,
      $$AllocationTemplatesTableUpdateCompanionBuilder,
      (
        AllocationTemplateRow,
        BaseReferences<
          _$AppDatabase,
          $AllocationTemplatesTable,
          AllocationTemplateRow
        >,
      ),
      AllocationTemplateRow,
      PrefetchHooks Function()
    >;
typedef $$SavingsGoalsTableCreateCompanionBuilder =
    SavingsGoalsCompanion Function({
      required String id,
      required String name,
      required int targetAmountMinor,
      Value<int> currentAmountMinor,
      Value<DateTime?> targetDate,
      Value<int?> monthlyContributionMinor,
      Value<int> priority,
      Value<String?> notes,
      Value<bool> archived,
      Value<int> rowid,
    });
typedef $$SavingsGoalsTableUpdateCompanionBuilder =
    SavingsGoalsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int> targetAmountMinor,
      Value<int> currentAmountMinor,
      Value<DateTime?> targetDate,
      Value<int?> monthlyContributionMinor,
      Value<int> priority,
      Value<String?> notes,
      Value<bool> archived,
      Value<int> rowid,
    });

class $$SavingsGoalsTableFilterComposer
    extends Composer<_$AppDatabase, $SavingsGoalsTable> {
  $$SavingsGoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetAmountMinor => $composableBuilder(
    column: $table.targetAmountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentAmountMinor => $composableBuilder(
    column: $table.currentAmountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get monthlyContributionMinor => $composableBuilder(
    column: $table.monthlyContributionMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SavingsGoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $SavingsGoalsTable> {
  $$SavingsGoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetAmountMinor => $composableBuilder(
    column: $table.targetAmountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentAmountMinor => $composableBuilder(
    column: $table.currentAmountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get monthlyContributionMinor => $composableBuilder(
    column: $table.monthlyContributionMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SavingsGoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavingsGoalsTable> {
  $$SavingsGoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get targetAmountMinor => $composableBuilder(
    column: $table.targetAmountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentAmountMinor => $composableBuilder(
    column: $table.currentAmountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get monthlyContributionMinor => $composableBuilder(
    column: $table.monthlyContributionMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);
}

class $$SavingsGoalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SavingsGoalsTable,
          SavingsGoalRow,
          $$SavingsGoalsTableFilterComposer,
          $$SavingsGoalsTableOrderingComposer,
          $$SavingsGoalsTableAnnotationComposer,
          $$SavingsGoalsTableCreateCompanionBuilder,
          $$SavingsGoalsTableUpdateCompanionBuilder,
          (
            SavingsGoalRow,
            BaseReferences<_$AppDatabase, $SavingsGoalsTable, SavingsGoalRow>,
          ),
          SavingsGoalRow,
          PrefetchHooks Function()
        > {
  $$SavingsGoalsTableTableManager(_$AppDatabase db, $SavingsGoalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavingsGoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavingsGoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavingsGoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> targetAmountMinor = const Value.absent(),
                Value<int> currentAmountMinor = const Value.absent(),
                Value<DateTime?> targetDate = const Value.absent(),
                Value<int?> monthlyContributionMinor = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SavingsGoalsCompanion(
                id: id,
                name: name,
                targetAmountMinor: targetAmountMinor,
                currentAmountMinor: currentAmountMinor,
                targetDate: targetDate,
                monthlyContributionMinor: monthlyContributionMinor,
                priority: priority,
                notes: notes,
                archived: archived,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required int targetAmountMinor,
                Value<int> currentAmountMinor = const Value.absent(),
                Value<DateTime?> targetDate = const Value.absent(),
                Value<int?> monthlyContributionMinor = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SavingsGoalsCompanion.insert(
                id: id,
                name: name,
                targetAmountMinor: targetAmountMinor,
                currentAmountMinor: currentAmountMinor,
                targetDate: targetDate,
                monthlyContributionMinor: monthlyContributionMinor,
                priority: priority,
                notes: notes,
                archived: archived,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SavingsGoalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SavingsGoalsTable,
      SavingsGoalRow,
      $$SavingsGoalsTableFilterComposer,
      $$SavingsGoalsTableOrderingComposer,
      $$SavingsGoalsTableAnnotationComposer,
      $$SavingsGoalsTableCreateCompanionBuilder,
      $$SavingsGoalsTableUpdateCompanionBuilder,
      (
        SavingsGoalRow,
        BaseReferences<_$AppDatabase, $SavingsGoalsTable, SavingsGoalRow>,
      ),
      SavingsGoalRow,
      PrefetchHooks Function()
    >;
typedef $$InvestmentsTableCreateCompanionBuilder =
    InvestmentsCompanion Function({
      required String id,
      required String name,
      required String type,
      required int amountMinor,
      required DateTime date,
      Value<String?> accountId,
      Value<int?> currentValueMinor,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$InvestmentsTableUpdateCompanionBuilder =
    InvestmentsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> type,
      Value<int> amountMinor,
      Value<DateTime> date,
      Value<String?> accountId,
      Value<int?> currentValueMinor,
      Value<String?> notes,
      Value<int> rowid,
    });

class $$InvestmentsTableFilterComposer
    extends Composer<_$AppDatabase, $InvestmentsTable> {
  $$InvestmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentValueMinor => $composableBuilder(
    column: $table.currentValueMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InvestmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $InvestmentsTable> {
  $$InvestmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentValueMinor => $composableBuilder(
    column: $table.currentValueMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InvestmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvestmentsTable> {
  $$InvestmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<int> get currentValueMinor => $composableBuilder(
    column: $table.currentValueMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$InvestmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvestmentsTable,
          InvestmentRow,
          $$InvestmentsTableFilterComposer,
          $$InvestmentsTableOrderingComposer,
          $$InvestmentsTableAnnotationComposer,
          $$InvestmentsTableCreateCompanionBuilder,
          $$InvestmentsTableUpdateCompanionBuilder,
          (
            InvestmentRow,
            BaseReferences<_$AppDatabase, $InvestmentsTable, InvestmentRow>,
          ),
          InvestmentRow,
          PrefetchHooks Function()
        > {
  $$InvestmentsTableTableManager(_$AppDatabase db, $InvestmentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvestmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvestmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvestmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> amountMinor = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> accountId = const Value.absent(),
                Value<int?> currentValueMinor = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvestmentsCompanion(
                id: id,
                name: name,
                type: type,
                amountMinor: amountMinor,
                date: date,
                accountId: accountId,
                currentValueMinor: currentValueMinor,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String type,
                required int amountMinor,
                required DateTime date,
                Value<String?> accountId = const Value.absent(),
                Value<int?> currentValueMinor = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvestmentsCompanion.insert(
                id: id,
                name: name,
                type: type,
                amountMinor: amountMinor,
                date: date,
                accountId: accountId,
                currentValueMinor: currentValueMinor,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InvestmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvestmentsTable,
      InvestmentRow,
      $$InvestmentsTableFilterComposer,
      $$InvestmentsTableOrderingComposer,
      $$InvestmentsTableAnnotationComposer,
      $$InvestmentsTableCreateCompanionBuilder,
      $$InvestmentsTableUpdateCompanionBuilder,
      (
        InvestmentRow,
        BaseReferences<_$AppDatabase, $InvestmentsTable, InvestmentRow>,
      ),
      InvestmentRow,
      PrefetchHooks Function()
    >;
typedef $$BudgetsTableCreateCompanionBuilder =
    BudgetsCompanion Function({
      required String id,
      required String categoryId,
      required int amountMinor,
      required int year,
      required int month,
      Value<bool> warn75,
      Value<bool> warn90,
      Value<bool> warn100,
      Value<int> rowid,
    });
typedef $$BudgetsTableUpdateCompanionBuilder =
    BudgetsCompanion Function({
      Value<String> id,
      Value<String> categoryId,
      Value<int> amountMinor,
      Value<int> year,
      Value<int> month,
      Value<bool> warn75,
      Value<bool> warn90,
      Value<bool> warn100,
      Value<int> rowid,
    });

class $$BudgetsTableFilterComposer
    extends Composer<_$AppDatabase, $BudgetsTable> {
  $$BudgetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get month => $composableBuilder(
    column: $table.month,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get warn75 => $composableBuilder(
    column: $table.warn75,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get warn90 => $composableBuilder(
    column: $table.warn90,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get warn100 => $composableBuilder(
    column: $table.warn100,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BudgetsTableOrderingComposer
    extends Composer<_$AppDatabase, $BudgetsTable> {
  $$BudgetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get month => $composableBuilder(
    column: $table.month,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get warn75 => $composableBuilder(
    column: $table.warn75,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get warn90 => $composableBuilder(
    column: $table.warn90,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get warn100 => $composableBuilder(
    column: $table.warn100,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BudgetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BudgetsTable> {
  $$BudgetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<int> get month =>
      $composableBuilder(column: $table.month, builder: (column) => column);

  GeneratedColumn<bool> get warn75 =>
      $composableBuilder(column: $table.warn75, builder: (column) => column);

  GeneratedColumn<bool> get warn90 =>
      $composableBuilder(column: $table.warn90, builder: (column) => column);

  GeneratedColumn<bool> get warn100 =>
      $composableBuilder(column: $table.warn100, builder: (column) => column);
}

class $$BudgetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BudgetsTable,
          BudgetRow,
          $$BudgetsTableFilterComposer,
          $$BudgetsTableOrderingComposer,
          $$BudgetsTableAnnotationComposer,
          $$BudgetsTableCreateCompanionBuilder,
          $$BudgetsTableUpdateCompanionBuilder,
          (BudgetRow, BaseReferences<_$AppDatabase, $BudgetsTable, BudgetRow>),
          BudgetRow,
          PrefetchHooks Function()
        > {
  $$BudgetsTableTableManager(_$AppDatabase db, $BudgetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BudgetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BudgetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BudgetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<int> amountMinor = const Value.absent(),
                Value<int> year = const Value.absent(),
                Value<int> month = const Value.absent(),
                Value<bool> warn75 = const Value.absent(),
                Value<bool> warn90 = const Value.absent(),
                Value<bool> warn100 = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BudgetsCompanion(
                id: id,
                categoryId: categoryId,
                amountMinor: amountMinor,
                year: year,
                month: month,
                warn75: warn75,
                warn90: warn90,
                warn100: warn100,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String categoryId,
                required int amountMinor,
                required int year,
                required int month,
                Value<bool> warn75 = const Value.absent(),
                Value<bool> warn90 = const Value.absent(),
                Value<bool> warn100 = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BudgetsCompanion.insert(
                id: id,
                categoryId: categoryId,
                amountMinor: amountMinor,
                year: year,
                month: month,
                warn75: warn75,
                warn90: warn90,
                warn100: warn100,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BudgetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BudgetsTable,
      BudgetRow,
      $$BudgetsTableFilterComposer,
      $$BudgetsTableOrderingComposer,
      $$BudgetsTableAnnotationComposer,
      $$BudgetsTableCreateCompanionBuilder,
      $$BudgetsTableUpdateCompanionBuilder,
      (BudgetRow, BaseReferences<_$AppDatabase, $BudgetsTable, BudgetRow>),
      BudgetRow,
      PrefetchHooks Function()
    >;
typedef $$BillsTableCreateCompanionBuilder =
    BillsCompanion Function({
      required String id,
      required String name,
      required int amountMinor,
      required int dueDay,
      Value<String> frequency,
      Value<String?> accountId,
      Value<String?> categoryId,
      Value<bool> reminder,
      Value<bool> autoPlan,
      Value<bool> archived,
      Value<int> rowid,
    });
typedef $$BillsTableUpdateCompanionBuilder =
    BillsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int> amountMinor,
      Value<int> dueDay,
      Value<String> frequency,
      Value<String?> accountId,
      Value<String?> categoryId,
      Value<bool> reminder,
      Value<bool> autoPlan,
      Value<bool> archived,
      Value<int> rowid,
    });

class $$BillsTableFilterComposer extends Composer<_$AppDatabase, $BillsTable> {
  $$BillsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dueDay => $composableBuilder(
    column: $table.dueDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get reminder => $composableBuilder(
    column: $table.reminder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get autoPlan => $composableBuilder(
    column: $table.autoPlan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BillsTableOrderingComposer
    extends Composer<_$AppDatabase, $BillsTable> {
  $$BillsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dueDay => $composableBuilder(
    column: $table.dueDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get reminder => $composableBuilder(
    column: $table.reminder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get autoPlan => $composableBuilder(
    column: $table.autoPlan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BillsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BillsTable> {
  $$BillsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dueDay =>
      $composableBuilder(column: $table.dueDay, builder: (column) => column);

  GeneratedColumn<String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get reminder =>
      $composableBuilder(column: $table.reminder, builder: (column) => column);

  GeneratedColumn<bool> get autoPlan =>
      $composableBuilder(column: $table.autoPlan, builder: (column) => column);

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);
}

class $$BillsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BillsTable,
          BillRow,
          $$BillsTableFilterComposer,
          $$BillsTableOrderingComposer,
          $$BillsTableAnnotationComposer,
          $$BillsTableCreateCompanionBuilder,
          $$BillsTableUpdateCompanionBuilder,
          (BillRow, BaseReferences<_$AppDatabase, $BillsTable, BillRow>),
          BillRow,
          PrefetchHooks Function()
        > {
  $$BillsTableTableManager(_$AppDatabase db, $BillsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BillsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BillsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BillsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> amountMinor = const Value.absent(),
                Value<int> dueDay = const Value.absent(),
                Value<String> frequency = const Value.absent(),
                Value<String?> accountId = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<bool> reminder = const Value.absent(),
                Value<bool> autoPlan = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BillsCompanion(
                id: id,
                name: name,
                amountMinor: amountMinor,
                dueDay: dueDay,
                frequency: frequency,
                accountId: accountId,
                categoryId: categoryId,
                reminder: reminder,
                autoPlan: autoPlan,
                archived: archived,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required int amountMinor,
                required int dueDay,
                Value<String> frequency = const Value.absent(),
                Value<String?> accountId = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<bool> reminder = const Value.absent(),
                Value<bool> autoPlan = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BillsCompanion.insert(
                id: id,
                name: name,
                amountMinor: amountMinor,
                dueDay: dueDay,
                frequency: frequency,
                accountId: accountId,
                categoryId: categoryId,
                reminder: reminder,
                autoPlan: autoPlan,
                archived: archived,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BillsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BillsTable,
      BillRow,
      $$BillsTableFilterComposer,
      $$BillsTableOrderingComposer,
      $$BillsTableAnnotationComposer,
      $$BillsTableCreateCompanionBuilder,
      $$BillsTableUpdateCompanionBuilder,
      (BillRow, BaseReferences<_$AppDatabase, $BillsTable, BillRow>),
      BillRow,
      PrefetchHooks Function()
    >;
typedef $$LoansTableCreateCompanionBuilder =
    LoansCompanion Function({
      required String id,
      required String name,
      required int principalMinor,
      required double interestRate,
      required int emiMinor,
      required DateTime startDate,
      required DateTime endDate,
      required int remainingMinor,
      Value<String?> accountId,
      Value<bool> archived,
      Value<int> rowid,
    });
typedef $$LoansTableUpdateCompanionBuilder =
    LoansCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int> principalMinor,
      Value<double> interestRate,
      Value<int> emiMinor,
      Value<DateTime> startDate,
      Value<DateTime> endDate,
      Value<int> remainingMinor,
      Value<String?> accountId,
      Value<bool> archived,
      Value<int> rowid,
    });

class $$LoansTableFilterComposer extends Composer<_$AppDatabase, $LoansTable> {
  $$LoansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get principalMinor => $composableBuilder(
    column: $table.principalMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get interestRate => $composableBuilder(
    column: $table.interestRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get emiMinor => $composableBuilder(
    column: $table.emiMinor,
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

  ColumnFilters<int> get remainingMinor => $composableBuilder(
    column: $table.remainingMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LoansTableOrderingComposer
    extends Composer<_$AppDatabase, $LoansTable> {
  $$LoansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get principalMinor => $composableBuilder(
    column: $table.principalMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get interestRate => $composableBuilder(
    column: $table.interestRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get emiMinor => $composableBuilder(
    column: $table.emiMinor,
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

  ColumnOrderings<int> get remainingMinor => $composableBuilder(
    column: $table.remainingMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LoansTableAnnotationComposer
    extends Composer<_$AppDatabase, $LoansTable> {
  $$LoansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get principalMinor => $composableBuilder(
    column: $table.principalMinor,
    builder: (column) => column,
  );

  GeneratedColumn<double> get interestRate => $composableBuilder(
    column: $table.interestRate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get emiMinor =>
      $composableBuilder(column: $table.emiMinor, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<int> get remainingMinor => $composableBuilder(
    column: $table.remainingMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);
}

class $$LoansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LoansTable,
          LoanRow,
          $$LoansTableFilterComposer,
          $$LoansTableOrderingComposer,
          $$LoansTableAnnotationComposer,
          $$LoansTableCreateCompanionBuilder,
          $$LoansTableUpdateCompanionBuilder,
          (LoanRow, BaseReferences<_$AppDatabase, $LoansTable, LoanRow>),
          LoanRow,
          PrefetchHooks Function()
        > {
  $$LoansTableTableManager(_$AppDatabase db, $LoansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LoansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LoansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LoansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> principalMinor = const Value.absent(),
                Value<double> interestRate = const Value.absent(),
                Value<int> emiMinor = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime> endDate = const Value.absent(),
                Value<int> remainingMinor = const Value.absent(),
                Value<String?> accountId = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LoansCompanion(
                id: id,
                name: name,
                principalMinor: principalMinor,
                interestRate: interestRate,
                emiMinor: emiMinor,
                startDate: startDate,
                endDate: endDate,
                remainingMinor: remainingMinor,
                accountId: accountId,
                archived: archived,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required int principalMinor,
                required double interestRate,
                required int emiMinor,
                required DateTime startDate,
                required DateTime endDate,
                required int remainingMinor,
                Value<String?> accountId = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LoansCompanion.insert(
                id: id,
                name: name,
                principalMinor: principalMinor,
                interestRate: interestRate,
                emiMinor: emiMinor,
                startDate: startDate,
                endDate: endDate,
                remainingMinor: remainingMinor,
                accountId: accountId,
                archived: archived,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LoansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LoansTable,
      LoanRow,
      $$LoansTableFilterComposer,
      $$LoansTableOrderingComposer,
      $$LoansTableAnnotationComposer,
      $$LoansTableCreateCompanionBuilder,
      $$LoansTableUpdateCompanionBuilder,
      (LoanRow, BaseReferences<_$AppDatabase, $LoansTable, LoanRow>),
      LoanRow,
      PrefetchHooks Function()
    >;
typedef $$FinancialGoalsTableCreateCompanionBuilder =
    FinancialGoalsCompanion Function({
      required String id,
      required String name,
      required int targetAmountMinor,
      Value<int> currentAmountMinor,
      Value<DateTime?> deadline,
      Value<int?> requiredMonthlyMinor,
      Value<String> kind,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$FinancialGoalsTableUpdateCompanionBuilder =
    FinancialGoalsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int> targetAmountMinor,
      Value<int> currentAmountMinor,
      Value<DateTime?> deadline,
      Value<int?> requiredMonthlyMinor,
      Value<String> kind,
      Value<String?> notes,
      Value<int> rowid,
    });

class $$FinancialGoalsTableFilterComposer
    extends Composer<_$AppDatabase, $FinancialGoalsTable> {
  $$FinancialGoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetAmountMinor => $composableBuilder(
    column: $table.targetAmountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentAmountMinor => $composableBuilder(
    column: $table.currentAmountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deadline => $composableBuilder(
    column: $table.deadline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get requiredMonthlyMinor => $composableBuilder(
    column: $table.requiredMonthlyMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FinancialGoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $FinancialGoalsTable> {
  $$FinancialGoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetAmountMinor => $composableBuilder(
    column: $table.targetAmountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentAmountMinor => $composableBuilder(
    column: $table.currentAmountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deadline => $composableBuilder(
    column: $table.deadline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get requiredMonthlyMinor => $composableBuilder(
    column: $table.requiredMonthlyMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FinancialGoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FinancialGoalsTable> {
  $$FinancialGoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get targetAmountMinor => $composableBuilder(
    column: $table.targetAmountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentAmountMinor => $composableBuilder(
    column: $table.currentAmountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deadline =>
      $composableBuilder(column: $table.deadline, builder: (column) => column);

  GeneratedColumn<int> get requiredMonthlyMinor => $composableBuilder(
    column: $table.requiredMonthlyMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$FinancialGoalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FinancialGoalsTable,
          FinancialGoalRow,
          $$FinancialGoalsTableFilterComposer,
          $$FinancialGoalsTableOrderingComposer,
          $$FinancialGoalsTableAnnotationComposer,
          $$FinancialGoalsTableCreateCompanionBuilder,
          $$FinancialGoalsTableUpdateCompanionBuilder,
          (
            FinancialGoalRow,
            BaseReferences<
              _$AppDatabase,
              $FinancialGoalsTable,
              FinancialGoalRow
            >,
          ),
          FinancialGoalRow,
          PrefetchHooks Function()
        > {
  $$FinancialGoalsTableTableManager(
    _$AppDatabase db,
    $FinancialGoalsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FinancialGoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FinancialGoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FinancialGoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> targetAmountMinor = const Value.absent(),
                Value<int> currentAmountMinor = const Value.absent(),
                Value<DateTime?> deadline = const Value.absent(),
                Value<int?> requiredMonthlyMinor = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FinancialGoalsCompanion(
                id: id,
                name: name,
                targetAmountMinor: targetAmountMinor,
                currentAmountMinor: currentAmountMinor,
                deadline: deadline,
                requiredMonthlyMinor: requiredMonthlyMinor,
                kind: kind,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required int targetAmountMinor,
                Value<int> currentAmountMinor = const Value.absent(),
                Value<DateTime?> deadline = const Value.absent(),
                Value<int?> requiredMonthlyMinor = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FinancialGoalsCompanion.insert(
                id: id,
                name: name,
                targetAmountMinor: targetAmountMinor,
                currentAmountMinor: currentAmountMinor,
                deadline: deadline,
                requiredMonthlyMinor: requiredMonthlyMinor,
                kind: kind,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FinancialGoalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FinancialGoalsTable,
      FinancialGoalRow,
      $$FinancialGoalsTableFilterComposer,
      $$FinancialGoalsTableOrderingComposer,
      $$FinancialGoalsTableAnnotationComposer,
      $$FinancialGoalsTableCreateCompanionBuilder,
      $$FinancialGoalsTableUpdateCompanionBuilder,
      (
        FinancialGoalRow,
        BaseReferences<_$AppDatabase, $FinancialGoalsTable, FinancialGoalRow>,
      ),
      FinancialGoalRow,
      PrefetchHooks Function()
    >;
typedef $$NotesTableCreateCompanionBuilder =
    NotesCompanion Function({
      required String id,
      required String body,
      required DateTime createdAt,
      Value<String?> transactionId,
      Value<String?> allocationId,
      Value<String?> goalId,
      Value<String?> monthKey,
      Value<String?> accountId,
      Value<int> rowid,
    });
typedef $$NotesTableUpdateCompanionBuilder =
    NotesCompanion Function({
      Value<String> id,
      Value<String> body,
      Value<DateTime> createdAt,
      Value<String?> transactionId,
      Value<String?> allocationId,
      Value<String?> goalId,
      Value<String?> monthKey,
      Value<String?> accountId,
      Value<int> rowid,
    });

class $$NotesTableFilterComposer extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get allocationId => $composableBuilder(
    column: $table.allocationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goalId => $composableBuilder(
    column: $table.goalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get monthKey => $composableBuilder(
    column: $table.monthKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotesTableOrderingComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get allocationId => $composableBuilder(
    column: $table.allocationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goalId => $composableBuilder(
    column: $table.goalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get monthKey => $composableBuilder(
    column: $table.monthKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get allocationId => $composableBuilder(
    column: $table.allocationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get goalId =>
      $composableBuilder(column: $table.goalId, builder: (column) => column);

  GeneratedColumn<String> get monthKey =>
      $composableBuilder(column: $table.monthKey, builder: (column) => column);

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);
}

class $$NotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotesTable,
          NoteRow,
          $$NotesTableFilterComposer,
          $$NotesTableOrderingComposer,
          $$NotesTableAnnotationComposer,
          $$NotesTableCreateCompanionBuilder,
          $$NotesTableUpdateCompanionBuilder,
          (NoteRow, BaseReferences<_$AppDatabase, $NotesTable, NoteRow>),
          NoteRow,
          PrefetchHooks Function()
        > {
  $$NotesTableTableManager(_$AppDatabase db, $NotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> transactionId = const Value.absent(),
                Value<String?> allocationId = const Value.absent(),
                Value<String?> goalId = const Value.absent(),
                Value<String?> monthKey = const Value.absent(),
                Value<String?> accountId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotesCompanion(
                id: id,
                body: body,
                createdAt: createdAt,
                transactionId: transactionId,
                allocationId: allocationId,
                goalId: goalId,
                monthKey: monthKey,
                accountId: accountId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String body,
                required DateTime createdAt,
                Value<String?> transactionId = const Value.absent(),
                Value<String?> allocationId = const Value.absent(),
                Value<String?> goalId = const Value.absent(),
                Value<String?> monthKey = const Value.absent(),
                Value<String?> accountId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotesCompanion.insert(
                id: id,
                body: body,
                createdAt: createdAt,
                transactionId: transactionId,
                allocationId: allocationId,
                goalId: goalId,
                monthKey: monthKey,
                accountId: accountId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotesTable,
      NoteRow,
      $$NotesTableFilterComposer,
      $$NotesTableOrderingComposer,
      $$NotesTableAnnotationComposer,
      $$NotesTableCreateCompanionBuilder,
      $$NotesTableUpdateCompanionBuilder,
      (NoteRow, BaseReferences<_$AppDatabase, $NotesTable, NoteRow>),
      NoteRow,
      PrefetchHooks Function()
    >;
typedef $$AuditLogsTableCreateCompanionBuilder =
    AuditLogsCompanion Function({
      required String id,
      required String action,
      required DateTime at,
      Value<String?> payload,
      Value<int> rowid,
    });
typedef $$AuditLogsTableUpdateCompanionBuilder =
    AuditLogsCompanion Function({
      Value<String> id,
      Value<String> action,
      Value<DateTime> at,
      Value<String?> payload,
      Value<int> rowid,
    });

class $$AuditLogsTableFilterComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AuditLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AuditLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<DateTime> get at =>
      $composableBuilder(column: $table.at, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);
}

class $$AuditLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AuditLogsTable,
          AuditLogRow,
          $$AuditLogsTableFilterComposer,
          $$AuditLogsTableOrderingComposer,
          $$AuditLogsTableAnnotationComposer,
          $$AuditLogsTableCreateCompanionBuilder,
          $$AuditLogsTableUpdateCompanionBuilder,
          (
            AuditLogRow,
            BaseReferences<_$AppDatabase, $AuditLogsTable, AuditLogRow>,
          ),
          AuditLogRow,
          PrefetchHooks Function()
        > {
  $$AuditLogsTableTableManager(_$AppDatabase db, $AuditLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuditLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuditLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuditLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<DateTime> at = const Value.absent(),
                Value<String?> payload = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AuditLogsCompanion(
                id: id,
                action: action,
                at: at,
                payload: payload,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String action,
                required DateTime at,
                Value<String?> payload = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AuditLogsCompanion.insert(
                id: id,
                action: action,
                at: at,
                payload: payload,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AuditLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AuditLogsTable,
      AuditLogRow,
      $$AuditLogsTableFilterComposer,
      $$AuditLogsTableOrderingComposer,
      $$AuditLogsTableAnnotationComposer,
      $$AuditLogsTableCreateCompanionBuilder,
      $$AuditLogsTableUpdateCompanionBuilder,
      (
        AuditLogRow,
        BaseReferences<_$AppDatabase, $AuditLogsTable, AuditLogRow>,
      ),
      AuditLogRow,
      PrefetchHooks Function()
    >;
typedef $$FeatureSettingsTableCreateCompanionBuilder =
    FeatureSettingsCompanion Function({
      required String featureKey,
      required bool enabled,
      Value<int> rowid,
    });
typedef $$FeatureSettingsTableUpdateCompanionBuilder =
    FeatureSettingsCompanion Function({
      Value<String> featureKey,
      Value<bool> enabled,
      Value<int> rowid,
    });

class $$FeatureSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $FeatureSettingsTable> {
  $$FeatureSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get featureKey => $composableBuilder(
    column: $table.featureKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FeatureSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $FeatureSettingsTable> {
  $$FeatureSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get featureKey => $composableBuilder(
    column: $table.featureKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FeatureSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeatureSettingsTable> {
  $$FeatureSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get featureKey => $composableBuilder(
    column: $table.featureKey,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);
}

class $$FeatureSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FeatureSettingsTable,
          FeatureSettingRow,
          $$FeatureSettingsTableFilterComposer,
          $$FeatureSettingsTableOrderingComposer,
          $$FeatureSettingsTableAnnotationComposer,
          $$FeatureSettingsTableCreateCompanionBuilder,
          $$FeatureSettingsTableUpdateCompanionBuilder,
          (
            FeatureSettingRow,
            BaseReferences<
              _$AppDatabase,
              $FeatureSettingsTable,
              FeatureSettingRow
            >,
          ),
          FeatureSettingRow,
          PrefetchHooks Function()
        > {
  $$FeatureSettingsTableTableManager(
    _$AppDatabase db,
    $FeatureSettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeatureSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeatureSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeatureSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> featureKey = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeatureSettingsCompanion(
                featureKey: featureKey,
                enabled: enabled,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String featureKey,
                required bool enabled,
                Value<int> rowid = const Value.absent(),
              }) => FeatureSettingsCompanion.insert(
                featureKey: featureKey,
                enabled: enabled,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FeatureSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FeatureSettingsTable,
      FeatureSettingRow,
      $$FeatureSettingsTableFilterComposer,
      $$FeatureSettingsTableOrderingComposer,
      $$FeatureSettingsTableAnnotationComposer,
      $$FeatureSettingsTableCreateCompanionBuilder,
      $$FeatureSettingsTableUpdateCompanionBuilder,
      (
        FeatureSettingRow,
        BaseReferences<_$AppDatabase, $FeatureSettingsTable, FeatureSettingRow>,
      ),
      FeatureSettingRow,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSettingRow,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSettingRow,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSettingRow>,
          ),
          AppSettingRow,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSettingRow,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSettingRow,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSettingRow>,
      ),
      AppSettingRow,
      PrefetchHooks Function()
    >;
typedef $$NetWorthSnapshotsTableCreateCompanionBuilder =
    NetWorthSnapshotsCompanion Function({
      required String id,
      required DateTime at,
      required int assetsMinor,
      required int liabilitiesMinor,
      required int netMinor,
      Value<int> rowid,
    });
typedef $$NetWorthSnapshotsTableUpdateCompanionBuilder =
    NetWorthSnapshotsCompanion Function({
      Value<String> id,
      Value<DateTime> at,
      Value<int> assetsMinor,
      Value<int> liabilitiesMinor,
      Value<int> netMinor,
      Value<int> rowid,
    });

class $$NetWorthSnapshotsTableFilterComposer
    extends Composer<_$AppDatabase, $NetWorthSnapshotsTable> {
  $$NetWorthSnapshotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get assetsMinor => $composableBuilder(
    column: $table.assetsMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get liabilitiesMinor => $composableBuilder(
    column: $table.liabilitiesMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get netMinor => $composableBuilder(
    column: $table.netMinor,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NetWorthSnapshotsTableOrderingComposer
    extends Composer<_$AppDatabase, $NetWorthSnapshotsTable> {
  $$NetWorthSnapshotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get assetsMinor => $composableBuilder(
    column: $table.assetsMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get liabilitiesMinor => $composableBuilder(
    column: $table.liabilitiesMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get netMinor => $composableBuilder(
    column: $table.netMinor,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NetWorthSnapshotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NetWorthSnapshotsTable> {
  $$NetWorthSnapshotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get at =>
      $composableBuilder(column: $table.at, builder: (column) => column);

  GeneratedColumn<int> get assetsMinor => $composableBuilder(
    column: $table.assetsMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get liabilitiesMinor => $composableBuilder(
    column: $table.liabilitiesMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get netMinor =>
      $composableBuilder(column: $table.netMinor, builder: (column) => column);
}

class $$NetWorthSnapshotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NetWorthSnapshotsTable,
          NetWorthSnapshotRow,
          $$NetWorthSnapshotsTableFilterComposer,
          $$NetWorthSnapshotsTableOrderingComposer,
          $$NetWorthSnapshotsTableAnnotationComposer,
          $$NetWorthSnapshotsTableCreateCompanionBuilder,
          $$NetWorthSnapshotsTableUpdateCompanionBuilder,
          (
            NetWorthSnapshotRow,
            BaseReferences<
              _$AppDatabase,
              $NetWorthSnapshotsTable,
              NetWorthSnapshotRow
            >,
          ),
          NetWorthSnapshotRow,
          PrefetchHooks Function()
        > {
  $$NetWorthSnapshotsTableTableManager(
    _$AppDatabase db,
    $NetWorthSnapshotsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NetWorthSnapshotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NetWorthSnapshotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NetWorthSnapshotsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> at = const Value.absent(),
                Value<int> assetsMinor = const Value.absent(),
                Value<int> liabilitiesMinor = const Value.absent(),
                Value<int> netMinor = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NetWorthSnapshotsCompanion(
                id: id,
                at: at,
                assetsMinor: assetsMinor,
                liabilitiesMinor: liabilitiesMinor,
                netMinor: netMinor,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime at,
                required int assetsMinor,
                required int liabilitiesMinor,
                required int netMinor,
                Value<int> rowid = const Value.absent(),
              }) => NetWorthSnapshotsCompanion.insert(
                id: id,
                at: at,
                assetsMinor: assetsMinor,
                liabilitiesMinor: liabilitiesMinor,
                netMinor: netMinor,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NetWorthSnapshotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NetWorthSnapshotsTable,
      NetWorthSnapshotRow,
      $$NetWorthSnapshotsTableFilterComposer,
      $$NetWorthSnapshotsTableOrderingComposer,
      $$NetWorthSnapshotsTableAnnotationComposer,
      $$NetWorthSnapshotsTableCreateCompanionBuilder,
      $$NetWorthSnapshotsTableUpdateCompanionBuilder,
      (
        NetWorthSnapshotRow,
        BaseReferences<
          _$AppDatabase,
          $NetWorthSnapshotsTable,
          NetWorthSnapshotRow
        >,
      ),
      NetWorthSnapshotRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db, _db.accounts);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
  $$IncomeSourcesTableTableManager get incomeSources =>
      $$IncomeSourcesTableTableManager(_db, _db.incomeSources);
  $$SalaryProfilesTableTableManager get salaryProfiles =>
      $$SalaryProfilesTableTableManager(_db, _db.salaryProfiles);
  $$SalaryHistoryTableTableManager get salaryHistory =>
      $$SalaryHistoryTableTableManager(_db, _db.salaryHistory);
  $$MonthlyPlansTableTableManager get monthlyPlans =>
      $$MonthlyPlansTableTableManager(_db, _db.monthlyPlans);
  $$AllocationItemsTableTableManager get allocationItems =>
      $$AllocationItemsTableTableManager(_db, _db.allocationItems);
  $$AllocationTemplatesTableTableManager get allocationTemplates =>
      $$AllocationTemplatesTableTableManager(_db, _db.allocationTemplates);
  $$SavingsGoalsTableTableManager get savingsGoals =>
      $$SavingsGoalsTableTableManager(_db, _db.savingsGoals);
  $$InvestmentsTableTableManager get investments =>
      $$InvestmentsTableTableManager(_db, _db.investments);
  $$BudgetsTableTableManager get budgets =>
      $$BudgetsTableTableManager(_db, _db.budgets);
  $$BillsTableTableManager get bills =>
      $$BillsTableTableManager(_db, _db.bills);
  $$LoansTableTableManager get loans =>
      $$LoansTableTableManager(_db, _db.loans);
  $$FinancialGoalsTableTableManager get financialGoals =>
      $$FinancialGoalsTableTableManager(_db, _db.financialGoals);
  $$NotesTableTableManager get notes =>
      $$NotesTableTableManager(_db, _db.notes);
  $$AuditLogsTableTableManager get auditLogs =>
      $$AuditLogsTableTableManager(_db, _db.auditLogs);
  $$FeatureSettingsTableTableManager get featureSettings =>
      $$FeatureSettingsTableTableManager(_db, _db.featureSettings);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$NetWorthSnapshotsTableTableManager get netWorthSnapshots =>
      $$NetWorthSnapshotsTableTableManager(_db, _db.netWorthSnapshots);
}
