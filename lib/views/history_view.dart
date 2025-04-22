import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizchallenge/common/app_colors.dart';
import 'package:quizchallenge/widgets/bottom_menu_widget.dart';
import '../viewmodels/quiz_history_view_model.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeHistory();
    });
  }

  Future<void> _initializeHistory() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });

    // Reset the view model state before loading new data
    context.read<QuizHistoryViewModel>().resetState();

    await context.read<QuizHistoryViewModel>().loadQuizHistory();

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<QuizHistoryViewModel>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Visibility(
          visible: !_isLoading && viewModel.isInitialized,
          replacement: const Center(
            child: CircularProgressIndicator(color: AppColors.babyBlue),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 24),
                Image.asset(
                  'assets/images/history.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 24),
                Text(
                  'Quiz History',
                  style: Theme.of(context).textTheme.displayLarge!,
                ),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            'assets/images/big_score_history.png',
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Highest Score',
                        style: Theme.of(
                          context,
                        ).textTheme.displayMedium!.copyWith(
                          color: AppColors.blackCustom,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        viewModel.highestScore.toString(),
                        style: Theme.of(
                          context,
                        ).textTheme.displayMedium!.copyWith(
                          color: AppColors.blackCustom,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'History',
                  style: Theme.of(context).textTheme.displayMedium!,
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.quizHistory.length,
                    itemBuilder: (context, index) {
                      final quiz = viewModel.quizHistory[index];
                      return Container(
                        width: double.infinity,
                        height: 60,
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 16),
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${viewModel.quizHistory.length - index}',
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Date: ${viewModel.formatDate(quiz.date)}',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.displayMedium!.copyWith(
                                      color: AppColors.blackCustom,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'Score: ${quiz.score}',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.displayMedium!.copyWith(
                                      color: AppColors.blackCustom,
                                      fontWeight: FontWeight.w700,
                                    ),
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
                                    'Time: ${viewModel.formatTime(quiz.totalTime)}',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.displayMedium!.copyWith(
                                      color: AppColors.blackCustom,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'Correct: ${quiz.correctAnswers}/${quiz.correctAnswers + quiz.wrongAnswers}',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.displayMedium!.copyWith(
                                      color: AppColors.blackCustom,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
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
