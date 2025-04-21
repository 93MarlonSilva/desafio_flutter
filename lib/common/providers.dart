import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../viewmodels/main_view_model.dart';
import '../viewmodels/quiz_view_model.dart';
import '../viewmodels/score_view_model.dart';
import '../viewmodels/profile_view_model.dart';
import '../viewmodels/quiz_history_view_model.dart';
import '../services/database_service.dart';

class AppProviders {
  static List<SingleChildWidget> get providers => [
    Provider<DatabaseService>(create: (_) => DatabaseService()),
    ChangeNotifierProvider<MainViewModel>(create: (_) => MainViewModel()),
    ChangeNotifierProvider<QuizViewModel>(create: (_) => QuizViewModel()),
    ChangeNotifierProvider<ScoreViewModel>(create: (_) => ScoreViewModel()),
    ChangeNotifierProvider<ProfileViewModel>(create: (_) => ProfileViewModel()),
    ChangeNotifierProvider<QuizHistoryViewModel>(
      create: (context) => QuizHistoryViewModel(context.read<DatabaseService>()),
    ),
  ];
}
