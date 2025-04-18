import 'package:flutter/material.dart';
import '../../widgets/widget_button.dart';

class RankingPage extends StatefulWidget {

  const RankingPage({
    super.key,
  });

  @override
  State<RankingPage> createState() => _RankingPageState();
}


class _RankingPageState extends State<RankingPage> {

  @override
  void initState() {
   // onLoadRankingData();
    super.initState();
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
                Icons.leaderboard_rounded,
                size: 64,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                'Quiz History',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: 335,
                height: 80,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 24),
                    Icon(
                      Icons.emoji_events_rounded,
                      size: 32,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Highest Score',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                        // Text(
                        //   highestScore.toString(),
                        //   style: theme.textTheme.titleLarge?.copyWith(
                        //     fontSize: 24,
                        //     fontWeight: FontWeight.w700,
                        //     color: theme.colorScheme.primary,
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: 0, //quizHistory.length,
                  itemBuilder: (context, index) {
                    final quiz = 0;//quizHistory[index];
                    return Container(
                      width: 335,
                      height: 80,
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 24),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.background,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(
                                //   quiz['date'] as String,
                                //   style: theme.textTheme.bodyLarge?.copyWith(
                                //     color: theme.colorScheme.onSurface.withOpacity(0.7),
                                //   ),
                                // ),
                                // Text(
                                //   'Score: ${quiz['score']}',
                                //   style: theme.textTheme.titleLarge?.copyWith(
                                //     color: theme.colorScheme.primary,
                                //     fontWeight: FontWeight.w600,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(right: 24),
                          //   child: Text(
                          //     '${quiz['correctAnswers']}/10',
                          //     style: theme.textTheme.titleLarge?.copyWith(
                          //       color: theme.colorScheme.primary,
                          //       fontWeight: FontWeight.w700,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
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

