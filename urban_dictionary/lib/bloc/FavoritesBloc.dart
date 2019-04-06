import 'dart:async';
import 'package:urban_dictionary/bloc/WordInfoState.dart';
import 'package:urban_dictionary/repositories/UrbanDictionaryRepositoryImpl.dart';

class FavoritesBloc {
  UrbanDictionaryRepositoryImpl _repository = UrbanDictionaryRepositoryImpl();
  final _favoritesWordsStreamController = StreamController<WordInfoState>();

  Stream<WordInfoState> get favoritesWordInfo => _favoritesWordsStreamController.stream;

  void getFavoritesWordInfo() {
    _favoritesWordsStreamController.sink.add(WordInfoState.loading());
    _repository.getFavoritesUrbanWordInfo().then((urbanWordStatus) {
      _favoritesWordsStreamController.sink.add(urbanWordStatus);
    });
  }

  void dispose() {
    _favoritesWordsStreamController.close();
  }
}
