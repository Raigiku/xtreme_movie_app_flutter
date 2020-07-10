import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Database db;

class DatabaseCreator {
  Future<void> createFilmTable(Database db) async {
    const filmTable = 'film';
    const idSql = 'id ' + 'INTEGER ' + 'PRIMARY KEY';
    const titleSql = 'title ' + 'TEXT';
    const overviewSql = 'overview ' + 'TEXT';
    const favoriteSql = 'favorite ' + 'INTEGER';

    final createFilmTable =
        'CREATE TABLE $filmTable($idSql, $titleSql, $overviewSql, $favoriteSql)';
    await db.execute(createFilmTable);
  }

  Future<String> databasePath(String dbName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    if (await Directory(dirname(path)).exists()) {
      // await deleteDatabase(path);
    } else {
      await Directory(dirname(path)).create(recursive: true);
    }
    return path;
  }

  Future<void> onCreate(Database db, int version) async {
    await createFilmTable(db);
  }

  Future<void> initDatabase() async {
    final path = await databasePath('films_db');
    db = await openDatabase(path, version: 1, onCreate: onCreate);
    print(db);
  }
}
