import 'package:provider/provider.dart';
import '../viewmodels/main_view_model.dart';
import '../viewmodels/quiz_view_model.dart';
import '../viewmodels/score_view_model.dart';

class AppProviders {
  static List<dynamic> get providers => [
    ChangeNotifierProvider<MainViewModel>(create: (_) => MainViewModel()),
    ChangeNotifierProxyProvider<MainViewModel, QuizViewModel>(
      create: (_) => QuizViewModel(),
      update: (_, mainViewModel, quizViewModel) => QuizViewModel(),
    ),
    ChangeNotifierProvider<ScoreViewModel>(create: (_) => ScoreViewModel()),
  ];
}
