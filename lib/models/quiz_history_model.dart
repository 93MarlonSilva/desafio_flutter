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
  factory QuizHistoryModel.fromMap(Map<String, dynamic> map) {
    return QuizHistoryModel(
      date: DateTime.parse(map['date']),
      totalTime: map['totalTime'] is int ? map['totalTime'] : int.parse(map['totalTime'].toString()),
      score: map['score'] is int ? map['score'] : int.parse(map['score'].toString()),
      correctAnswers: map['correctAnswers'] is int ? map['correctAnswers'] : int.parse(map['correctAnswers'].toString()),
      wrongAnswers: map['wrongAnswers'] is int ? map['wrongAnswers'] : int.parse(map['wrongAnswers'].toString()),
    );
  }
}
