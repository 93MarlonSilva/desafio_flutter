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
    debugPrint('=== CHECKING HIGH SCORE ===');
    debugPrint('Current score: $currentScore');

    _isLoading = true;
    notifyListeners();

    try {
      final currentHighScore = await SharedPreferencesService.getHighScore();
      debugPrint('Current high score: $currentHighScore');

      if (currentScore > currentHighScore) {
        debugPrint('New high score detected! Saving...');
        await SharedPreferencesService.setHighScore(currentScore);
        _isNewHighScore = true;
        debugPrint('New high score saved: $currentScore');
      } else {
        debugPrint(
          'No new high score. Current score: $currentScore, High score: $currentHighScore',
        );
      }
    } catch (e) {
      debugPrint('Error checking/saving high score: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
