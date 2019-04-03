import 'package:urban_dictionary/entities/UrbanWordInfo.dart';
import 'package:http/http.dart' as http;

class UrbanDictionaryRepository {
  final String baseUrl = "http://api.urbandictionary.com/v0";

  Future<List<UrbanWordInfo>> getWordInfo(String word) async {

   http.get("$baseUrl/define?term=$word").then((response) {
      print("Response status: ${response.request}");
      print("Response body: ${response.body}");
    });

    return null;
  }
}
