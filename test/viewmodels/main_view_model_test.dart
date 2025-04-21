import 'package:flutter_test/flutter_test.dart';
import 'package:quizchallenge/viewmodels/main_view_model.dart';
import 'package:quizchallenge/models/category_model.dart';

void main() {
  group('MainViewModel Tests', () {
    late MainViewModel viewModel;

    setUp(() {
      viewModel = MainViewModel();
    });

    test('Initial state should have no selections', () {
      expect(viewModel.selectedCategory, isNull);
      expect(viewModel.selectedDifficulty, isNull);
      expect(viewModel.selectedAmount, isNull);
      expect(viewModel.isFormValid, isFalse);
    });

    test('Setting category should update selection', () {
      final category = const CategoryModel(name: 'Books', id: 10);
      viewModel.setSelectedCategory(category);
      expect(viewModel.selectedCategory, equals(category));
    });

    test('Setting difficulty should update selection', () {
      viewModel.setSelectedDifficulty('easy');
      expect(viewModel.selectedDifficulty, equals('easy'));
    });

    test('Setting amount should update selection', () {
      viewModel.setSelectedAmount('5');
      expect(viewModel.selectedAmount, equals('5'));
    });

    test('Form should be valid when all selections are made', () {
      viewModel.setSelectedCategory(const CategoryModel(name: 'Books', id: 10));
      viewModel.setSelectedDifficulty('easy');
      viewModel.setSelectedAmount('5');
      expect(viewModel.isFormValid, isTrue);
    });

    test('Categories list should contain all predefined categories', () {
      expect(viewModel.categories.length, equals(6));
      expect(viewModel.categories[0].name, equals('Any'));
      expect(viewModel.categories[1].name, equals('Genereal Unknowlegends'));
      expect(viewModel.categories[2].name, equals('Books'));
      expect(viewModel.categories[3].name, equals('Movies'));
      expect(viewModel.categories[4].name, equals('Music'));
      expect(viewModel.categories[5].name, equals('Video Games'));
    });

    test('Difficulties list should contain all predefined difficulties', () {
      expect(viewModel.difficulties, equals(['any', 'easy', 'medium', 'hard']));
    });

    test('Amounts list should contain all predefined amounts', () {
      expect(viewModel.amounts, equals(['5', '10', '15', '20']));
    });

    test('Loading state should update correctly', () {
      expect(viewModel.isLoading, isFalse);
      viewModel.setLoading(true);
      expect(viewModel.isLoading, isTrue);
      viewModel.setLoading(false);
      expect(viewModel.isLoading, isFalse);
    });
  });
} 