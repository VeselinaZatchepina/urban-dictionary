import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:urban_dictionary/db/models/WordInfoModel.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider dbProvider = DatabaseProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "UrbanDictionary.db");
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

  /// Добавление информации о последнем введенном слове в историю запросов.
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

  /// Получение истории запросов.
  Future<List<WordInfo>> getWordInfoHistory() async {
    final db = await database;
    List<WordInfo> resultList = List();
    List<Map> wordHistoryMaps = await db.rawQuery(
        'SELECT * FROM WordInfo INNER JOIN WordHistory ON WordInfo.id = WordHistory.word_id ORDER BY WordInfo.id DESC');
    for (Map mapWordInfo in wordHistoryMaps) {
      resultList.add(WordInfo.fromJson(mapWordInfo));
    }
    return resultList;
  }

  /// Добавление последнего введенного слова в избранное.
  Future<int> addWordInfoToFavorites() async {
    final db = await database;
    var res = await db.transaction((txn) async {
      List<Map> wordMaps =
          await txn.rawQuery('SELECT * FROM WordInfo ORDER BY ID DESC LIMIT 1');
      WordInfo wordInfo = WordInfo.fromJson(wordMaps.first);
      await txn.rawInsert(
          'INSERT Into WordFavorites(word_id) VALUES(?)', [wordInfo.id]);
    });
    return res;
  }

  /// Получение списка избранных слов.
  Future<List<WordInfo>> getWordInfoFavorites() async {
    final db = await database;
    List<WordInfo> resultList = List();
    List<Map> wordFavoritesMaps = await db.rawQuery(
        'SELECT * FROM WordInfo INNER JOIN WordFavorites ON WordInfo.id = WordFavorites.word_id ORDER BY WordInfo.id DESC');
    for (Map mapWordInfo in wordFavoritesMaps) {
      resultList.add(WordInfo.fromJson(mapWordInfo));
    }
    return resultList;
  }

}
