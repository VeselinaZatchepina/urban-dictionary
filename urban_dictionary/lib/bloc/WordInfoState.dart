import 'package:urban_dictionary/entities/UrbanWordInfo.dart';

class WordInfoState {
  WordInfoState();

  factory WordInfoState.success(List<UrbanWordInfo> urbanWordInfos) =>
      WordInfoSuccess(urbanWordInfos);

  factory WordInfoState.loading() => WordInfoLoading();

  factory WordInfoState.error() => WordInfoError();

  factory WordInfoState.init() => WordInfoInit();
}

class WordInfoInit extends WordInfoState {}

class WordInfoLoading extends WordInfoState {}

class WordInfoSuccess extends WordInfoState {
  WordInfoSuccess(this.urbanWordInfos);

  final List<UrbanWordInfo> urbanWordInfos;
}

class WordInfoError extends WordInfoState {}
