import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizchallenge/common/app_colors.dart';
import 'package:quizchallenge/widgets/custom_page_widget.dart';
import 'package:quizchallenge/widgets/dropdown_widget.dart';
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
        child: CustomPageWidget(
          isLoading: context.watch<MainViewModel>().isLoading,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 64),

                Text(
                  'Quiz',
                  style: Theme.of(
                    context,
                  ).textTheme.displayLarge!.copyWith(fontSize: 40),
                ),
                Text(
                  'Challenge',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: AppColors.babyBlue,
                    fontSize: 40,
                  ),
                ),
                const SizedBox(height: 64),
                Consumer<MainViewModel>(
                  builder: (context, mainViewModel, child) {
                    return Column(
                      spacing: 30,
                      children: [
                        CustomDropdownWidget<CategoryModel>(
                          value: mainViewModel.selectedCategory,
                          label:
                              'Gerar o codigo no banco e trazer o registro depois salvar nele',
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

                        final request = await quizViewModel.onLoadQuizData(
                          mainViewModel.selectedCategory?.id.toString(),
                          mainViewModel.selectedDifficulty,
                          int.parse(mainViewModel.selectedAmount!),
                        );

                        if (request && context.mounted) {
                          Navigator.pushNamed(context, '/quiz');
                        } else if (context.mounted) {
                          Navigator.pushNamed(context, '/maintenance');
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
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
