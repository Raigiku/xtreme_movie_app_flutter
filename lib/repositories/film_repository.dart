import 'package:sqflite/sqflite.dart';
import 'package:xtreme_movie_app/models/film.dart';

import 'database_creator.dart';

class FilmRepository {
  static Future<void> insert(Film film) async {
    await db.insert(
      'film',
      film.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Film>> getAll() async {
    final maps = await db.query('film');
    return List.generate(maps.length, (index) {
      return Film(
        maps[index]['id'],
        maps[index]['title'],
        maps[index]['overview'],
        maps[index]['favorite'] == 1 ? true : false,
      );
    });
  }

  static Future<void> deleteById(int id) async {
    await db.delete(
      'film',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
