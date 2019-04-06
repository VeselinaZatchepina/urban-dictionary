import 'package:urban_dictionary/bloc/WordInfoState.dart';
import 'package:urban_dictionary/db/DatabaseProvider.dart';
import 'package:urban_dictionary/db/models/WordInfoModel.dart';
import 'package:urban_dictionary/entities/UrbanWordInfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;
import 'package:urban_dictionary/repositories/Converters.dart';
import 'package:urban_dictionary/repositories/UrbanDictionaryRepository.dart';

class UrbanDictionaryRepositoryImpl extends UrbanDictionaryRepository {
  final String baseUrl = "http://api.urbandictionary.com/v0";

  @override
  Future<WordInfoState> getUrbanWordInfo(String word, {bool saveToHistory = true}) async {
    List<UrbanWordInfo> urbanWordInfos = List();
    
    final response = await http.get("$baseUrl/define?term=$word");
    if (response.statusCode == 200) {
      // Парсим ответ
      dynamic responseJson = json.jsonDecode(response.body);
      List<dynamic> wordInfoList = responseJson["list"];
      for (dynamic wordInfo in wordInfoList) {
        UrbanWordInfo urbanWordInfo = convertFromJsonToUrbanWordInfo(wordInfo);
        urbanWordInfos.add(urbanWordInfo);
      }
      // Сохраняем в историю запросов
      if (saveToHistory) {
        if (urbanWordInfos.isNotEmpty) {
          UrbanWordInfo urbanWordInfo = urbanWordInfos.first;
          urbanWordInfo.word = word;
          await DatabaseProvider.dbProvider.addWordInfoToHistory(
              convertFromUrbanWordInfoToWordInfoModel(urbanWordInfos.first));
        }
      }
      
      return WordInfoSuccess(urbanWordInfos);
    } else {
      return WordInfoSuccess(List());
    }
  }

  @override
  Future<WordInfoState> getHistoryUrbanWordInfo() async {
    List<UrbanWordInfo> urbanWordInfos = List();
    List<WordInfo> result =
        await DatabaseProvider.dbProvider.getWordInfoHistory();
    for (WordInfo wordInfo in result) {
      UrbanWordInfo urbanWordInfo =
          convertFromWordInfoModelToUrbanWordInfo(wordInfo);
      urbanWordInfos.add(urbanWordInfo);
    }
    return WordInfoSuccess(urbanWordInfos);
  }

  @override
  Future<WordInfoState> getFavoritesUrbanWordInfo() async {
    List<UrbanWordInfo> urbanWordInfos = List();
    List<WordInfo> result =
        await DatabaseProvider.dbProvider.getWordInfoFavorites();
    for (WordInfo wordInfo in result) {
      UrbanWordInfo urbanWordInfo =
          convertFromWordInfoModelToUrbanWordInfo(wordInfo);
      urbanWordInfos.add(urbanWordInfo);
    }
    return WordInfoSuccess(urbanWordInfos);
  }

  @override
  Future<int> addUrbanWordInfoToFavorites() async {
    int result = await DatabaseProvider.dbProvider.addWordInfoToFavorites();
    return result;
  }
}
