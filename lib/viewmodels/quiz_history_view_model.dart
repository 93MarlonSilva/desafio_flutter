import 'package:flutter/material.dart';
import '../models/quiz_history_model.dart';
import '../services/shared_preferences_service.dart';
import '../services/database_service.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class QuizHistoryViewModel extends ChangeNotifier {
  final List<QuizHistoryModel> _quizHistory = [];
  bool _isLoading = false;
  int _highScore = 0;
  final DatabaseService _databaseService;
  bool _isInitialized = false;

  QuizHistoryViewModel(this._databaseService) {
    debugPrint('QuizHistoryViewModel initialized');
  }

  List<QuizHistoryModel> get quizHistory => _quizHistory;
  bool get isLoading => _isLoading;
  int get highestScore => _highScore;
  bool get isInitialized => _isInitialized;

  Future<void> loadQuizHistory() async {
    try {
      debugPrint('=== LOADING QUIZ HISTORY ===');
      _isLoading = true;
      _isInitialized = false;
      notifyListeners();

      _quizHistory.clear();
      _highScore = await SharedPreferencesService.getHighScore();
      debugPrint('Current high score: $_highScore');

      final history = await _databaseService.getQuizHistory();
      debugPrint('Retrieved ${history.length} records from database');

      _quizHistory.addAll(history);
      _quizHistory.sort((a, b) => b.date.compareTo(a.date));

      debugPrint('Loaded ${_quizHistory.length} quiz history records');
      for (var quiz in _quizHistory) {
        debugPrint('- Date: ${quiz.date}');
        debugPrint('  Score: ${quiz.score}');
        debugPrint('  Total Time: ${quiz.totalTime}');
        debugPrint('  Correct Answers: ${quiz.correctAnswers}');
        debugPrint('  Wrong Answers: ${quiz.wrongAnswers}');
      }
      debugPrint('=== QUIZ HISTORY LOADED ===');
    } catch (e) {
      debugPrint('Error loading quiz history: $e');
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
    try {
      debugPrint('=== ADDING QUIZ TO HISTORY ===');
      debugPrint('Quiz to add:');
      debugPrint('- Date: ${quiz.date}');
      debugPrint('- Total Time: ${quiz.totalTime}');
      debugPrint('- Score: ${quiz.score}');
      debugPrint('- Correct Answers: ${quiz.correctAnswers}');
      debugPrint('- Wrong Answers: ${quiz.wrongAnswers}');

      await _databaseService.saveQuizHistory(quiz);
      await loadQuizHistory();
      debugPrint('=== QUIZ ADDED TO HISTORY ===');
    } catch (e) {
      debugPrint('Error adding quiz to history: $e');
      rethrow;
    }
  }

  Future<void> clearHistory() async {
    try {
      debugPrint('=== CLEARING QUIZ HISTORY ===');
      _isLoading = true;
      notifyListeners();

      final box = await Hive.openBox<QuizHistoryModel>('quizHistory');
      await box.clear();
      _quizHistory.clear();
      debugPrint('=== QUIZ HISTORY CLEARED ===');
    } catch (e) {
      debugPrint('Error clearing quiz history: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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
