import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:quizchallenge/common/routes.dart';
import 'package:quizchallenge/models/quiz_history_model.dart';
import 'package:quizchallenge/viewmodels/quiz_history_view_model.dart';
import 'package:quizchallenge/viewmodels/quiz_view_model.dart';
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
    _isLoading = true;
    notifyListeners();

    try {
      final currentHighScore = await SharedPreferencesService.getHighScore();

      if (currentScore > currentHighScore) {
        await SharedPreferencesService.setHighScore(currentScore);
        _isNewHighScore = true;
      }
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveQuizAndNavigate(BuildContext context) async {
    final quizViewModel = context.read<QuizViewModel>();
    final historyViewModel = context.read<QuizHistoryViewModel>();

    try {
      final quizHistory = QuizHistoryModel(
        date: DateTime.now(),
        totalTime: quizViewModel.totalTime,
        score: quizViewModel.score,
        correctAnswers: quizViewModel.correctAnswers,
        wrongAnswers: quizViewModel.wrongAnswers,
      );

      if (!Hive.isBoxOpen('quizHistory')) {
        await Hive.openBox<QuizHistoryModel>('quizHistory');
      }
      await historyViewModel.addQuizToHistory(quizHistory);

      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.home,
          (route) => false,
        ).then((_) {
          quizViewModel.resetQuiz();
          quizViewModel.setQuestions([]);
        });
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving quiz history: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
