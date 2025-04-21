import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizchallenge/common/app_colors.dart';
import 'package:quizchallenge/common/routes.dart';
import 'package:quizchallenge/widgets/dropdown_widget.dart';
import 'package:quizchallenge/widgets/bottom_menu_widget.dart';
import '../models/category_model.dart';
import '../viewmodels/main_view_model.dart';
import '../viewmodels/quiz_view_model.dart';
import '../widgets/button_widget.dart';
import 'package:hive/hive.dart';
import '../models/quiz_history_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Image.asset('assets/images/war.png', width: 200, height: 200),
              Text(
                'Try your best',
                style: Theme.of(
                  context,
                ).textTheme.displayLarge!.copyWith(fontSize: 40),
              ),
              const SizedBox(height: 64),
              Consumer<MainViewModel>(
                builder: (context, mainViewModel, child) {
                  return Column(
                    spacing: 30,
                    children: [
                      CustomDropdownWidget<CategoryModel>(
                        key: const Key('category_dropdown'),
                        value: mainViewModel.selectedCategory,
                        label: 'Category',
                        items: mainViewModel.categories,
                        onChanged: mainViewModel.setSelectedCategory,
                        itemToString: (item) => item.name,
                      ),
                      CustomDropdownWidget<String>(
                        key: const Key('difficulty_dropdown'),
                        value: mainViewModel.selectedDifficulty,
                        label: 'Difficulty',
                        items: mainViewModel.difficulties,
                        onChanged: mainViewModel.setSelectedDifficulty,
                        itemToString: (item) => item.capitalize(),
                      ),
                      CustomDropdownWidget<String>(
                        key: const Key('amount_dropdown'),
                        value: mainViewModel.selectedAmount,
                        label: 'Number of Questions',
                        items: mainViewModel.amounts,
                        onChanged: mainViewModel.setSelectedAmount,
                        itemToString: (item) => item,
                      ),
                    ],
                  );
                },
              ),
              const Spacer(),
              if (context.watch<MainViewModel>().isLoading)
                CircularProgressIndicator(
                      color: AppColors.babyBlue,
                      strokeWidth: 4,
                    ),
                    const SizedBox(height: 16),
              Consumer<MainViewModel>(
                builder: (context, mainViewModel, child) {
                  return CustomButtonWidget(
                    key: const Key('start_quiz_button'),
                    text: 'START QUIZ',
                    enabled: mainViewModel.isFormValid,
                    onPressed: () async {
                      final quizViewModel = context.read<QuizViewModel>();
                      final mainViewModel = context.read<MainViewModel>();

                      try {
                        mainViewModel.setLoading(true);
                        quizViewModel.resetQuiz();
                 
                        final request = await quizViewModel.onLoadQuizData(
                          mainViewModel.selectedCategory?.id.toString(),
                          mainViewModel.selectedDifficulty,
                          int.parse(mainViewModel.selectedAmount!),
                        );

                        if (!context.mounted) return;

                        if (request == 0) {
                          try {
                            final box = Hive.box<QuizHistoryModel>('quizHistory');
                            final nextQuizNumber = box.length + 1;
                            quizViewModel.setQuizNumber(nextQuizNumber);
                            box.close();
                          } catch (e) {
                            debugPrint('Error: $e');
                            mainViewModel.setLoading(false);
                            return;
                          }
                          mainViewModel.setLoading(false);
                          Navigator.pushNamed(context, Routes.quiz);
                        } else {
                          mainViewModel.setLoading(false);
                          mainViewModel.handleQuizError(context, request);
                        }
     
                      } catch (e) {
                        if (context.mounted) {
                          debugPrint('Error: $e');
                          mainViewModel.setLoading(false);
                          mainViewModel.handleQuizError(context, 8); // API error
                        }
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 58),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomMenuWidget(),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
