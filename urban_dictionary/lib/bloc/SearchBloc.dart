import 'dart:async';
import 'package:urban_dictionary/bloc/WordInfoState.dart';
import 'package:urban_dictionary/repositories/UrbanDictionaryRepositoryImpl.dart';

class SearchBloc {
  UrbanDictionaryRepositoryImpl _repository = UrbanDictionaryRepositoryImpl();
  final _userStreamController = StreamController<WordInfoState>();

  Stream<WordInfoState> get urbanWordInfo => _userStreamController.stream;

  void getWordInfo(String word) {
    _userStreamController.sink.add(WordInfoState.loading());
    _repository.getWordInfo(word).then((urbanWordStatus) {
      _userStreamController.sink.add(urbanWordStatus);
    });
  }

  void dispose() {
    _userStreamController.close();
  }

}
