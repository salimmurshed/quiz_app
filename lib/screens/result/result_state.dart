part of 'result_bloc.dart';

@freezed
abstract class ResultState with _$ResultState {
  const factory ResultState({
    @Default(false) bool isLoading,
    @Default(0) int totalQuestion,
    @Default(0) int result,
    @Default(0.0) double winStack,
  }) = _ResultState;
  factory ResultState.initial() =>
      ResultState(isLoading: false, totalQuestion: 0, result: 0, winStack: 0.0);
}
