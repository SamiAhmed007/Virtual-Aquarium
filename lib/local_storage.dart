import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalStorage {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('fish_settings.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    return await openDatabase(
      join(await getDatabasesPath(), filePath),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE settings (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            fishCount INTEGER,
            speed REAL,
            color TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  Future<void> saveSettings(int fishCount, double speed, String color) async {
    final db = await database;
    await db.insert('settings', {
      'fishCount': fishCount,
      'speed': speed,
      'color': color,
    });
  }

  Future<Map<String, dynamic>?> loadSettings() async {
    final db = await database;
    final result = await db.query('settings', orderBy: 'id DESC', limit: 1);
    return result.isNotEmpty ? result.first : null;
  }
}
