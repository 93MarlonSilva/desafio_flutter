import 'package:flutter/material.dart';
import '../../widgets/widget_progress_track.dart';
import '../../widgets/widget_list_quiz_item.dart';
import '../../widgets/widget_button.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const WidgetProgressTrack(
                currentIndex: 0,
                totalQuestions: 10,
              ),
              const SizedBox(height: 24),
              Text(
                'What is the capital of France?',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Column(
                  children: [
                    WidgetListQuizItem(
                      letter: 'A',
                      text: 'London',
                      isSelected: false,
                      onTap: () {},
                    ),
                    WidgetListQuizItem(
                      letter: 'B',
                      text: 'Paris',
                      isSelected: true,
                      onTap: () {},
                    ),
                    WidgetListQuizItem(
                      letter: 'C',
                      text: 'Berlin',
                      isSelected: false,
                      onTap: () {},
                    ),
                    WidgetListQuizItem(
                      letter: 'D',
                      text: 'Madrid',
                      isSelected: false,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const WidgetCustomButton(
                text: 'Next Question',
                enabled: true,
                onPressed: null,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}