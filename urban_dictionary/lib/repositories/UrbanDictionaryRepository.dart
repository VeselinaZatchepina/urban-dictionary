import 'package:urban_dictionary/bloc/WordInfoState.dart';


abstract class UrbanDictionaryRepository {

  Future<WordInfoState> getWordInfo(String word);

  Future<WordInfoState> getHistoryWordInfo();

}