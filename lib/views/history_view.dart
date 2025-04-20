import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizchallenge/common/app_colors.dart';
import 'package:quizchallenge/widgets/custom_page_widget.dart';
import '../viewmodels/quiz_history_view_model.dart';
import '../widgets/button_widget.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomPageWidget(
          isLoading: context.watch<QuizHistoryViewModel>().isLoading,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 24),
                Icon(
                  Icons.leaderboard_rounded,
                  size: 64,
                  color: AppColors.babyBlue,
                ),
                const SizedBox(height: 24),
                Text(
                  'Quiz History',
                  style: Theme.of(context).textTheme.displayMedium!,
                ),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.babyBlue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 24),
                      Icon(
                        Icons.emoji_events_rounded,
                        size: 32,
                        color: AppColors.babyBlue,
                      ),
                      const SizedBox(width: 16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Highest Score',
                            style: Theme.of(context).textTheme.displayMedium!,
                          ),
                          Consumer<QuizHistoryViewModel>(
                            builder: (context, viewModel, child) {
                              return Text(
                                viewModel.highestScore.toString(),
                                style:
                                    Theme.of(context).textTheme.displayMedium!,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Consumer<QuizHistoryViewModel>(
                    builder: (context, viewModel, child) {
                      return ListView.builder(
                        itemCount: viewModel.quizHistory.length,
                        itemBuilder: (context, index) {
                          final quiz = viewModel.quizHistory[index];
                          return Container(
                            width: 335,
                            height: 80,
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: AppColors.babyBlue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 24),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.babyBlue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${index + 1}',
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.displayMedium!,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        viewModel.formatDate(quiz.date),
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.displayMedium!,
                                      ),
                                      Text(
                                        'Score: ${quiz.score}',
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.displayMedium!,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 24),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        viewModel.formatTime(quiz.totalTime),
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.displayMedium!,
                                      ),
                                      Text(
                                        '${quiz.correctAnswers}/${quiz.correctAnswers + quiz.wrongAnswers}',
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.displayMedium!,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                CustomButtonWidget(
                  text: 'Back to Home',
                  enabled: true,
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                      (route) => false,
                    );
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
