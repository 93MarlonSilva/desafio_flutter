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

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Visibility(
          visible: !context.watch<MainViewModel>().isLoading,
          replacement: const Center(
            child: CircularProgressIndicator(color: AppColors.babyBlue),
          ),
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
                          value: mainViewModel.selectedCategory,
                          label: 'Category',
                          items: mainViewModel.categories,
                          onChanged: mainViewModel.setSelectedCategory,
                          itemToString: (item) => item.name,
                        ),
                        CustomDropdownWidget<String>(
                          value: mainViewModel.selectedDifficulty,
                          label: 'Difficulty',
                          items: mainViewModel.difficulties,
                          onChanged: mainViewModel.setSelectedDifficulty,
                          itemToString: (item) => item.capitalize(),
                        ),
                        CustomDropdownWidget<String>(
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
                Consumer<MainViewModel>(
                  builder: (context, mainViewModel, child) {
                    return CustomButtonWidget(
                      text: 'START QUIZ',
                      enabled: mainViewModel.isFormValid,
                      onPressed: () async {
                        final quizViewModel = context.read<QuizViewModel>();

                        quizViewModel.resetQuiz();

                        final request = await quizViewModel.onLoadQuizData(
                          mainViewModel.selectedCategory?.id.toString(),
                          mainViewModel.selectedDifficulty,
                          int.parse(mainViewModel.selectedAmount!),
                        );

                        if (request && context.mounted) {
                          Navigator.pushNamed(context, Routes.quiz);
                        } else if (context.mounted) {
                          Navigator.pushNamed(context, Routes.maintenance);
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
