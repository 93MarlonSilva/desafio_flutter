import 'package:flutter/material.dart';
import 'package:quizchallenge/common/functions.dart';
import 'package:quizchallenge/common/routes.dart';
import '../models/category_model.dart';

class MainViewModel extends ChangeNotifier {
  bool _isLoading = false;
  CategoryModel? _selectedCategory;
  String? _selectedDifficulty;
  String? _selectedAmount;

  bool get isLoading => _isLoading;
  CategoryModel? get selectedCategory => _selectedCategory;
  String? get selectedDifficulty => _selectedDifficulty;
  String? get selectedAmount => _selectedAmount;

  final List<CategoryModel> categories = [
    const CategoryModel(name: 'Any', id: 0),
    const CategoryModel(name: 'Genereal Unknowlegends', id: 9),
    const CategoryModel(name: 'Books', id: 10),
    const CategoryModel(name: 'Movies', id: 11),
    const CategoryModel(name: 'Music', id: 12),
    const CategoryModel(name: 'Video Games', id: 15),
  ];

  final List<String> difficulties = ['any', 'easy', 'medium', 'hard'];
  final List<String> amounts = ['5', '10', '15', '20'];

  bool get isFormValid {
    return _selectedCategory != null &&
        _selectedDifficulty != null &&
        _selectedAmount != null;
  }

  // Setters
  void setSelectedCategory(CategoryModel? value) {
    _selectedCategory = value;
    notifyListeners();
  }

  void setSelectedDifficulty(String? value) {
    _selectedDifficulty = value;
    notifyListeners();
  }

  void setSelectedAmount(String? value) {
    _selectedAmount = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void handleQuizError(BuildContext context, int errorCode) {
    String message;
    ShowBottomToastType type;

    switch (errorCode) {
      case 1: // No Results
        message = 'No questions found for your selection. Please try a different category or difficulty.';
        type = ShowBottomToastType.mainColor;
        break;
      case 2: // Invalid Parameter
        message = 'Invalid parameters. Please check your selections and try again.';
        type = ShowBottomToastType.mainColor;
        break;
      case 3: // Token Not Found
        message = 'Session error. Please try again.';
        type = ShowBottomToastType.mainColor;
        break;
      case 4: // Token Empty
        message = 'No more questions available. Please try a different category.';
        type = ShowBottomToastType.mainColor;
        break;
      case 5: // Rate Limit
        message = 'Please wait a few seconds before trying again.';
        type = ShowBottomToastType.mainColor;
        break;
      case 6: // Invalid amount
        message = 'Invalid number of questions. Please select a valid amount.';
        type = ShowBottomToastType.mainColor;
        break;
      case 7: // JSON conversion error
        message = 'Error processing quiz data. Please try again.';
        type = ShowBottomToastType.mainColor;
        break;
      case 8: // API error
        Navigator.pushNamed(context, Routes.maintenance);
        return;
      default:
        message = 'An unexpected error occurred. Please try again.';
        type = ShowBottomToastType.mainColor;
    }

    AppFunctions.showOverlayMessage(
      context: context,
      message: message,
      type: type,
    );
  }
}
