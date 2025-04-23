import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:quizchallenge/views/quiz_view.dart';
import 'package:quizchallenge/viewmodels/quiz_view_model.dart';
import 'package:quizchallenge/viewmodels/main_view_model.dart';
import 'package:quizchallenge/viewmodels/score_view_model.dart';
import 'package:quizchallenge/models/quiz_model.dart';
import 'package:quizchallenge/common/routes.dart';
import 'package:quizchallenge/widgets/cron_quiz_widget.dart';
import 'package:quizchallenge/widgets/progress_track_widget.dart';
import 'package:quizchallenge/widgets/button_widget.dart';
import 'package:quizchallenge/widgets/list_quiz_item_widget.dart';

void main() {
  group('QuizView Widget Tests', () {
    late QuizViewModel quizViewModel;
    late MainViewModel mainViewModel;
    late ScoreViewModel scoreViewModel;
    late List<QuizResult> mockQuestions;

    setUp(() async {
      quizViewModel = QuizViewModel();
      mainViewModel = MainViewModel();
      scoreViewModel = ScoreViewModel();
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

    testWidgets('QuizView should show initial question and options', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<MainViewModel>.value(value: mainViewModel),
            ChangeNotifierProvider<QuizViewModel>.value(value: quizViewModel),
            ChangeNotifierProvider<ScoreViewModel>.value(value: scoreViewModel),
          ],
          child: MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(size: Size(800, 1200)),
              child: SizedBox(
                height: 800,
                child: const QuizView(),
              ),
            ),
          ),
        ),
      );
      // Aguarda a renderização completa
      await tester.pumpAndSettle();
      
      // Verifica se o ListView está presente
      expect(find.byType(ListView), findsOneWidget);

      // Verifica se o itemCount é 4
      final listView = tester.widget<ListView>(find.byType(ListView));
      final itemCount = (listView.childrenDelegate as SliverChildBuilderDelegate).childCount;
      expect(itemCount, equals(4));

      // Verify timer and quiz number are displayed
      expect(find.byType(CronQuizWidget), findsOneWidget);
      expect(find.text('Quiz #1'), findsOneWidget);

      // Verify question is displayed
      expect(find.text('What is the capital of France?'), findsOneWidget);

      // Verify progress track
      expect(find.byType(ProgressTrackWidget), findsOneWidget);
      expect(find.text('1/2'), findsOneWidget);

      // Verify next button is disabled initially
      final nextButton = find.byType(CustomButtonWidget);
      expect(nextButton, findsOneWidget);
      expect(tester.widget<CustomButtonWidget>(nextButton).enabled, isFalse);
    });

    testWidgets('Selecting an answer should enable next button', (
      WidgetTester tester,
    ) async {
      // Garante que as opções foram definidas
      expect(quizViewModel.currentQuestionOptions.length, equals(4));

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<MainViewModel>.value(value: mainViewModel),
            ChangeNotifierProvider<QuizViewModel>.value(value: quizViewModel),
            ChangeNotifierProvider<ScoreViewModel>.value(value: scoreViewModel),
          ],
          child: MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(size: Size(800, 1200)),
              child: SizedBox(
                height: 800,
                child: const QuizView(),
              ),
            ),
          ),
        ),
      );

      // Aguarda a renderização completa
      await tester.pumpAndSettle();

      // Select an answer
      await tester.tap(find.byType(ListQuizItemWidget).first);
      await tester.pumpAndSettle();

      // Verify next button is enabled
      final nextButton = find.byType(CustomButtonWidget);
      expect(nextButton, findsOneWidget);
      expect(tester.widget<CustomButtonWidget>(nextButton).enabled, isTrue);
    });

    testWidgets('Progress track should update when moving to next question', (
      WidgetTester tester,
    ) async {
      // Garante que as opções foram definidas
      expect(quizViewModel.currentQuestionOptions.length, equals(4));

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<MainViewModel>.value(value: mainViewModel),
            ChangeNotifierProvider<QuizViewModel>.value(value: quizViewModel),
            ChangeNotifierProvider<ScoreViewModel>.value(value: scoreViewModel),
          ],
          child: MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(size: Size(800, 1200)),
              child: SizedBox(
                height: 800,
                child: const QuizView(),
              ),
            ),
          ),
        ),
      );

      // Aguarda a renderização completa
      await tester.pumpAndSettle();

      // Select answer and move to next question
      await tester.tap(find.byType(ListQuizItemWidget).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('NEXT'));
      await tester.pumpAndSettle();

      // Verify second question is displayed
      expect(find.text('What is 2+2?'), findsOneWidget);

      // Verify progress track updated
      expect(find.byType(ProgressTrackWidget), findsOneWidget);
      expect(find.text('2/2'), findsOneWidget);
    });

    testWidgets('Timer should stop when quiz is complete', (
      WidgetTester tester,
    ) async {
      // Garante que as opções foram definidas
      expect(quizViewModel.currentQuestionOptions.length, equals(4));

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<MainViewModel>.value(value: mainViewModel),
            ChangeNotifierProvider<QuizViewModel>.value(value: quizViewModel),
            ChangeNotifierProvider<ScoreViewModel>.value(value: scoreViewModel),
          ],
          child: MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(size: Size(800, 1200)),
              child: SizedBox(
                height: 800,
                child: const QuizView(),
              ),
            ),
          ),
        ),
      );

      // Aguarda a renderização completa
      await tester.pumpAndSettle();

      // Answer first question
      await tester.tap(find.byType(ListQuizItemWidget).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('NEXT'));
      await tester.pumpAndSettle();

      // Answer second question
      await tester.tap(find.byType(ListQuizItemWidget).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('NEXT'));
      await tester.pumpAndSettle();

      // Verify quiz is complete and timer is stopped
      expect(quizViewModel.isCronRunning, isFalse);
    });

    testWidgets('Close button should navigate to home', (
      WidgetTester tester,
    ) async {
      // Garante que as opções foram definidas
      expect(quizViewModel.currentQuestionOptions.length, equals(4));

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<MainViewModel>.value(value: mainViewModel),
            ChangeNotifierProvider<QuizViewModel>.value(value: quizViewModel),
            ChangeNotifierProvider<ScoreViewModel>.value(value: scoreViewModel),
          ],
          child: MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(size: Size(800, 1200)),
              child: SizedBox(
                height: 800,
                child: const QuizView(),
              ),
            ),
            routes: {
              Routes.home:
                  (context) =>
                      const Scaffold(body: Center(child: Text('Home Screen'))),
            },
          ),
        ),
      );

      // Aguarda a renderização completa
      await tester.pumpAndSettle();

      // Tap close button
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      // Verify navigation to home
      expect(find.text('Home Screen'), findsOneWidget);
    });
  });
}
