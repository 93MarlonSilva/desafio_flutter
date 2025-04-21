import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:quizchallenge/common/providers.dart';
import 'package:quizchallenge/common/routes.dart';
import 'package:quizchallenge/common/theme.dart';
import 'package:quizchallenge/models/quiz_history_model.dart';
import 'package:quizchallenge/viewmodels/main_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Register adapters
  Hive.registerAdapter(QuizHistoryModelAdapter());
  
  // Open boxes
  await Hive.openBox<QuizHistoryModel>('quizHistory');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProviders.providers,
      child: MaterialApp(
        title: 'Quiz Challenge',
        theme: AppTheme.lightTheme,
        initialRoute: Routes.home,
        routes: Routes.routes,
      ),
    );
  }
}
