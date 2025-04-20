import 'package:flutter/material.dart';
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
}
