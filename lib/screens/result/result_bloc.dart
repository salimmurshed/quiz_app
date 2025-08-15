import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

import '../../app/locator.dart';
import '../../services/database_services/database_services.dart';

part 'result_event.dart';
part 'result_state.dart';
part 'result_bloc.freezed.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  DataBaseService ds = locator<DataBaseService>();

  ResultBloc() : super(ResultState.initial()) {
    on<InitResult>(_initResult);
  }

  FutureOr<void> _initResult(InitResult event, Emitter<ResultState> emit) {
    emit(
      state.copyWith(
        result: ds.result,
        totalQuestion: ds.totalQuestion,
        winStack: ds.result / ds.totalQuestion * 100,
        // winStack: (ds.result / ds.totalQuestion) * 100,
      ),
    );
    ds.addUser(name: "new user", score: state.winStack);
  }
}
