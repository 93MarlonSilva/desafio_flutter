class QuizHistoryModel {
  final DateTime date;
  final Duration totalTime;
  final int score;
  final int correctAnswers;
  final int wrongAnswers;

  QuizHistoryModel({
    required this.date,
    required this.totalTime,
    required this.score,
    required this.correctAnswers,
    required this.wrongAnswers,
  });

  // Convert to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'totalTime': totalTime.inSeconds,
      'score': score,
      'correctAnswers': correctAnswers,
      'wrongAnswers': wrongAnswers,
    };
  }

  // Create from Map
  factory QuizHistoryModel.fromMap(Map<String, dynamic> map) {
    return QuizHistoryModel(
      date: DateTime.parse(map['date']),
      totalTime: Duration(seconds: map['totalTime']),
      score: map['score'],
      correctAnswers: map['correctAnswers'],
      wrongAnswers: map['wrongAnswers'],
    );
  }
}
