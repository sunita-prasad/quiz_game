// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorQuizDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$QuizDatabaseBuilder databaseBuilder(String name) =>
      _$QuizDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$QuizDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$QuizDatabaseBuilder(null);
}

class _$QuizDatabaseBuilder {
  _$QuizDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$QuizDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$QuizDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<QuizDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$QuizDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$QuizDatabase extends QuizDatabase {
  _$QuizDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  QuizDAO? _quizDAOInstance;

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
            'CREATE TABLE IF NOT EXISTS `quiz` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `que` TEXT NOT NULL, `type` TEXT NOT NULL, `level` TEXT NOT NULL, `ans` TEXT NOT NULL, `option` TEXT NOT NULL, `que_no` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  QuizDAO get quizDAO {
    return _quizDAOInstance ??= _$QuizDAO(database, changeListener);
  }
}

class _$QuizDAO extends QuizDAO {
  _$QuizDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<quiz>> retrieveQuiz() async {
    return _queryAdapter.queryList('SELECT * FROM quiz',
        mapper: (Map<String, Object?> row) => quiz(
            id: row['id'] as int?,
            que: row['que'] as String,
            type: row['type'] as String,
            level: row['level'] as String,
            ans: row['ans'] as String,
            option: row['option'] as String,
            que_no: row['que_no'] as int));
  }

  @override
  Future<quiz?> getQuestion(int level, int queNo) async {
    return _queryAdapter.query(
        'SELECT * FROM quiz WHERE level=?1 AND que_no=?2',
        mapper: (Map<String, Object?> row) => quiz(
            id: row['id'] as int?,
            que: row['que'] as String,
            type: row['type'] as String,
            level: row['level'] as String,
            ans: row['ans'] as String,
            option: row['option'] as String,
            que_no: row['que_no'] as int),
        arguments: [level, queNo]);
  }
}
