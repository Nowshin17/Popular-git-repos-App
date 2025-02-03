import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/repo_model.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'repos.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          """CREATE TABLE repos(
            name TEXT PRIMARY KEY,
            description TEXT,
            url TEXT,
            stars INTEGER,
            owner_name TEXT,
            owner_avatar_url TEXT,
            updated_at TEXT
          )""",
        );
      },
    );
  }

  Future<void> insertRepos(List<GitRepo> repos) async {
    final db = await database;
    for (var repo in repos) {
      await db.insert('repos', repo.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }


}
