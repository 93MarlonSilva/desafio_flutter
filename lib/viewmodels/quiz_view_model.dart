import '../models/quiz_model.dart';
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class QuizViewModel extends ChangeNotifier {
  QuizModel? _quizData;
  List<String> _userAnswers = [];
  List<QuizResult> _questions = [];
  List<List<String>> _shuffledOptions = [];
  int _currentQuestionIndex = 0;
  bool _isLoading = false;
  List<int> _questionTimes = [];
  int _totalTime = 0;

  // Getters
  QuizModel? get quizData => _quizData;

  List<String> get userAnswers => _userAnswers;

  List<QuizResult> get questions => _questions;

  int get currentQuestionIndex => _currentQuestionIndex;

  bool get isQuizComplete => _currentQuestionIndex >= _questions.length;

  int get score {
    // Calcula o valor base de cada acerto (100 pontos divididos pelo número de questões)
    final basePointsPerQuestion = 100 / _questions.length;
    
    // Calcula os pontos base (sem penalidade de tempo)
    final baseScore = _userAnswers
        .where(
          (answer) =>
              answer ==
              _questions[_userAnswers.indexOf(answer)].correctAnswer,
        )
        .length * basePointsPerQuestion;

    // Calcula a penalidade de tempo
    double timePenalty = 0;
    for (var i = 0; i < _questionTimes.length; i++) {
      if (_userAnswers[i].isNotEmpty) { // Só aplica penalidade se a pergunta foi respondida
        final timeSpent = 60 - _questionTimes[i];
        final penaltyPer10Seconds = 4;
        final penalty = (timeSpent ~/ 10) * penaltyPer10Seconds;
        timePenalty += penalty;
      }
    }

    // Aplica a penalidade e garante que o score não fique negativo
    final finalScore = (baseScore - timePenalty).clamp(0, 100).round();
    
    debugPrint('Score calculado:');
    debugPrint('Pontos base: $baseScore');
    debugPrint('Penalidade de tempo: $timePenalty');
    debugPrint('Score final: $finalScore');
    
    return finalScore;
  }

  int get correctAnswers =>
      _userAnswers
          .where(
            (answer) =>
                answer ==
                _questions[_userAnswers.indexOf(answer)].correctAnswer,
          )
          .length;

  int get wrongAnswers => _userAnswers.length - correctAnswers;

  List<QuizResult> get quizResults => _questions;

  QuizResult get currentQuestion => _questions[_currentQuestionIndex];

  List<String> get currentQuestionOptions => _shuffledOptions[_currentQuestionIndex];

  bool get isLoading => _isLoading;

  List<int> get questionTimes => _questionTimes;
  int get totalTime => _totalTime;

  // Functions
  Future<bool> onLoadQuizData(
    String? category,
    String? difficulty,
    int? amount,
  ) async {
    if (amount == null || amount <= 0) {
      debugPrint('Invalid amount: $amount');
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final jsonResponse = await ApiService.getQuizData(
        category: category,
        difficulty: difficulty,
        amount: amount,
      );

      if (jsonResponse['response_code'] == 0 &&
          jsonResponse['results'] != null) {
        final quizModel = QuizModel.fromJson(jsonResponse);

        if (quizModel.results.isNotEmpty) {
          _quizData = quizModel;
          _userAnswers = List.filled(_quizData!.results.length, '');
          _questionTimes = List.filled(_quizData!.results.length, 60);
          setQuestions(_quizData!.results);
          return true;
        }
      }

      debugPrint(
        'Erro na API: response_code = ${jsonResponse['response_code']}',
      );
      return false;
    } catch (e) {
      debugPrint('Erro ao carregar os dados do quiz: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setUserAnswer(int index, String answer) {
    if (index >= 0 && index < _userAnswers.length) {
      _userAnswers[index] = answer;
      notifyListeners();
    }
  }

  void setQuestions(List<QuizResult> questions) {
    _questions = questions;
    _shuffledOptions = questions.map((question) {
      final options = [...question.incorrectAnswers];
      options.add(question.correctAnswer);
      options.shuffle();
      return options;
    }).toList();
    notifyListeners();
  }

  void nextQuestion(BuildContext context) {
    if (_currentQuestionIndex < _questions.length - 1) {
      if (_questionTimes.isNotEmpty && _currentQuestionIndex < _questionTimes.length) {
        final currentTime = _questionTimes[_currentQuestionIndex];
        debugPrint('Salvando tempo final da pergunta $_currentQuestionIndex: $currentTime segundos');
      }
      _currentQuestionIndex++;
      notifyListeners();
    } else {
      if (_questionTimes.isNotEmpty && _currentQuestionIndex < _questionTimes.length) {
        final currentTime = _questionTimes[_currentQuestionIndex];
        debugPrint('Salvando tempo final da última pergunta: $currentTime segundos');
      }
      calculateTotalTime();
      Navigator.pushNamed(context, '/score');
    }
  }

  void startNewQuestion() {
    if (_questionTimes.length <= _currentQuestionIndex) {
      _questionTimes.add(60);
      debugPrint('Novo timer iniciado para pergunta $_currentQuestionIndex: 60 segundos');
    } else {
      _questionTimes[_currentQuestionIndex] = 60;
      debugPrint('Timer resetado para pergunta $_currentQuestionIndex: 60 segundos');
    }
    notifyListeners();
  }

  void updateQuestionTime(int time) {
    if (_questionTimes.isNotEmpty && _currentQuestionIndex < _questionTimes.length) {
      _questionTimes[_currentQuestionIndex] = time;
      debugPrint('Tempo atualizado para pergunta $_currentQuestionIndex: $time segundos');
      notifyListeners();
    }
  }

  void calculateTotalTime() {
    debugPrint('Tempos das perguntas: $_questionTimes');
    _totalTime = _questionTimes.fold(0, (sum, time) {
      final timeSpent = time == 60 ? 0 : 60 - time;
      debugPrint('Tempo gasto nesta pergunta: $timeSpent segundos');
      return sum + timeSpent;
    });
    debugPrint('Tempo total calculado: $_totalTime segundos');
    notifyListeners();
  }

  bool get canProceed {
    return _userAnswers[_currentQuestionIndex].isNotEmpty || 
           (_questionTimes.isNotEmpty && 
            _currentQuestionIndex < _questionTimes.length && 
            _questionTimes[_currentQuestionIndex] == 0);
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _userAnswers = List.filled(_questions.length, '');
    _questionTimes = List.filled(_questions.length, 60);
    _totalTime = 0;
    notifyListeners();
  }
}
