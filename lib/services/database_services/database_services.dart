import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/utils/assets.dart';

import '../../model/question_model.dart';

@lazySingleton
class DataBaseService {
  List<QuestionModel> question = [];
  final List<Map<String, dynamic>> allResultsLeaderboard = [
    {"name": "Salim", "score": 25.0},
    {"name": "Sufian", "score": 100.0},
    {"name": "Shimu", "score": 50.0},
    {"name": "Iunus", "score": 25.0},
    {"name": "Kamil", "score": 25.0},
  ];

  int result = 0;
  int totalQuestion = 0;
  Future<List<QuestionModel>> loadQuestionFromAssets() async {
    final String jsonString = await rootBundle.loadString(Assets.questions);
    final List<dynamic> jsonData = json.decode(jsonString);
    List<QuestionModel> data = jsonData
        .map((item) => QuestionModel.fromJson(item))
        .toList();
    question = data;
    totalQuestion = question.length;
    return data;
  }

  void submitIndividualResult() {
    result++;
  }

  List<Map<String, dynamic>> makeRank() {
    List<Map<String, dynamic>> sortedList = List.from(allResultsLeaderboard);

    sortedList.sort((a, b) => b['score'].compareTo(a['score']));

    return sortedList;
  }

  void addUser({required String name, required double score}) {
    final index = allResultsLeaderboard.indexWhere(
      (entry) => entry['name'] == name,
    );
    if (index != -1) {
      // Name exists → update score
      allResultsLeaderboard[index]['score'] = score;
    } else {
      // Name does not exist → add new entry
      allResultsLeaderboard.add({"name": name, "score": score});
    }
    makeRank();
  }
}
