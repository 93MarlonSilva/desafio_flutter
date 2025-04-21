import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:quizchallenge/main.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quizchallenge/models/quiz_history_model.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for testing
  await Hive.initFlutter();
  
  // Register adapters
  Hive.registerAdapter(QuizHistoryModelAdapter());
  
  // Open boxes
  await Hive.openBox<QuizHistoryModel>('quizHistory');

  group('Quiz Flow Integration Test', () {
    tearDownAll(() async {
      // Clean up Hive after testing
      await Hive.close();
    });

    testWidgets('Complete quiz flow', (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(const MyApp());

      // Wait for the app to initialize
      await tester.pumpAndSettle();

      // Verify we're on the home screen
      expect(find.text('START QUIZ'), findsOneWidget);

      // Select category from dropdown
      await tester.tap(find.byKey(const Key('category_dropdown')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Any').last);
      await tester.pumpAndSettle();

      // Select difficulty from dropdown
      await tester.tap(find.byKey(const Key('difficulty_dropdown')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Easy').last);
      await tester.pumpAndSettle();

      // Select amount from dropdown
      await tester.tap(find.byKey(const Key('amount_dropdown')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('5').last);
      await tester.pumpAndSettle();

      // Start quiz
      await tester.tap(find.byKey(const Key('start_quiz_button')));
      await tester.pumpAndSettle();

      // Wait for questions to load
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Answer questions
      for (int i = 0; i < 5; i++) {
        // Select first option as answer
        await tester.tap(find.byKey(Key('quiz_option_0')));
        await tester.pumpAndSettle();

        // Click continue button
        await tester.tap(find.text('NEXT'));
        await tester.pumpAndSettle();

        // Wait for next question
        await tester.pumpAndSettle();
      }

      // Verify we're on the score screen by checking for any text containing "Quiz result"
      expect(find.textContaining('Quiz result'), findsOneWidget);

      // Close score screen
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      // Verify we're back on home screen
      expect(find.text('START QUIZ'), findsOneWidget);
    });
  });
} 