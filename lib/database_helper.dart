import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'users.db');

    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT UNIQUE,
            password TEXT,
            name TEXT,
            image TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute("ALTER TABLE users ADD COLUMN name TEXT");
          await db.execute("ALTER TABLE users ADD COLUMN image TEXT");
        }
      },
    );
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await instance.database;
    final existingUser = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [user['email']],
    );

    if (existingUser.isNotEmpty) {
      return -1; // Email already exists
    }
    return await db.insert('users', user);
  }

  Future<Map<String, dynamic>?> getUser(String email) async {
    final db = await instance.database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<int> updateUser(Map<String, dynamic> user) async {
    final db = await instance.database;
    return await db.update(
      'users',
      user,
      where: 'email = ?',
      whereArgs: [user['email']],
    );
  }
}
