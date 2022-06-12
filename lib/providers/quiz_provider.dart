import 'package:flutter/material.dart';
import 'package:user/models/question.dart';
import 'package:user/models/quiz_user.dart';
import 'package:user/services/quiz_service.dart';

class QuizProvider extends ChangeNotifier {
  int totalTime = 0;
  List<Question> questions = [];
  List<QuizUser> users = [];

  QuizProvider() {
    QuizService.getAllQuestions().then((value) {
      questions = value;
      notifyListeners();
    });

    QuizService.getTotalTime().then((value) {
      totalTime = value;
      notifyListeners();
    });
  }

  Future<void> getAllUsers() async {
    users = await QuizService.getAllUsers();
    notifyListeners();
  }

  Future<void> updateNoti(String title, String body) async {
    await QuizService.updateNoti(title, body);
  }

  Future<void> updateHighscore(int currentScore, List<int> listscore) async {
    await QuizService.updateHighscore(currentScore, listscore);
  }
}
