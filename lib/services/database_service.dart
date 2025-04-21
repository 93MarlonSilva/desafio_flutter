import 'package:hive/hive.dart';
import '../models/quiz_history_model.dart';

class DatabaseService {
  static const String _quizHistoryBox = 'quizHistory';

  Future<List<QuizHistoryModel>> getQuizHistory() async {
    final box = Hive.box<QuizHistoryModel>(_quizHistoryBox);
    return box.values.toList()..sort((a, b) => b.date.compareTo(a.date));
  }

  Future<void> saveQuizHistory(QuizHistoryModel quiz) async {
    final box = Hive.box<QuizHistoryModel>(_quizHistoryBox);
    await box.add(quiz);
  }
}