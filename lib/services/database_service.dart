import 'package:quizchallenge/database/app_database.dart' as db;

import '../database/app_database.dart';
import '../models/quiz_history_model.dart';
import 'package:drift/drift.dart';

class DatabaseService {
  final AppDatabase _database;

  DatabaseService(this._database) {
    print('DatabaseService initialized');
  }

  Future<void> saveQuizHistory(QuizHistoryModel quiz) async {
    print('=== SAVING QUIZ TO DATABASE ===');
    print('Quiz data:');
    print('- Date: ${quiz.date}');
    print('- Total Time: ${quiz.totalTime}');
    print('- Score: ${quiz.score}');
    print('- Correct Answers: ${quiz.correctAnswers}');
    print('- Wrong Answers: ${quiz.wrongAnswers}');

    try {
      print('Creating database companion');
      final companion = db.QuizHistoryTableCompanion.insert(
        date: quiz.date,
        totalTime: quiz.totalTime,
        score: quiz.score,
        correctAnswers: quiz.correctAnswers,
        wrongAnswers: quiz.wrongAnswers,
      );

      print('Inserting record with data:');
      print('- Date: ${companion.date.value}');
      print('- Total Time: ${companion.totalTime.value}');
      print('- Score: ${companion.score.value}');
      print('- Correct Answers: ${companion.correctAnswers.value}');
      print('- Wrong Answers: ${companion.wrongAnswers.value}');

      print('Executing database insert');
      await _database.into(_database.quizHistoryTable).insert(companion);
      print('Quiz saved to database successfully');

      // Verificar se o registro foi salvo
      print('Verifying saved record');
      final query =
          _database.select(_database.quizHistoryTable)
            ..orderBy([
              (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
            ])
            ..limit(1);
      final savedRecord = await query.getSingle();
      print('Last saved record:');
      print('- ID: ${savedRecord.id}');
      print('- Date: ${savedRecord.date}');
      print('- Score: ${savedRecord.score}');
      print('- Total Time: ${savedRecord.totalTime}');
      print('- Correct Answers: ${savedRecord.correctAnswers}');
      print('- Wrong Answers: ${savedRecord.wrongAnswers}');
      print('=== SAVE VERIFICATION COMPLETED ===');
    } catch (e, stackTrace) {
      print('Error saving quiz history: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<List<QuizHistoryModel>> getQuizHistory() async {
    print('=== GETTING QUIZ HISTORY FROM DATABASE ===');
    try {
      print('Creating database query');
      final query = _database.select(_database.quizHistoryTable)..orderBy([
        (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
      ]);

      print('Executing database query');
      final results = await query.get();
      print('Raw database results:');
      for (var row in results) {
        print('- ID: ${row.id}');
        print('  Date: ${row.date}');
        print('  Score: ${row.score}');
        print('  Total Time: ${row.totalTime}');
        print('  Correct Answers: ${row.correctAnswers}');
        print('  Wrong Answers: ${row.wrongAnswers}');
      }

      print('Mapping results to QuizHistoryModel');
      final mappedResults =
          results
              .map(
                (row) => QuizHistoryModel(
                  date: row.date,
                  totalTime: row.totalTime,
                  score: row.score,
                  correctAnswers: row.correctAnswers,
                  wrongAnswers: row.wrongAnswers,
                ),
              )
              .toList();

      print('Mapped ${mappedResults.length} records to QuizHistoryModel');
      print('=== DATABASE QUERY COMPLETED ===');

      return mappedResults;
    } catch (e, stackTrace) {
      print('Error getting quiz history: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }
}
