import 'dart:async';
import 'package:urban_dictionary/bloc/WordInfoState.dart';
import 'package:urban_dictionary/repositories/UrbanDictionaryRepositoryImpl.dart';

class HistoryBloc {
  UrbanDictionaryRepositoryImpl _repository = UrbanDictionaryRepositoryImpl();
  final _wordInfoStreamController = StreamController<WordInfoState>();

  Stream<WordInfoState> get wordInfoStream => _wordInfoStreamController.stream;

  void getWordInfo() {
    _wordInfoStreamController.sink.add(WordInfoState.loading());
    _repository.getHistoryWordInfo().then((urbanWordStatus) {
      _wordInfoStreamController.sink.add(urbanWordStatus);
    });
  }

  void dispose() {
    _wordInfoStreamController.close();
  }
}
