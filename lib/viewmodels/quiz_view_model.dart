import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/quiz_model.dart';
import '../common/constants.dart';
import 'dart:convert';
import 'main_view_model.dart';

class QuizViewModel extends ChangeNotifier {
  final MainViewModel _mainViewModel;
  List<QuizResult> _quizResults = [];
  int? _selectedCategory;
  String? _selectedDifficulty;
  int? _selectedAmount;

  QuizViewModel(this._mainViewModel);

  // Getters
  List<QuizResult> get quizResults => List.unmodifiable(_quizResults);
  bool get isLoading => _mainViewModel.isLoading;
  int? get selectedCategory => _selectedCategory;
  String? get selectedDifficulty => _selectedDifficulty;
  int? get selectedAmount => _selectedAmount;

  final List<Map<String, dynamic>> categories = [
    {'id': 9, 'name': 'General Knowledge'},
    {'id': 15, 'name': 'Video Games'},
    {'id': 17, 'name': 'Science & Nature'},
    {'id': 18, 'name': 'Computers'},
    {'id': 21, 'name': 'Sports'},
  ];

  final List<String> difficulties = ['easy', 'medium', 'hard'];
  final List<int> amounts = [5, 10, 15, 20];

  // Setters
  void setSelectedCategory(int? value) {
    _selectedCategory = value;
    notifyListeners();
  }

  void setSelectedDifficulty(String? value) {
    _selectedDifficulty = value;
    notifyListeners();
  }

  void setSelectedAmount(int? value) {
    _selectedAmount = value;
    notifyListeners();
  }

  bool get isFormValid => 
    _selectedCategory != null && 
    _selectedDifficulty != null && 
    _selectedAmount != null;

  // Setters privados
  void _setQuizResults(List<QuizResult> results) {
    _quizResults = results;
    notifyListeners();
  }

  // Functions
  Future<bool> onLoadQuizData() async {
    if (!isFormValid) return false;

    _mainViewModel.setLoading(true);

    String getQuestionsUrl({
      required int amount,
      required int category,
      required String difficulty,
      String type = 'multiple',
      String encode = 'url3986',
    }) {
      return '$Constants.baseUrl?amount=$amount&category=$category&difficulty=$difficulty&type=$type&encode=$encode';
    }

    try {
      final url = getQuestionsUrl(
        amount: _selectedAmount!,
        category: _selectedCategory!,
        difficulty: _selectedDifficulty!,
      );
      
      final response = await http.get(Uri.parse(url));
      final jsonResponse = json.decode(response.body);
      
      if (jsonResponse['response_code'] == 0) {
        final quizModel = QuizModel.fromJson(jsonResponse);
        _setQuizResults(quizModel.results);
        _mainViewModel.setLoading(false);
        return true;
      }
      
      _mainViewModel.setLoading(false);
      return false;
    } catch (e) {
      _mainViewModel.setLoading(false);
      return false;
    }
  }
}
