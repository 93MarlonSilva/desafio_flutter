import 'package:flutter_test/flutter_test.dart';
import 'package:quizchallenge/viewmodels/score_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('ScoreViewModel Tests', () {
    late ScoreViewModel viewModel;

    setUp(() {
      // Reset SharedPreferences for testing
      SharedPreferences.setMockInitialValues({});
      viewModel = ScoreViewModel();
    });

    test('Initial state should be zero', () {
      expect(viewModel.score, equals(0));
      expect(viewModel.correctAnswers, equals(0));
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.isNewHighScore, isFalse);
    });

    test('Setting score should update state', () {
      viewModel.setScore(50);
      expect(viewModel.score, equals(50));
    });

    test('Setting correct answers should update state', () {
      viewModel.setCorrectAnswers(3);
      expect(viewModel.correctAnswers, equals(3));
    });

    test('Update score should update both score and correct answers', () {
      viewModel.updateScore(75, 4);
      expect(viewModel.score, equals(75));
      expect(viewModel.correctAnswers, equals(4));
    });

    test('Check and save high score should work correctly', () async {
      // First score should be new high score
      await viewModel.checkAndSaveHighScore(50);
      expect(viewModel.isNewHighScore, isTrue);
      expect(viewModel.isLoading, isFalse);

      // Reset state
      viewModel = ScoreViewModel();

      // Higher score should be new high score
      await viewModel.checkAndSaveHighScore(75);
      expect(viewModel.isNewHighScore, isTrue);
      expect(viewModel.isLoading, isFalse);

      // Reset state
      viewModel = ScoreViewModel();

      // Lower score should not be new high score
      await viewModel.checkAndSaveHighScore(25);
      expect(viewModel.isNewHighScore, isFalse);
      expect(viewModel.isLoading, isFalse);
    });

    test('Loading state should update correctly during high score check', () async {
      expect(viewModel.isLoading, isFalse);
      
      final future = viewModel.checkAndSaveHighScore(50);
      expect(viewModel.isLoading, isTrue);
      
      await future;
      expect(viewModel.isLoading, isFalse);
    });
  });
} 