import '../models/quiz_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../viewmodels/score_view_model.dart';

class QuizViewModel extends ChangeNotifier {
  QuizModel? _quizData;
  List<String> _userAnswers = [];
  List<QuizResult> _questions = [];
  List<List<String>> _shuffledOptions = [];
  int _currentQuestionIndex = 0;
  bool _isLoading = false;
  List<int> _questionTimes = [];
  int _totalTime = 0;
  bool _isCronRunning = false;
  int? _cachedScore;
  int _quizNumber = 1;

  // Getters
  QuizModel? get quizData => _quizData;

  List<String> get userAnswers => _userAnswers;

  List<QuizResult> get questions => _questions;

  int get currentQuestionIndex => _currentQuestionIndex;

  bool get isQuizComplete => _questions.isEmpty ? false : _currentQuestionIndex >= _questions.length;

  int get score {
    if (_cachedScore == null) {
      print('=== CALCULATING SCORE ===');
      print('Questions length: ${_questions.length}');
      print('User answers: $_userAnswers');

      // Calculate base points per question (100 points divided by number of questions)
      final basePointsPerQuestion = 100 / _questions.length;
      print('Base points per question: $basePointsPerQuestion');

      // Calculate base points (without time penalty)
      final baseScore =
          _userAnswers
              .where(
                (answer) =>
                    answer ==
                    _questions[_userAnswers.indexOf(answer)].correctAnswer,
              )
              .length *
          basePointsPerQuestion;
      print('Base score: $baseScore');

      // Calculate time penalty
      double timePenalty = 0;
      for (var i = 0; i < _questionTimes.length; i++) {
        if (_userAnswers[i].isNotEmpty) {
          // Only apply penalty if the question was answered
          final timeSpent = 60 - _questionTimes[i];
          final penaltyPer10Seconds = 4;
          final penalty = (timeSpent ~/ 10) * penaltyPer10Seconds;
          timePenalty += penalty;
          print('Question $i time penalty: $penalty');
        }
      }
      print('Total time penalty: $timePenalty');

      // Apply penalty and ensure score doesn't go negative
      _cachedScore = (baseScore - timePenalty).clamp(0, 100).round();
      print('Final score: $_cachedScore');
      print('=== SCORE CALCULATION COMPLETED ===');
    }
    return _cachedScore!;
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

  List<String> get currentQuestionOptions =>
      _shuffledOptions[_currentQuestionIndex];

  bool get isLoading => _isLoading;

  List<int> get questionTimes => _questionTimes;
  int get totalTime => _totalTime;

  bool get isCronRunning => _isCronRunning;

  int get quizNumber => _quizNumber;

  // Functions

  // Load the quiz data from the API
  Future<dynamic> onLoadQuizData(
    String? category,
    String? difficulty,
    int? amount,
  ) async {
    if (amount == null || amount <= 0) {
      debugPrint('Invalid amount: $amount');
      return 6; // Invalid parameter error
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
        try {
          final quizModel = QuizModel.fromJson(jsonResponse);

          if (quizModel.results.isNotEmpty) {
            _quizData = quizModel;
            _userAnswers = List.filled(_quizData!.results.length, '');
            _questionTimes = List.filled(_quizData!.results.length, 60);
            setQuestions(_quizData!.results);
            return 0;
          }
        } catch (e) {
          debugPrint('Error converting JSON to QuizModel: $e');
          return 7; // JSON conversion error
        }
      }

      debugPrint(
        'API Error: response_code = ${jsonResponse['response_code']}',
      );
      return jsonResponse['response_code'];
    } catch (e) {
      debugPrint('Error loading quiz data: $e');
      return 8; // API error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setUserAnswer(int index, String answer) {
    if (index >= 0 && index < _userAnswers.length) {
      _userAnswers[index] = answer;
      _cachedScore = null; // Reset cached score when answer changes
      notifyListeners();
    }
  }

  void setQuestions(List<QuizResult> questions) {
    print('Setting new questions: ${questions.length}');
    _questions = questions;
    _userAnswers = List.generate(questions.length, (index) => '');
    _questionTimes = List.generate(questions.length, (index) => 60);
    _isCronRunning = true;
    print('Questions set complete');
    _shuffledOptions =
        questions.map((question) {
          final options = [...question.incorrectAnswers];
          options.add(question.correctAnswer);
          options.shuffle();
          return options;
        }).toList();
    notifyListeners();
  }

  void nextQuestion(BuildContext context) {
    if (_currentQuestionIndex < _questions.length - 1) {
      if (_questionTimes.isNotEmpty &&
          _currentQuestionIndex < _questionTimes.length) {
        final currentTime = _questionTimes[_currentQuestionIndex];
        debugPrint(
          'Saving final time for question $_currentQuestionIndex: $currentTime seconds',
        );
      }
      _currentQuestionIndex++;
      notifyListeners();
    } else {
      if (_questionTimes.isNotEmpty &&
          _currentQuestionIndex < _questionTimes.length) {
        final currentTime = _questionTimes[_currentQuestionIndex];
        debugPrint(
          'Saving final time for last question: $currentTime seconds',
        );
      }
      calculateTotalTime();

      final finalScore = score;
      print('=== FINAL SCORE CALCULATED ===');
      print('Score: $finalScore');
      print('Total Time: $_totalTime');
      print('Correct Answers: $correctAnswers');
      print('Wrong Answers: $wrongAnswers');

      // Save high score
      final scoreViewModel = context.read<ScoreViewModel>();
      scoreViewModel.checkAndSaveHighScore(finalScore).then((_) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/score',
            (route) => false,
          );
        });
      });
    }
  }

  void startNewQuestion() {
    if (_questionTimes.length <= _currentQuestionIndex) {
      _questionTimes.add(60);
      debugPrint(
        'New timer started for question $_currentQuestionIndex: 60 seconds',
      );
    } else {
      _questionTimes[_currentQuestionIndex] = 60;
      debugPrint(
        'Timer reset for question $_currentQuestionIndex: 60 seconds',
      );
    }
    notifyListeners();
  }

  void updateQuestionTime(int time) {
    if (_questionTimes.isNotEmpty &&
        _currentQuestionIndex < _questionTimes.length) {
      _questionTimes[_currentQuestionIndex] = time;
      debugPrint(
        'Time updated for question $_currentQuestionIndex: $time seconds',
      );
      notifyListeners();
    }
  }

  // Calculate total time spent on all questions
  void calculateTotalTime() {
    debugPrint('Question times: $_questionTimes');
    _totalTime = _questionTimes.fold(0, (sum, time) {
      final timeSpent = time == 60 ? 0 : 60 - time;
      debugPrint('Time spent on this question: $timeSpent seconds');
      return sum + timeSpent;
    });
    debugPrint('Total time spent: $_totalTime seconds');
    notifyListeners();
  }

  // If the user has answered the question or the timer has run out, the user can proceed to the next question
  bool get canProceed {
    return _userAnswers[_currentQuestionIndex].isNotEmpty ||
        (_questionTimes.isNotEmpty &&
            _currentQuestionIndex < _questionTimes.length &&
            _questionTimes[_currentQuestionIndex] == 0);
  }

  // Stop the timer for the current question
  void stopCron() {
    _isCronRunning = false;
    notifyListeners();
  }

  // Start the timer for the current question
  void startCron() {
    _isCronRunning = true;
    notifyListeners();
  }

  void resetQuizForRetry() {
    _currentQuestionIndex = 0;
    _userAnswers = List.filled(_questions.length, '');
    _questionTimes = List.filled(_questions.length, 60);
    _totalTime = 0;
    _isCronRunning = true;
    _cachedScore = null;
    notifyListeners();
  }

  // Reset the quiz state
  void resetQuiz() {
    _quizData = null;
    _userAnswers = [];
    _questions = [];
    _shuffledOptions = [];
    _currentQuestionIndex = 0;
    _isLoading = false;
    _questionTimes = [];
    _totalTime = 0;
    _isCronRunning = false;
    _cachedScore = null;
    notifyListeners();
  }

  void setQuizNumber(int number) {
    _quizNumber = number;
    notifyListeners();
  }
}
