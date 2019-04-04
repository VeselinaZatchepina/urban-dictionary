import 'package:urban_dictionary/entities/UrbanWordInfo.dart';

UrbanWordInfo convertFromJsonToUrbanWordInfo(dynamic json) {
  String word = json["word"];
  String description = json["definition"];
  String example = json["example"];
  String author = json["author"];
  return UrbanWordInfo(word, description, example, author);
}
