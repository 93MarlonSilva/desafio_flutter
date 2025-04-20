import 'package:flutter/material.dart';
import '../models/quiz_history_model.dart';

class QuizHistoryViewModel extends ChangeNotifier {
  final List<QuizHistoryModel> _quizHistory = [];
  bool _isLoading = false;

  List<QuizHistoryModel> get quizHistory => _quizHistory;
  bool get isLoading => _isLoading;

  // Get highest score
  int get highestScore {
    if (_quizHistory.isEmpty) return 0;
    return _quizHistory
        .map((quiz) => quiz.score)
        .reduce((a, b) => a > b ? a : b);
  }

  void addQuizToHistory(QuizHistoryModel quiz) {
    _quizHistory.add(quiz);
    _quizHistory.sort(
      (a, b) => b.date.compareTo(a.date),
    ); // Sort by date, newest first
    notifyListeners();
  }

  Future<void> loadHistory() async {
    _isLoading = true;
    notifyListeners();

    try {
      // TODO: Load from storage
      // For now, we'll just simulate loading
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      debugPrint('Error loading history: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Clear history
  void clearHistory() {
    _quizHistory.clear();
    notifyListeners();
  }

  // Format time as MM:SS
  String formatTime(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // Format date as DD/MM/YYYY
  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
