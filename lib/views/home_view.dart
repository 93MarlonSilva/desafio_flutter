import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizchallenge/common/app_colors.dart';
import 'package:quizchallenge/widgets/dropdown_widget.dart';
import 'package:quizchallenge/widgets/bottom_menu_widget.dart';
import '../models/category_model.dart';
import '../viewmodels/main_view_model.dart';
import '../widgets/button_widget.dart';

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
                    onPressed: () => mainViewModel.startQuiz(context),
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
