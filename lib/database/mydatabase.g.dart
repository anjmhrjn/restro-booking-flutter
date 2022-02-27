// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mydatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TableDao? _tableDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TableEntity` (`pk` INTEGER PRIMARY KEY AUTOINCREMENT, `id` TEXT NOT NULL, `min_capacity` TEXT NOT NULL, `max_capacity` TEXT NOT NULL, `is_available` INTEGER NOT NULL, `table_number` TEXT NOT NULL, `tableOf` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TableDao get tableDao {
    return _tableDaoInstance ??= _$TableDao(database, changeListener);
  }
}

class _$TableDao extends TableDao {
  _$TableDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _tableEntityInsertionAdapter = InsertionAdapter(
            database,
            'TableEntity',
            (TableEntity item) => <String, Object?>{
                  'pk': item.pk,
                  'id': item.id,
                  'min_capacity': item.min_capacity,
                  'max_capacity': item.max_capacity,
                  'is_available': item.is_available ? 1 : 0,
                  'table_number': item.table_number,
                  'tableOf': item.tableOf
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TableEntity> _tableEntityInsertionAdapter;

  @override
  Future<List<TableEntity>> findAllTables() async {
    return _queryAdapter.queryList('Select * from TableEntity',
        mapper: (Map<String, Object?> row) => TableEntity(
            pk: row['pk'] as int?,
            id: row['id'] as String,
            min_capacity: row['min_capacity'] as String,
            max_capacity: row['max_capacity'] as String,
            is_available: (row['is_available'] as int) != 0,
            table_number: row['table_number'] as String,
            tableOf: row['tableOf'] as String));
  }

  @override
  Future<TableEntity?> findTableById(String id) async {
    return _queryAdapter.query('Select * from TableEntity Where id= ?1',
        mapper: (Map<String, Object?> row) => TableEntity(
            pk: row['pk'] as int?,
            id: row['id'] as String,
            min_capacity: row['min_capacity'] as String,
            max_capacity: row['max_capacity'] as String,
            is_available: (row['is_available'] as int) != 0,
            table_number: row['table_number'] as String,
            tableOf: row['tableOf'] as String),
        arguments: [id]);
  }

  @override
  Future<List<TableEntity>> findBusinessTables(String tableOf) async {
    return _queryAdapter.queryList(
        'Select * from TableEntity Where tableOf= ?1',
        mapper: (Map<String, Object?> row) => TableEntity(
            pk: row['pk'] as int?,
            id: row['id'] as String,
            min_capacity: row['min_capacity'] as String,
            max_capacity: row['max_capacity'] as String,
            is_available: (row['is_available'] as int) != 0,
            table_number: row['table_number'] as String,
            tableOf: row['tableOf'] as String),
        arguments: [tableOf]);
  }

  @override
  Future<int?> deleteBusinessTables() async {
    await _queryAdapter.queryNoReturn('Delete from TableEntity');
  }

  @override
  Future<int> insertTables(TableEntity table) {
    return _tableEntityInsertionAdapter.insertAndReturnId(
        table, OnConflictStrategy.abort);
  }
}
