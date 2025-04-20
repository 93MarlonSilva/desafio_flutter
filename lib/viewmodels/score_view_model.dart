import 'package:flutter/foundation.dart';

class ScoreViewModel extends ChangeNotifier {
  int _score = 0;
  int _correctAnswers = 0;

  int get score => _score;
  int get correctAnswers => _correctAnswers;

  void setScore(int score) {
    _score = score;
    notifyListeners();
  }

  void setCorrectAnswers(int correctAnswers) {
    _correctAnswers = correctAnswers;
    notifyListeners();
  }

  void updateScore(int score, int correctAnswers) {
    _score = score;
    _correctAnswers = correctAnswers;
    notifyListeners();
  }
}
