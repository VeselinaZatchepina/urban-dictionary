import 'dart:async';
import 'package:urban_dictionary/bloc/WordInfoState.dart';
import 'package:urban_dictionary/repositories/UrbanDictionaryRepositoryImpl.dart';

class HistoryBloc {
  UrbanDictionaryRepositoryImpl _repository = UrbanDictionaryRepositoryImpl();
  final _historyWordsInfoStreamController = StreamController<WordInfoState>();

  Stream<WordInfoState> get historyWordInfoStream => _historyWordsInfoStreamController.stream;

  void getHistoryWordInfo() {
    _historyWordsInfoStreamController.sink.add(WordInfoState.loading());
    _repository.getHistoryUrbanWordInfo().then((urbanWordStatus) {
      _historyWordsInfoStreamController.sink.add(urbanWordStatus);
    });
  }

  void dispose() {
    _historyWordsInfoStreamController.close();
  }
}
