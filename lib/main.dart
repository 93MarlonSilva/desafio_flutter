import 'package:flutter/material.dart';
import 'package:quizchallenge/common/colors.dart';
import 'package:quizchallenge/views/home/home_page.dart';
import 'package:quizchallenge/views/quiz/quiz_page.dart';
import 'package:quizchallenge/views/ranking/ranking_page.dart';
import 'package:quizchallenge/views/score/score_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Challenge',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: AppColors.enabledButtonBackground,
          secondary: AppColors.selectedItemBackground,
          background: AppColors.background,
          surface: AppColors.whiteBackground,
          onPrimary: AppColors.whiteBackground,
          onSecondary: AppColors.whiteBackground,
          onBackground: AppColors.listItemText,
          onSurface: AppColors.listItemText,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: AppColors.quizTitle,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(
            color: AppColors.listItemText,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/quiz': (context) => const QuizPage(),
        '/ranking': (context) => const RankingPage(),
        '/score': (context) => const ScorePage(),
      },
    );
  }
}
