import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:urban_dictionary/db/models/WordInfo.dart';

class DbProvider {
  DbProvider._();

  static final DbProvider dbProvider = DbProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE WordInfo ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "word TEXT,"
          "description TEXT,"
          "example TEXT,"
          "author TEXT"
          ")");

      await db.execute("CREATE TABLE WordHistory ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "word_id TEXT"
          ")");

      await db.execute("CREATE TABLE WordFavorites ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "word_id TEXT"
          ")");
    });
  }

  Future<int> addWordInfoToHistory(WordInfo wordInfo) async {
    final db = await database;
    var res = await db.transaction((txn) async {
      int id = await txn.rawInsert(
          'INSERT Into WordInfo(word, description, example, author) VALUES(?, ?, ?, ?)',
          [
            wordInfo.word,
            wordInfo.description,
            wordInfo.example,
            wordInfo.author
          ]);
      await txn.execute('INSERT Into WordHistory (word_id) VALUES($id)');
    });
    return res;
  }

  Future<List<WordInfo>> getWordInfoHistory() async {
    final db = await database;
    List<WordInfo> resultList = List();
    List<Map> wordMaps = await db.rawQuery(
        'SELECT * FROM WordInfo INNER JOIN WordHistory ON WordInfo.id = WordHistory.word_id ORDER BY WordInfo.id DESC');
    for (Map mapInfo in wordMaps) {
      resultList.add(WordInfo.fromJson(mapInfo));
    }
    return resultList;
  }
}
