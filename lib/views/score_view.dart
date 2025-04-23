import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizchallenge/common/app_colors.dart';
import 'package:quizchallenge/common/routes.dart';
import 'package:quizchallenge/viewmodels/main_view_model.dart';
import '../viewmodels/quiz_view_model.dart';
import '../viewmodels/score_view_model.dart';
import '../widgets/button_widget.dart';

class ScoreView extends StatelessWidget {
  const ScoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainViewModel>(
      builder: (context, mainViewModel, child) {
        return WillPopScope(
          onWillPop: () async {
            final scoreViewModel = context.read<ScoreViewModel>();
            await scoreViewModel.saveQuizAndNavigate(context);
            return true;
          },
          child: Scaffold(
            backgroundColor: AppColors.background,
            body: SafeArea(
              child: Consumer<ScoreViewModel>(
                builder: (context, scoreViewModel, child) {
                  return Visibility(
                    visible: !scoreViewModel.isLoading,
                    replacement: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.babyBlue,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () async {
                                  await scoreViewModel.saveQuizAndNavigate(
                                    context,
                                  );
                                },
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: AppColors.backgroundLight,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.close),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Consumer<QuizViewModel>(
                            builder: (context, quizViewModel, child) {
                              return Column(
                                children: [
                                  Visibility(
                                    visible: quizViewModel.score > 0,
                                    replacement: Image.asset(
                                      'assets/images/score_fail.png',
                                      width: 200,
                                      height: 200,
                                    ),
                                    child: Image.asset(
                                      'assets/images/score_success.png',
                                      width: 200,
                                      height: 200,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Text(
                                    'Quiz result #${quizViewModel.quizNumber}',
                                    style:
                                        Theme.of(
                                          context,
                                        ).textTheme.displayLarge!,
                                  ),
                                ],
                              );
                            },
                          ),

                          const SizedBox(height: 58),
                          Consumer<QuizViewModel>(
                            builder: (context, viewModel, child) {
                              if (viewModel.questions.isEmpty) {
                                return const SizedBox.shrink();
                              }
                              return Container(
                                width: double.infinity,
                                height: 144,
                                decoration: BoxDecoration(
                                  color: AppColors.backgroundLight,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 71,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 19.5,
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
                                            child: Image.asset(
                                              'assets/images/points.png',
                                              width: 22,
                                              height: 15,
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Text(
                                            'TOTAL SCORE',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.displayMedium!.copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.blackCustom,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            '${viewModel.score.toString().toUpperCase()}/100',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.displayMedium!.copyWith(
                                              color: AppColors.blackCustom,
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1,
                                      height: 1,
                                      color: AppColors.background,
                                    ),
                                    Container(
                                      height: 71,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 19.5,
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
                                            child: Image.asset(
                                              'assets/images/check.png',
                                              width: 22,
                                              height: 15,
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Text(
                                            'CORRECT ANSWERS',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.displayMedium!.copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.blackCustom,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            '${viewModel.correctAnswers}/${viewModel.questions.length}',
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
                                  ],
                                ),
                              );
                            },
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Expanded(
                                child: CustomButtonWidget(
                                  text: 'TRY AGAIN',
                                  enabled: true,
                                  onPressed: () async {
                                    final quizViewModel =
                                        context.read<QuizViewModel>();

                                    quizViewModel.resetQuizForRetry();
                                    if (context.mounted) {
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        Routes.quiz,
                                        (route) => false,
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 58),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
