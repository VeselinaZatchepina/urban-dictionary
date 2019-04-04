import 'dart:async';
import 'package:urban_dictionary/bloc/WordInfoState.dart';
import 'package:urban_dictionary/repositories/UrbanDictionaryRepository.dart';

class SearchBloc {
  UrbanDictionaryRepository _repository = UrbanDictionaryRepository();
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
