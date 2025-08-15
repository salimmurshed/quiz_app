import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:quiz_app/app/locator.dart';
import 'package:quiz_app/screens/home/home.dart';
import 'package:quiz_app/services/database_services/database_services.dart';

import '../../model/question_model.dart';
import '../../services/navigation/navigation_service.dart';
import '../leaderboard/leaderboard.dart';
import '../result/result.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';
part 'quiz_bloc.freezed.dart';

class MyHomeBloc extends Bloc<MyHomeEvent, MyHomeState> {
  DataBaseService ds = locator<DataBaseService>();
  MyHomeBloc() : super(MyHomeState.initial()) {
    on<InitHome>(_initHome);
    on<StartTimer>(_startTimer);
    on<NextQuestion>(_nextQuestion);
    on<LeaderboardEvent>(_leaderboard);
    on<NeverSubmit>(_neverSubmit);
    on<Tick>(_onTick);
    on<SetAnswer>(_setAnswer);
    on<NewTimeSet>(_newTimeSet);
  }

  FutureOr<void> _initHome(InitHome event, Emitter<MyHomeState> emit) {
    print(state.timeLeft);
    emit(
      state.copyWith(
        question: ds.question,
        currentIndex: 0,
        timeLeft: state.questionTime,
        pageController: PageController(),
      ),
    );

    add(StartTimer());
  }

  void _newTimeSet(NewTimeSet event, Emitter<MyHomeState> emit) {
    emit(state.copyWith(timeLeft: event.newTime));
  }

  void _startTimer(StartTimer event, Emitter<MyHomeState> emit) {
    state.timer?.cancel();
    emit(state.copyWith(timeLeft: state.questionTime));
    final newTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      final newTime = state.timeLeft - 1;
      if (newTime > 0) {
        add(NewTimeSet(newTime));
      } else {
        t.cancel();
        add(NextQuestion());
      }
    });
    emit(state.copyWith(timer: newTimer));
  }

  FutureOr<void> _nextQuestion(NextQuestion event, Emitter<MyHomeState> emit) {
    if (state.currentIndex < state.question.length - 1) {
      final newIndex = state.currentIndex + 1;
      emit(state.copyWith(currentIndex: newIndex));

      state.pageController?.animateToPage(
        newIndex,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
      );

      add(StartTimer());
    } else {
      state.timer?.cancel();
      locator<NavigationService>().pushReplacement(Result(), arguments: {});
    }
  }

  FutureOr<void> _onTick(Tick event, Emitter<MyHomeState> emit) {
    if (state.timeLeft > 0) {
      emit(state.copyWith(timeLeft: state.timeLeft - 1));
    } else {
      state.timer?.cancel();
      add(NextQuestion());
    }
  }

  @override
  Future<void> close() {
    state.timer?.cancel();
    state.pageController?.dispose();
    return super.close();
  }

  FutureOr<void> _leaderboard(
    LeaderboardEvent event,
    Emitter<MyHomeState> emit,
  ) {
    add(NextQuestion());
  }

  FutureOr<void> _neverSubmit(NeverSubmit event, Emitter<MyHomeState> emit) {
    locator<NavigationService>().pushAndRemoveAll(Home(), arguments: {});
    ds.addUser(name: "new user", score: 0);
  }

  FutureOr<void> _setAnswer(SetAnswer event, Emitter<MyHomeState> emit) {
    List<QuestionModel> question = List.from(state.question);
    question[event.question].answer = event.answer;
    emit(state.copyWith(question: question));
    if (question[event.question].answer ==
        question[event.question].answerIndex) {
      ds.submitIndividualResult();
    }
    print(question[event.question].toJson());
  }
}
