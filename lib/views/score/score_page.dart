import 'package:flutter/material.dart';
import '../../widgets/widget_button.dart';
import '../../widgets/widget_score_card.dart';

class ScorePage extends StatefulWidget {

  const ScorePage({
    super.key,
  });

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {

  @override
  void initState() {
    super.initState();
   // onLoadScoreData();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Icon(
                Icons.emoji_events_rounded,
                size: 64,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                'Quiz Result',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24),
              // WidgetScoreCard(
              //   icon: Icons.star_rounded,
              //   title: 'Score',
              //   value: score.toString(),
              // ),
              // const SizedBox(height: 16),
              // WidgetScoreCard(
              //   icon: Icons.check_circle_rounded,
              //   title: 'Correct Answers',
              //   value: '$correctAnswers/10',
              // ),
              const Spacer(),
              WidgetCustomButton(
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
    );
  }
} 