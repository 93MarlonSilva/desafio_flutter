class QuizModel {
  final int responseCode;
  final List<QuizResult> results;

  QuizModel({
    required this.responseCode,
    required this.results,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      responseCode: json['response_code'] as int,
      results: (json['results'] as List)
          .map((result) => QuizResult.fromJson(result))
          .toList(),
    );
  }
}

class QuizResult {
  final String type;
  final String difficulty;
  final String category;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  QuizResult({
    required this.type,
    required this.difficulty,
    required this.category,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  factory QuizResult.fromJson(Map<String, dynamic> json) {
    return QuizResult(
      type: json['type'] as String,
      difficulty: json['difficulty'] as String,
      category: json['category'] as String,
      question: json['question'] as String,
      correctAnswer: json['correct_answer'] as String,
      incorrectAnswers: (json['incorrect_answers'] as List)
          .map((answer) => answer as String)
          .toList(),
    );
  }
}