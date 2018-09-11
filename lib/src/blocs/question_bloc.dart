import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:bloc_quiz/src/resources/question_api.dart';
import 'package:bloc_quiz/src/models/questionModel.dart';

class QuestionBloc {
  int index = 0;
  QuestionAPI questionAPI = QuestionAPI();
  final _questionListSubject = BehaviorSubject<List<QuestionModel>>();
  final _questionItemSubject = BehaviorSubject<QuestionModel>();
  final _questionCheckSubject = BehaviorSubject<int>();

  //Sink
  Function get questionsAdd => _questionListSubject.sink.add;
  Function get questionItemAdd => _questionItemSubject.sink.add;
  Function get questionCheckAdd => _questionCheckSubject.sink.add;

  //Getter
  Observable<List<QuestionModel>> get questionsStream => _questionListSubject.stream;
  Observable<QuestionModel> get questionItemStream => _questionItemSubject.stream;
  Observable<int> get questionCheckStream => _questionCheckSubject.stream;

  Observable<dynamic> get value =>
      Observable.combineLatest2(questionItemStream, questionCheckStream, (q, x) {
        return q;
      }).asBroadcastStream();

  fetchQuestions() async {
    questionsAdd(await questionAPI.fetchQuestions());
  }

  nextQuestion(int value) {
    _questionListSubject.stream
        .transform(StreamTransformer.fromHandlers(handleData: (questions, sink) {
      if ((index < questions.length - 1)) {
        sink.add(questions[index += value]);
      } else {
        sink.add(QuestionModel());
      }
    })).listen((data) {
      questionItemAdd(data);
    });
  }

  void dispose() {
    _questionListSubject.close();
    _questionItemSubject.close();
    _questionCheckSubject.close();
  }
}
