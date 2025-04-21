import 'package:hive/hive.dart';

part 'quiz_history_model.g.dart';

@HiveType(typeId: 0)
class QuizHistoryModel {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final int totalTime;

  @HiveField(2)
  final int score;

  @HiveField(3)
  final int correctAnswers;

  @HiveField(4)
  final int wrongAnswers;

  QuizHistoryModel({
    required this.date,
    required this.totalTime,
    required this.score,
    required this.correctAnswers,
    required this.wrongAnswers,
  });

  // Convert to Map for storage (maintained for compatibility)
  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'totalTime': totalTime,
      'score': score,
      'correctAnswers': correctAnswers,
      'wrongAnswers': wrongAnswers,
    };
  }

  // Create from Map (maintained for compatibility)
  // Create from Map (mantido para compatibilidade)
  factory QuizHistoryModel.fromMap(Map<String, dynamic> map) {
    return QuizHistoryModel(
      date: DateTime.parse(map['date']),
      totalTime: map['totalTime'],
      score: map['score'],
      correctAnswers: map['correctAnswers'],
      wrongAnswers: map['wrongAnswers'],
    );
  }
}