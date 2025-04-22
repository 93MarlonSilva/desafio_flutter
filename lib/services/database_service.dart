import 'package:hive/hive.dart';
import '../models/quiz_history_model.dart';
import 'package:flutter/foundation.dart';

class DatabaseService {
  static const String _quizHistoryBox = 'quizHistory';

  Future<List<QuizHistoryModel>> getQuizHistory() async {
    try {
      debugPrint('=== GETTING QUIZ HISTORY ===');
      final box = Hive.box<QuizHistoryModel>(_quizHistoryBox);
      final history = box.values.toList();
      debugPrint('Retrieved ${history.length} records from database');
      history.sort((a, b) => b.date.compareTo(a.date));
      return history;
    } catch (e) {
      debugPrint('Error getting quiz history: $e');
      return [];
    }
  }

  Future<void> saveQuizHistory(QuizHistoryModel quiz) async {
    try {
      debugPrint('=== SAVING QUIZ TO DATABASE ===');
      debugPrint('Quiz data to save:');
      debugPrint('- Date: ${quiz.date}');
      debugPrint('- Total Time: ${quiz.totalTime}');
      debugPrint('- Score: ${quiz.score}');
      debugPrint('- Correct Answers: ${quiz.correctAnswers}');
      debugPrint('- Wrong Answers: ${quiz.wrongAnswers}');

      final box = Hive.box<QuizHistoryModel>(_quizHistoryBox);
      final currentHistory = box.values.toList();
      debugPrint('Current history size before save: ${currentHistory.length}');

      // Verifica se já existe um quiz com a mesma data
      final existingQuiz = currentHistory.firstWhere(
        (q) => q.date.isAtSameMomentAs(quiz.date),
        orElse: () => QuizHistoryModel(
          date: DateTime(0),
          totalTime: 0,
          score: 0,
          correctAnswers: 0,
          wrongAnswers: 0,
        ),
      );

      if (existingQuiz.date.year != 0) {
        debugPrint('Found existing quiz with same date, updating...');
        final index = currentHistory.indexOf(existingQuiz);
        await box.putAt(index, quiz);
      } else {
        debugPrint('No existing quiz found with same date, adding new...');
        await box.add(quiz);
      }

      final updatedHistory = box.values.toList();
      debugPrint('History size after save: ${updatedHistory.length}');
      debugPrint('=== QUIZ SAVED SUCCESSFULLY ===');
    } catch (e) {
      debugPrint('Error saving quiz history: $e');
      rethrow;
    }
  }
}
