import 'dart:async';

import 'package:urban_dictionary/entities/UrbanWordInfo.dart';
import 'package:urban_dictionary/repositories/UrbanDictionaryRepository.dart';

class SearchBloc {
  UrbanDictionaryRepository _repository = UrbanDictionaryRepository();
  final _userStreamController = StreamController<List<UrbanWordInfo>>();
  Stream<List<UrbanWordInfo>> get urbanWordInfo => _userStreamController.stream;

  void getWordInfo(String word) {
    _repository.getWordInfo(word).then((urbanWord) {
      List<UrbanWordInfo> list  = urbanWord;
      _userStreamController.sink.add(urbanWord);
  });
  }

  void dispose() {
    _userStreamController.close();
  }

}
