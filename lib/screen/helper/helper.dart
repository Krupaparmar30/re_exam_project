

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../modal/modal.dart';

class DBService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, 'tasks.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            dueDate TEXT,
            priority TEXT,
            status TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertTask(Modal task) async {
    final db = await database;
    await db.insert('tasks', task.toMap());
  }

  Future<List<Modal>> getTasks() async {
    final db = await database;
    final tasks = await db.query('tasks');
    return tasks.map((task) => Modal.fromMap(task)).toList();
  }

  Future<void> updateTask(Modal task) async {
    final db = await database;
    await db
        .update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<void> deleteTask(int id) async {
    final db = await database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
