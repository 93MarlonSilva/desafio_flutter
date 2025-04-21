import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../services/shared_preferences_service.dart';

class ScoreViewModel extends ChangeNotifier {
  int _score = 0;
  int _correctAnswers = 0;
  bool _isLoading = false;
  bool _isNewHighScore = false;

  int get score => _score;
  int get correctAnswers => _correctAnswers;
  bool get isLoading => _isLoading;
  bool get isNewHighScore => _isNewHighScore;

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

  Future<void> checkAndSaveHighScore(int currentScore) async {
    print('=== CHECKING HIGH SCORE ===');
    print('Current score: $currentScore');

    _isLoading = true;
    notifyListeners();

    try {
      final currentHighScore = await SharedPreferencesService.getHighScore();
      print('Current high score: $currentHighScore');

      if (currentScore > currentHighScore) {
        print('New high score detected! Saving...');
        await SharedPreferencesService.setHighScore(currentScore);
        _isNewHighScore = true;
        print('New high score saved: $currentScore');
      } else {
        print(
          'No new high score. Current score: $currentScore, High score: $currentHighScore',
        );
      }
    } catch (e) {
      print('Error checking/saving high score: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
