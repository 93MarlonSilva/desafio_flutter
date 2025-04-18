import 'package:flutter/material.dart';
import '../../widgets/widget_button.dart';
import '../../widgets/widget_custom_page.dart';
import '../../viewmodels/quiz_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final quizViewModel = Provider.of<QuizViewModel>(context);
    
    return WidgetCustomPage(
      isLoading: quizViewModel.isLoading,
      child: Scaffold(
        backgroundColor: theme.colorScheme.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Spacer(),
                Text(
                  'Welcome to',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Quiz Challenge',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Test your knowledge and challenge yourself with our exciting quiz!',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 32),
                DropdownButtonFormField<int>(
                  value: quizViewModel.selectedCategory,
                  decoration: InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  items: quizViewModel.categories.map((category) {
                    return DropdownMenuItem<int>(
                      value: category['id'],
                      child: Text(category['name']),
                    );
                  }).toList(),
                  onChanged: quizViewModel.setSelectedCategory,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: quizViewModel.selectedDifficulty,
                  decoration: InputDecoration(
                    labelText: 'Difficulty',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  items: quizViewModel.difficulties.map((difficulty) {
                    return DropdownMenuItem<String>(
                      value: difficulty,
                      child: Text(difficulty.capitalize()),
                    );
                  }).toList(),
                  onChanged: quizViewModel.setSelectedDifficulty,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  value: quizViewModel.selectedAmount,
                  decoration: InputDecoration(
                    labelText: 'Number of Questions',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  items: quizViewModel.amounts.map((amount) {
                    return DropdownMenuItem<int>(
                      value: amount,
                      child: Text('$amount questions'),
                    );
                  }).toList(),
                  onChanged: quizViewModel.setSelectedAmount,
                ),
                const Spacer(),
                WidgetCustomButton(
                  text: 'Start Quiz',
                  enabled: quizViewModel.isFormValid,
                  onPressed: () async {
                    final success = await quizViewModel.onLoadQuizData();
                    if (success) {
                      if (context.mounted) {
                        Navigator.pushNamed(context, '/quiz');
                      }
                    } else {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Failed to load quiz data. Please try again.'),
                          ),
                        );
                      }
                    }
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
