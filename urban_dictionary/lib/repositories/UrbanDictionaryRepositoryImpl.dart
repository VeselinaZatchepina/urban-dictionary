import 'package:urban_dictionary/bloc/WordInfoState.dart';
import 'package:urban_dictionary/db/DbProvider.dart';
import 'package:urban_dictionary/db/models/WordInfo.dart';
import 'package:urban_dictionary/entities/UrbanWordInfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;
import 'package:urban_dictionary/repositories/Converters.dart';
import 'package:urban_dictionary/repositories/UrbanDictionaryRepository.dart';
import 'package:rxdart/rxdart.dart';


class UrbanDictionaryRepositoryImpl extends UrbanDictionaryRepository {
  final String baseUrl = "http://api.urbandictionary.com/v0";

  @override
  Future<WordInfoState> getWordInfo(String word) async {
      List<UrbanWordInfo> urbanWordInfos = List();
      final response = await http.get("$baseUrl/define?term=$word");

      if (response.statusCode == 200) {
        dynamic responseJson = json.jsonDecode(response.body);
        List<dynamic> wordInfoList = responseJson["list"];
        for (dynamic wordInfo in wordInfoList) {
          UrbanWordInfo urbanWordInfo = convertFromJsonToUrbanWordInfo(wordInfo);
          urbanWordInfos.add(urbanWordInfo);
        }
        DbProvider.dbProvider
            .addWordInfoToHistory(convertFromUrbanWordInfoToWordInfo(urbanWordInfos.first));

        return WordInfoSuccess(urbanWordInfos);
      } else {
        print("Exception...or No data...");
        return WordInfoSuccess(List());
      }
  }

  @override
  Future<WordInfoState> getHistoryWordInfo() async {
    List<UrbanWordInfo> urbanWordInfos = List();
    List<WordInfo> result = await DbProvider.dbProvider.getWordInfoHistory();
    for (WordInfo wordInfo in result) {
      UrbanWordInfo urbanWordInfo = convertFromWordInfoToUrbanWordInfo(wordInfo);
      urbanWordInfos.add(urbanWordInfo);
    }
    return WordInfoSuccess(urbanWordInfos);
  }

}
