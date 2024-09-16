import 'dart:io';

import 'package:main_app/models/moviesdao.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MoviesDatabase {
  static final NAMEDB = 'MOVIESDB';
  static final VERSIONDB = 1;
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    return _database = await initDatabse();
  }

  Future<Database> initDatabse() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String path = join(folder.path, NAMEDB);
    return openDatabase(
      path,
      version: VERSIONDB,
      onCreate: (db, version) {
        String query = '''
          CREATE TABLE tblGenre(
            idGenre char(1) primary key,
            dscGenre varchar(50)
          );
          
          CREATE TABLE tblMovies(
            idMovie INTEGER PRIMARY KEY,
            nameMovie VARCHAR(100),
            overview TEXT,
            idGenre char(1),
            imgageMovie varchar(150),
            releaseDate char(10),

            constraint fk_genre FOREIGN KEY (idGenre) REFERENCES tblGenre(idGenre)
          );''';

        db.execute(query);
      },
    );
  }

  Future<int> INSERT(String table, Map<String, dynamic> values) async {
    var con = await database;
    return await con.insert(table, values);
  }

  Future<int> UPDATE(String table, Map<String, dynamic> row) async {
    var con = await database;
    return await con
        .update(table, row, where: 'idMovie = ?', whereArgs: [row['idMovie']]);
  }

  Future<int> DELETE(String table, int idMovie) async {
    var con = await database;
    return await con
        .delete(table, where: 'where idMovie = ?', whereArgs: [idMovie]);
  }

  Future<List<MoviesDAO>> SELECT() async {
    var con = await database;
    var result = await con.query('tblMoviews');
    return result.map((movie) => MoviesDAO.fromMap(movie)).toList();
  }
}
