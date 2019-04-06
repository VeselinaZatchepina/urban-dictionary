import 'package:urban_dictionary/bloc/WordInfoState.dart';

abstract class UrbanDictionaryRepository {

  Future<WordInfoState> getUrbanWordInfo(String word, {bool saveToHistory});

  Future<WordInfoState> getHistoryUrbanWordInfo();

  Future<int> addUrbanWordInfoToFavorites();

  Future<WordInfoState> getFavoritesUrbanWordInfo();
}
