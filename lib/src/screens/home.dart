import 'package:flutter/material.dart';
import 'package:bloc_quiz/src/blocs/question_provider.dart';
import 'package:bloc_quiz/src/models/questionModel.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final questionBloc = QuestionProvider.of(context);
    return Scaffold(
      body: ListView(
        children: <Widget>[
          StreamBuilder(
              stream: questionBloc.value,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading...");
                }
                if (snapshot.data.id == -1) {
                  return Text("Test Done...");
                }
                return Column(children: <Widget>[
                  Text(snapshot.data.question),
                  RaisedButton(
                    child: Text(snapshot.data.answerA),
                    onPressed: () {
                      if (snapshot.data.answerA == snapshot.data.answerCorrect) {
                        questionBloc.questionCheckAdd(3);
                      }
                    },
                  ),
                  RaisedButton(
                    child: Text(snapshot.data.answerB),
                    onPressed: () {
                      if (snapshot.data.answerB == snapshot.data.answerCorrect) {
                        questionBloc.questionCheckAdd(3);
                      }
                    },
                  ),
                  RaisedButton(
                    child: Text(snapshot.data.answerC),
                    onPressed: () {
                      if (snapshot.data.answerC == snapshot.data.answerCorrect) {
                        questionBloc.questionCheckAdd(3);
                      }
                    },
                  ),
                  RaisedButton(
                    child: Text(snapshot.data.answerD),
                    onPressed: () {
                      if (snapshot.data.answerD == snapshot.data.answerCorrect) {
                        questionBloc.questionCheckAdd(3);
                      }
                    },
                  ),
                  snapshot.data.id == 1
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                              child: Text("<"),
                              onPressed: null,
                            ),
                            RaisedButton(
                                child: Text(">"),
                                onPressed: () {
                                  questionBloc.nextQuestion(1);
                                  questionBloc.questionCheckAdd(3);
                                })
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                                child: Text("<"),
                                onPressed: () {
                                  questionBloc.nextQuestion(-1);
                                }),
                            RaisedButton(
                                child: Text(">"),
                                onPressed: () {
                                  questionBloc.nextQuestion(1);
                                  questionBloc.questionCheckAdd(3);
                                })
                          ],
                        )
                ]);
              }),
          StreamBuilder(
              stream: questionBloc.value,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading...");
                }
                return Text("data ${snapshot.data.answerCorrect}");
              })
        ],
      ),
    );
  }
}
