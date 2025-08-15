part of 'quiz_bloc.dart';

@freezed
abstract class MyHomeState with _$MyHomeState {
  const factory MyHomeState({
    @Default(false) bool isLoading,
    @Default([]) List<QuestionModel> question,
    @Default(null) PageController? pageController,
    @Default(30) int timeLeft,
    @Default(0) int currentIndex,
    @Default(30) int questionTime,
    @Default(null) Timer? timer,
    @Default(false) bool isQuizFinished,
  }) = _MyHomeState;
  factory MyHomeState.initial() => MyHomeState(
    isLoading: false,
    question: const [],
    pageController: PageController(),
    timeLeft: 30,
    currentIndex: 0,
    questionTime: 30,
    timer: null,
    isQuizFinished: false,
  );
}
