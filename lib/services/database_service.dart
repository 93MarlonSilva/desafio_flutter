import 'package:hive/hive.dart';
import '../models/quiz_history_model.dart';

class DatabaseService {
  static const String _quizHistoryBox = 'quizHistory';

  Future<List<QuizHistoryModel>> getQuizHistory() async {
    try {
      final box = Hive.box<QuizHistoryModel>(_quizHistoryBox);
      final history = box.values.toList();
      history.sort((a, b) => b.date.compareTo(a.date));
      return history;
    } catch (e) {
      return [];
    }
  }

  Future<void> saveQuizHistory(QuizHistoryModel quiz) async {
    try {
      final box = Hive.box<QuizHistoryModel>(_quizHistoryBox);
      final currentHistory = box.values.toList();

      // Verify if the quiz already exists in the history
      final existingQuiz = currentHistory.firstWhere(
        (q) => q.date.isAtSameMomentAs(quiz.date),
        orElse:
            () => QuizHistoryModel(
              date: DateTime(0),
              totalTime: 0,
              score: 0,
              correctAnswers: 0,
              wrongAnswers: 0,
            ),
      );

      if (existingQuiz.date.year != 0) {
        final index = currentHistory.indexOf(existingQuiz);
        await box.putAt(index, quiz);
      } else {
        await box.add(quiz);
      }
    } catch (e) {
      rethrow;
    }
  }
}
