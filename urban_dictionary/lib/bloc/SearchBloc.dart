import 'dart:async';
import 'package:urban_dictionary/bloc/WordInfoState.dart';
import 'package:urban_dictionary/repositories/UrbanDictionaryRepositoryImpl.dart';

class SearchBloc {
  UrbanDictionaryRepositoryImpl _repository = UrbanDictionaryRepositoryImpl();
  final _searchWordInfoStreamController =
      StreamController<WordInfoState>.broadcast();
  final _addToFavoritesWordInfoStreamController = StreamController<int>();

  Stream<WordInfoState> get searchWordInfo =>
      _searchWordInfoStreamController.stream;
  Stream<int> get addToFavoritesWordInfo =>
      _addToFavoritesWordInfoStreamController.stream;

  void getWordInfo(String word, bool saveToHistory) {
    _searchWordInfoStreamController.sink.add(WordInfoState.loading());
    _repository
        .getUrbanWordInfo(word, saveToHistory: saveToHistory)
        .then((urbanWordStatus) {
      _searchWordInfoStreamController.sink.add(urbanWordStatus);
    });
  }

  void addWordInfoToFavorites() {
    _repository.addUrbanWordInfoToFavorites().then((id) {
      _addToFavoritesWordInfoStreamController.sink.add(id);
    });
  }

  void dispose() {
    _searchWordInfoStreamController.close();
  }
}
