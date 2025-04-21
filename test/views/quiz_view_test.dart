import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:quizchallenge/views/quiz_view.dart';
import 'package:quizchallenge/viewmodels/quiz_view_model.dart';
import 'package:quizchallenge/viewmodels/main_view_model.dart';
import 'package:quizchallenge/models/quiz_model.dart';
import 'package:quizchallenge/common/routes.dart';
import 'package:quizchallenge/widgets/cron_quiz_widget.dart';
import 'package:quizchallenge/widgets/progress_track_widget.dart';
import 'package:quizchallenge/widgets/button_widget.dart';

void main() {
  group('QuizView Widget Tests', () {
    late QuizViewModel quizViewModel;
    late MainViewModel mainViewModel;
    late List<QuizResult> mockQuestions;

    setUp(() {
      quizViewModel = QuizViewModel();
      mainViewModel = MainViewModel();
      mockQuestions = [
        QuizResult(
          type: 'multiple',
          difficulty: 'easy',
          category: 'Books',
          question: 'What is the capital of France?',
          correctAnswer: 'Paris',
          incorrectAnswers: ['London', 'Berlin', 'Madrid'],
        ),
        QuizResult(
          type: 'multiple',
          difficulty: 'easy',
          category: 'Books',
          question: 'What is 2+2?',
          correctAnswer: '4',
          incorrectAnswers: ['3', '5', '6'],
        ),
      ];
      quizViewModel.setQuestions(mockQuestions);
    });

    testWidgets('QuizView should show initial question and options',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<MainViewModel>.value(value: mainViewModel),
            ChangeNotifierProvider<QuizViewModel>.value(value: quizViewModel),
          ],
          child: const MaterialApp(
            home: QuizView(),
          ),
        ),
      );

      // Verify question is displayed
      expect(find.text('What is the capital of France?'), findsOneWidget);

      // Verify all options are displayed
      expect(find.text('A. Paris'), findsOneWidget);
      expect(find.text('B. London'), findsOneWidget);
      expect(find.text('C. Berlin'), findsOneWidget);
      expect(find.text('D. Madrid'), findsOneWidget);

      // Verify progress track
      expect(find.byType(ProgressTrackWidget), findsOneWidget);

      // Verify timer
      expect(find.byType(CronQuizWidget), findsOneWidget);

      // Verify next button is disabled initially
      final nextButton = find.byType(CustomButtonWidget);
      expect(nextButton, findsOneWidget);
      expect(tester.widget<CustomButtonWidget>(nextButton).enabled, isFalse);
    });

    testWidgets('Selecting an answer should enable next button',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<MainViewModel>.value(value: mainViewModel),
            ChangeNotifierProvider<QuizViewModel>.value(value: quizViewModel),
          ],
          child: const MaterialApp(
            home: QuizView(),
          ),
        ),
      );

      // Select an answer
      await tester.tap(find.text('A. Paris'));
      await tester.pumpAndSettle();

      // Verify next button is enabled
      final nextButton = find.byType(CustomButtonWidget);
      expect(nextButton, findsOneWidget);
      expect(tester.widget<CustomButtonWidget>(nextButton).enabled, isTrue);
    });

    testWidgets('Progress track should update when moving to next question',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<MainViewModel>.value(value: mainViewModel),
            ChangeNotifierProvider<QuizViewModel>.value(value: quizViewModel),
          ],
          child: const MaterialApp(
            home: QuizView(),
          ),
        ),
      );

      // Select answer and move to next question
      await tester.tap(find.text('A. Paris'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('NEXT'));
      await tester.pumpAndSettle();

      // Verify second question is displayed
      expect(find.text('What is 2+2?'), findsOneWidget);

      // Verify progress track updated
      expect(find.byType(ProgressTrackWidget), findsOneWidget);
    });

    testWidgets('Timer should stop when quiz is complete',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<MainViewModel>.value(value: mainViewModel),
            ChangeNotifierProvider<QuizViewModel>.value(value: quizViewModel),
          ],
          child: const MaterialApp(
            home: QuizView(),
          ),
        ),
      );

      // Answer first question
      await tester.tap(find.text('A. Paris'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('NEXT'));
      await tester.pumpAndSettle();

      // Answer second question
      await tester.tap(find.text('A. 4'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('NEXT'));
      await tester.pumpAndSettle();

      // Verify quiz is complete and timer is stopped
      expect(quizViewModel.isCronRunning, isFalse);
    });

    testWidgets('Close button should navigate to home',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<MainViewModel>.value(value: mainViewModel),
            ChangeNotifierProvider<QuizViewModel>.value(value: quizViewModel),
          ],
          child: MaterialApp(
            home: const QuizView(),
            routes: {
              Routes.home: (context) => const Scaffold(
                    body: Center(child: Text('Home Screen')),
                  ),
            },
          ),
        ),
      );

      // Tap close button
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      // Verify navigation to home
      expect(find.text('Home Screen'), findsOneWidget);
    });
  });
} 