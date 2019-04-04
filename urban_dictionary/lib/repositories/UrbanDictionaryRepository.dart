import 'package:urban_dictionary/bloc/WordInfoState.dart';
import 'package:urban_dictionary/entities/UrbanWordInfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;
import 'package:urban_dictionary/repositories/Converters.dart';

class UrbanDictionaryRepository {
  final String baseUrl = "http://api.urbandictionary.com/v0";

  Future<WordInfoState> getWordInfo(String word) async {
    List<UrbanWordInfo> urbanWordInfos = List();
    final response = await http.get("$baseUrl/define?term=$word");

    if (response.statusCode == 200) {
      dynamic responseJson = json.jsonDecode(response.body);
      List<dynamic> wordInfoList = responseJson["list"];
      for (dynamic wordInfo in wordInfoList) {
        UrbanWordInfo urbanWordInfo = convertFromJsonToUrbanWordInfo(wordInfo);
        urbanWordInfos.add(urbanWordInfo);
        print(urbanWordInfo);
      }
      return WordInfoState.success(urbanWordInfos);
    } else {
      print("Exception...or No data...");
      return WordInfoState.error();
    }
  }
}
