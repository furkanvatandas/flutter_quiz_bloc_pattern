import 'package:bloc_quiz/src/blocs/question_bloc.dart';
import 'package:flutter/material.dart';

class QuestionProvider extends InheritedWidget {
  final QuestionBloc questionBloc;

  QuestionProvider({Key key, Widget child})
      : questionBloc = QuestionBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static QuestionBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(QuestionProvider) as QuestionProvider)
        .questionBloc;
  }
}
