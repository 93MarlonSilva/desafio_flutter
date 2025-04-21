import 'package:flutter/material.dart';
import 'package:quizchallenge/views/history_view.dart';
import 'package:quizchallenge/views/home_view.dart';
import 'package:quizchallenge/views/maintenance_view.dart';
import 'package:quizchallenge/views/quiz_view.dart';
import 'package:quizchallenge/views/score_view.dart';
import 'package:quizchallenge/views/profile_view.dart';

class Routes {
  static const String home = '/home';
  static const String quiz = '/quiz';
  static const String score = '/score';
  static const String maintenance = '/maintenance';
  static const String history = '/history';
  static const String profile = '/profile';

  static Widget getRoute(String? routeName) {
    switch (routeName) {
      case home:
        return const HomeView();
      case quiz:
        return const QuizView();
      case score:
        return const ScoreView();
      case history:
        return const HistoryView();
      case profile:
        return const ProfileView();
      case maintenance:
        return const MaintenanceView();
      default:
        return const HomeView();
    }
  }

  static Map<String, WidgetBuilder> get routes => {
    home: (context) => const HomeView(),
    quiz: (context) => const QuizView(),
    score: (context) => const ScoreView(),
    history: (context) => const HistoryView(),
    profile: (context) => const ProfileView(),
    maintenance: (context) => const MaintenanceView(),
  };
}
