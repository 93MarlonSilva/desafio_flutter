import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizchallenge/common/app_colors.dart';
import 'package:quizchallenge/common/routes.dart';
import 'package:quizchallenge/viewmodels/main_view_model.dart';
import 'package:quizchallenge/widgets/custom_page_widget.dart';
import 'package:quizchallenge/widgets/list_quiz_item_widget.dart';
import 'package:quizchallenge/widgets/progress_track_widget.dart';
import 'package:quizchallenge/widgets/cron_quiz_widget.dart';
import '../viewmodels/quiz_view_model.dart';
import '../widgets/button_widget.dart';

class QuizView extends StatelessWidget {
  const QuizView({super.key});

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
                    const SizedBox(height: 40),
                    Consumer<QuizViewModel>(
                      builder: (context, viewModel, child) {
                        return KeyedSubtree(
                          key: ValueKey(viewModel.currentQuestionIndex),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CronQuizWidget(
                                initialSeconds: 60,
                                onTimeUpdate: (time) {
                                  viewModel.updateQuestionTime(time);
                                },
                                onTimeEnd: () {
                                  if (viewModel
                                      .userAnswers[viewModel
                                          .currentQuestionIndex]
                                      .isEmpty) {
                                    viewModel.setUserAnswer(
                                      viewModel.currentQuestionIndex,
                                      '',
                                    );
                                  }
                                  viewModel.nextQuestion(context);
                                },
                              ),
                              Text(
                                'Category',
                                style: Theme.of(
                                  context,
                                ).textTheme.displayMedium!.copyWith(
                                  fontSize: 18,
                                  color: AppColors.black,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    Routes.home,
                                    (route) => false,
                                  ).then((_) {
                                    final quizViewModel =
                                        context.read<QuizViewModel>();

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
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Consumer<QuizViewModel>(
                          builder: (context, viewModel, child) {
                            return ProgressTrackWidget(
                              currentIndex: viewModel.currentQuestionIndex,
                              totalQuestions: viewModel.questions.length,
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Consumer<QuizViewModel>(
                      builder: (context, viewModel, child) {
                        return Expanded(
                          child: Column(
                            children: [
                              Text(
                                viewModel.currentQuestion.question,
                                style:
                                    Theme.of(context).textTheme.displayLarge!,
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(height: 64),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    viewModel.currentQuestionOptions.length,
                                itemBuilder: (context, index) {
                                  final option =
                                      viewModel.currentQuestionOptions[index];
                                  final letter = String.fromCharCode(
                                    65 + index,
                                  );
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 30),
                                    child: ListQuizItemWidget(
                                      text: option,
                                      letter: letter,
                                      isSelected:
                                          viewModel.userAnswers[viewModel
                                              .currentQuestionIndex] ==
                                          option,
                                      onTap: () {
                                        viewModel.setUserAnswer(
                                          viewModel.currentQuestionIndex,
                                          option,
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Consumer<QuizViewModel>(
                      builder: (context, viewModel, child) {
                        return CustomButtonWidget(
                          text: 'CONTINUAR',
                          enabled: viewModel.canProceed,
                          onPressed: () {
                            if (viewModel
                                .userAnswers[viewModel.currentQuestionIndex]
                                .isEmpty) {
                              viewModel.setUserAnswer(
                                viewModel.currentQuestionIndex,
                                '',
                              );
                            }
                            viewModel.nextQuestion(context);
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
      },
    );
  }
}
