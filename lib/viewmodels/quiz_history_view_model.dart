import 'package:flutter/material.dart';
import '../models/quiz_history_model.dart';
import '../services/shared_preferences_service.dart';
import '../services/database_service.dart';

class QuizHistoryViewModel extends ChangeNotifier {
  final List<QuizHistoryModel> _quizHistory = [];
  bool _isLoading = false;
  int _highScore = 0;
  final DatabaseService _databaseService;
  bool _isInitialized = false;

  QuizHistoryViewModel(this._databaseService) {
    print('QuizHistoryViewModel initialized');
  }

  List<QuizHistoryModel> get quizHistory => _quizHistory;
  bool get isLoading => _isLoading;
  int get highestScore => _highScore;
  bool get isInitialized => _isInitialized;

  Future<void> loadQuizHistory() async {
    print('Loading quiz history');
    _isLoading = true;
    _isInitialized = false;
    notifyListeners();

    try {
      _quizHistory.clear();
      _highScore = await SharedPreferencesService.getHighScore();
      print('Current high score: $_highScore');

      final history = await _databaseService.getQuizHistory();
      print('Retrieved ${history.length} records from database');

      _quizHistory.addAll(history);
      _quizHistory.sort((a, b) => b.date.compareTo(a.date));

      print('Loaded ${_quizHistory.length} quiz history records');
      for (var quiz in _quizHistory) {
        print('- Date: ${quiz.date}');
        print('  Score: ${quiz.score}');
        print('  Total Time: ${quiz.totalTime}');
        print('  Correct Answers: ${quiz.correctAnswers}');
        print('  Wrong Answers: ${quiz.wrongAnswers}');
      }
    } catch (e) {
      print('Error loading quiz history: $e');
      rethrow;
    } finally {
      _isLoading = false;
      _isInitialized = true;
      notifyListeners();
    }
  }

  void resetState() {
    _quizHistory.clear();
    _isLoading = false;
    _isInitialized = false;
    notifyListeners();
  }

  Future<void> addQuizToHistory(QuizHistoryModel quiz) async {
    print('=== ADDING QUIZ TO HISTORY ===');
    print('Quiz data:');
    print('- Date: ${quiz.date}');
    print('- Score: ${quiz.score}');
    print('- Total Time: ${quiz.totalTime}');
    print('- Correct Answers: ${quiz.correctAnswers}');
    print('- Wrong Answers: ${quiz.wrongAnswers}');

    try {
      print('Calling database service to save quiz');
      await _databaseService.saveQuizHistory(quiz);
      print('Quiz saved to database successfully');

      print('Reloading quiz history');
      await loadQuizHistory();
      print('Quiz history reloaded');
      print('=== QUIZ ADDED TO HISTORY COMPLETED ===');
    } catch (e, stackTrace) {
      print('Error adding quiz to history: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }

  // Clear history
  void clearHistory() {
    _quizHistory.clear();
    notifyListeners();
  }

  // Format time as MM:SS
  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  // Format date as DD/MM/YYYY
  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
