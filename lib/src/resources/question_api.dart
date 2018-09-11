import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:bloc_quiz/src/models/questionModel.dart';

class QuestionAPI {
  Future<List<QuestionModel>> fetchQuestions() async {
    List<QuestionModel> questionsList = [];
    final questionJson = await rootBundle.loadString('assets/questions.json');
    final questions = json.decode(questionJson);
    questions.forEach((v) => questionsList.add(QuestionModel.fromJson(v)));
    return questionsList;
  }
}
