part of 'quiz_bloc.dart';

@immutable
sealed class MyHomeEvent {}

class InitHome extends MyHomeEvent {}

class StartTimer extends MyHomeEvent {}

class NextQuestion extends MyHomeEvent {}

class LeaderboardEvent extends MyHomeEvent {}

class NeverSubmit extends MyHomeEvent {}

class Tick extends MyHomeEvent {}

class SetAnswer extends MyHomeEvent {
  SetAnswer(this.question, this.answer);
  int question;
  int answer;
}

class StorePerQuestionResult extends MyHomeEvent {}

class NewTimeSet extends MyHomeEvent {
  NewTimeSet(this.newTime);
  int newTime;
}
