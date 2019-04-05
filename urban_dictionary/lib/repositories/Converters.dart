import 'package:urban_dictionary/db/models/WordInfo.dart';
import 'package:urban_dictionary/entities/UrbanWordInfo.dart';

UrbanWordInfo convertFromJsonToUrbanWordInfo(dynamic json) {
  String word = json["word"];
  String description = json["definition"];
  String example = json["example"];
  String author = json["author"];
  return UrbanWordInfo(word, description, example, author);
}

WordInfo convertFromUrbanWordInfoToWordInfo(UrbanWordInfo urbanWordInfo) {
  return WordInfo(
    word: urbanWordInfo.word,
    description: urbanWordInfo.description,
    example: urbanWordInfo.example,
    author: urbanWordInfo.author
  );
}

UrbanWordInfo convertFromWordInfoToUrbanWordInfo(WordInfo wordInfo) {
  return UrbanWordInfo(wordInfo.word, wordInfo.description, wordInfo.example, wordInfo.author);
}
