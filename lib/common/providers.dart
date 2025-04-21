import 'package:provider/provider.dart';
import '../viewmodels/main_view_model.dart';
import '../viewmodels/quiz_view_model.dart';
import '../viewmodels/score_view_model.dart';
import '../viewmodels/profile_view_model.dart';
import '../viewmodels/quiz_history_view_model.dart';
import '../services/database_service.dart';
import '../database/app_database.dart';

class AppProviders {
  static List<dynamic> get providers => [
    Provider<AppDatabase>(create: (_) => AppDatabase()),
    Provider<DatabaseService>(
      create: (context) => DatabaseService(context.read<AppDatabase>()),
    ),
    ChangeNotifierProvider<MainViewModel>(create: (_) => MainViewModel()),
    ChangeNotifierProxyProvider<MainViewModel, QuizViewModel>(
      create: (_) => QuizViewModel(),
      update: (_, mainViewModel, quizViewModel) => QuizViewModel(),
    ),
    ChangeNotifierProvider<ScoreViewModel>(create: (_) => ScoreViewModel()),
    ChangeNotifierProvider<ProfileViewModel>(create: (_) => ProfileViewModel()),
    ChangeNotifierProvider<QuizHistoryViewModel>(
      create:
          (context) => QuizHistoryViewModel(context.read<DatabaseService>()),
    ),
  ];
}
