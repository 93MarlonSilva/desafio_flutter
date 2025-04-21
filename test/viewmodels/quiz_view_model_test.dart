import 'package:flutter_test/flutter_test.dart';
import 'package:quizchallenge/viewmodels/quiz_view_model.dart';
import 'package:quizchallenge/models/quiz_model.dart';
import 'package:flutter/material.dart';

class MockBuildContext extends BuildContext {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('QuizViewModel Tests', () {
    late QuizViewModel viewModel;
    late List<QuizResult> mockQuestions;
    late BuildContext mockContext;

    setUp(() {
      viewModel = QuizViewModel();
      mockQuestions = [
        QuizResult(
          type: 'multiple',
          difficulty: 'easy',
          category: 'Books',
          question: 'What is the capital of France?',
          correctAnswer: 'Paris',
          incorrectAnswers: ['London', 'Berlin', 'Madrid'],
        ),
        QuizResult(
          type: 'multiple',
          difficulty: 'easy',
          category: 'Books',
          question: 'What is 2+2?',
          correctAnswer: '4',
          incorrectAnswers: ['3', '5', '6'],
        ),
      ];
      mockContext = MockBuildContext();
    });

    test('Initial state should be empty', () {
      print('Initial state test:');
      print('Questions length: ${viewModel.questions.length}');
      print('User answers length: ${viewModel.userAnswers.length}');
      print('Questions: ${viewModel.questions}');
      print('User answers: ${viewModel.userAnswers}');
      
      expect(viewModel.questions, isEmpty);
      expect(viewModel.userAnswers, isEmpty);
      expect(viewModel.currentQuestionIndex, equals(0));
      expect(viewModel.isQuizComplete, isFalse);
    });

    test('Setting questions should initialize state', () async {
      viewModel.resetQuiz();
      expect(viewModel.isCronRunning, isFalse);
      
      viewModel.setQuestions(mockQuestions);
      await Future.delayed(Duration.zero);
      
      expect(viewModel.questions.length, equals(2));
      expect(viewModel.userAnswers.length, equals(2));
      expect(viewModel.userAnswers[0], isEmpty);
      expect(viewModel.userAnswers[1], isEmpty);
      expect(viewModel.isCronRunning, isTrue);
    });

    test('Setting user answer should update state', () {
      viewModel.setQuestions(mockQuestions);
      viewModel.setUserAnswer(0, 'Paris');
      expect(viewModel.userAnswers[0], equals('Paris'));
      expect(viewModel.userAnswers[1], isEmpty);
    });

    test('Score calculation should work correctly', () {
      viewModel.setQuestions(mockQuestions);
      viewModel.setUserAnswer(0, 'Paris'); // Correct
      viewModel.setUserAnswer(1, '3'); // Wrong
      
      // Base score should be 50 (100/2 questions, 1 correct)
      expect(viewModel.score, equals(50));
    });

    test('Next question should advance index', () {
      viewModel.setQuestions(mockQuestions);
      expect(viewModel.currentQuestionIndex, equals(0));
      viewModel.nextQuestion(mockContext);
      expect(viewModel.currentQuestionIndex, equals(1));
    });

    test('Reset quiz should clear all state', () {
      viewModel.setQuestions(mockQuestions);
      viewModel.setUserAnswer(0, 'Paris');
      viewModel.nextQuestion(mockContext);
      
      viewModel.resetQuiz();
      
      expect(viewModel.questions, isEmpty);
      expect(viewModel.userAnswers, isEmpty);
      expect(viewModel.currentQuestionIndex, equals(0));
      expect(viewModel.isCronRunning, isFalse);
    });

    test('Reset quiz for retry should maintain questions but reset answers', () {
      viewModel.setQuestions(mockQuestions);
      viewModel.setUserAnswer(0, 'Paris');
      viewModel.nextQuestion(mockContext);
      
      viewModel.resetQuizForRetry();
      
      expect(viewModel.questions.length, equals(2));
      expect(viewModel.userAnswers.length, equals(2));
      expect(viewModel.userAnswers[0], isEmpty);
      expect(viewModel.userAnswers[1], isEmpty);
      expect(viewModel.currentQuestionIndex, equals(0));
      expect(viewModel.isCronRunning, isTrue);
    });

    test('Time tracking should work correctly', () {
      viewModel.setQuestions(mockQuestions);
      viewModel.updateQuestionTime(59); // 60 - 59 = 1 second
      viewModel.nextQuestion(mockContext);
      viewModel.updateQuestionTime(58); // 60 - 58 = 2 seconds
      viewModel.calculateTotalTime();
      
      // First question: 60 - 59 = 1 second
      // Second question: 60 - 58 = 2 seconds
      // Total: 1 + 2 = 3 seconds
      expect(viewModel.totalTime, equals(3));
    });

    test('Cronometer control should work correctly', () {
      expect(viewModel.isCronRunning, isFalse);
      viewModel.startCron();
      expect(viewModel.isCronRunning, isTrue);
      viewModel.stopCron();
      expect(viewModel.isCronRunning, isFalse);
      viewModel.startCron();
      expect(viewModel.isCronRunning, isTrue);
    });
  });
} 