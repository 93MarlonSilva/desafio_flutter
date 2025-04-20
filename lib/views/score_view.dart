import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizchallenge/common/app_colors.dart';
import 'package:quizchallenge/common/routes.dart';
import 'package:quizchallenge/viewmodels/main_view_model.dart';
import 'package:quizchallenge/widgets/custom_page_widget.dart';
import '../viewmodels/quiz_view_model.dart';
import '../widgets/button_widget.dart';

class ScoreView extends StatelessWidget {
  const ScoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainViewModel>(
      builder: (context, mainViewModel, child) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: CustomPageWidget(
              isLoading: mainViewModel.isLoading,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.home,
                          (route) => false,
                        ).then((_) {
                          final quizViewModel = context.read<QuizViewModel>();

                          quizViewModel.resetQuiz();
                          quizViewModel.setQuestions([]);
                        });
                      },
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundLight,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.close),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Icon(
                      Icons.emoji_events_rounded,
                      size: 64,
                      color: AppColors.babyBlue,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Quiz Completed!',
                      style: Theme.of(context).textTheme.displayMedium!,
                    ),
                    const SizedBox(height: 24),
                    Consumer<QuizViewModel>(
                      builder: (context, viewModel, child) {
                        if (viewModel.questions.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                color: AppColors.darkBlue,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 24),
                                  Icon(
                                    Icons.scoreboard_rounded,
                                    size: 32,
                                    color: AppColors.babyBlue,
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Your Score',
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.displayMedium!,
                                      ),
                                      Text(
                                        viewModel.score
                                            .toString()
                                            .toUpperCase(),
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.displayMedium!,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            Container(
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                color: AppColors.darkBlue,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 24),
                                  Icon(
                                    Icons.check_circle_rounded,
                                    size: 32,
                                    color: AppColors.babyBlue,
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'CORRECT ANSWERS',
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.displayMedium!,
                                      ),
                                      Text(
                                        '${viewModel.correctAnswers}/${viewModel.questions.length}',
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.displayMedium!,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            Container(
                              width: 335,
                              height: 80,
                              decoration: BoxDecoration(
                                color: AppColors.darkBlue,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 24),
                                  Icon(
                                    Icons.cancel_rounded,
                                    size: 32,
                                    color: AppColors.babyBlue,
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Wrong Answers',
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.displayMedium!,
                                      ),
                                      Text(
                                        viewModel.wrongAnswers.toString(),
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.displayMedium!,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            Container(
                              width: 335,
                              height: 80,
                              decoration: BoxDecoration(
                                color: AppColors.darkBlue,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 24),
                                  Icon(
                                    Icons.timer_rounded,
                                    size: 32,
                                    color: AppColors.babyBlue,
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Total Time',
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.displayMedium!,
                                      ),
                                      Text(
                                        '${viewModel.totalTime}s',
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.displayMedium!,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButtonWidget(
                            text: 'Try Again',
                            enabled: true,
                            onPressed: () {
                              final quizViewModel =
                                  context.read<QuizViewModel>();
                              quizViewModel.resetQuiz();
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                Routes.quiz,
                                (route) => false,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 58),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
