import 'package:path/path.dart';
import '../models/task.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  ///Defining database variable
  static const _dbName = 'Todos.db';
  static const _dbVersion = 1;
  static const _tableName = 'Tasks';
  static const columnId = '_id';
  static const columnTask = 'Task';
  static const columnDone = 'IsDone';
  static const orderBy = '$columnId DESC';

  ///Define Constructor Using Singelton pattern
  DatabaseHelper._privetConstructor();
  static final dbConstructor = DatabaseHelper._privetConstructor();

  ///Define database object
  static Database? _db;

  ///Get database to _db variable
  Future<Database> get getDatabase async {
    if (_db != null) return _db!;

    _db = await _createDatabase();
    return _db!;
  }

  ///Creating database
  _createDatabase() async {
    String defaultPath = await getDatabasesPath();
    String path = join(defaultPath, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  ///Setting up database fields
  Future _onCreate(Database database, int version) async {
    await database.execute('''
      CREATE TABLE $_tableName(
        $columnId INTEGER PRIMARY KEY,
        $columnDone TEXT NOT NULL,
        $columnTask INTEGER NOT NULL
        )
      ''');
  }

  ///adding to database
  Future<Task> insert(Task task) async {
    Database db = await dbConstructor.getDatabase;

    task.id = await db.insert(_tableName, task.toMap());

    return task;
  }

  Future<List<Task>> readAll() async {
    Database db = await dbConstructor.getDatabase;
    List<Map<String, dynamic>> query =
        await db.query(_tableName, orderBy: orderBy);
    List<Task> todos = [];
    for (Map<String, dynamic> element in query) {
      Task task = Task.fromMap(element);
      todos.add(task);
    }

    return todos;
  }

  Future<int> delet(int id) async {
    Database db = await dbConstructor.getDatabase;
    return await db.delete(_tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Task task) async {
    Database db = await dbConstructor.getDatabase;
    int id = task.id!;

    return await db.update(_tableName, task.toMap(),
        where: '$columnId = ?', whereArgs: [id]);
  }
}
