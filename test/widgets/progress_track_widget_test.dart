import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizchallenge/widgets/progress_track_widget.dart';

void main() {
  group('ProgressTrackWidget Tests', () {
    testWidgets('should display progress bar and indicator', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProgressTrackWidget(
              currentIndex: 2,
              totalQuestions: 5,
            ),
          ),
        ),
      );

      // Check if there are background bar and indicator
      expect(find.byType(Container), findsNWidgets(2));
    });

    testWidgets('should show correct progress text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProgressTrackWidget(
              currentIndex: 2,
              totalQuestions: 5,
            ),
          ),
        ),
      );

      // Check if progress text is correct
      expect(find.text('3/5'), findsOneWidget);
    });

    testWidgets('should show correct progress for first question', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProgressTrackWidget(
              currentIndex: 0,
              totalQuestions: 5,
            ),
          ),
        ),
      );

      // Check if progress text is correct for first question
      expect(find.text('1/5'), findsOneWidget);
    });

    testWidgets('should show correct progress for last question', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProgressTrackWidget(
              currentIndex: 4,
              totalQuestions: 5,
            ),
          ),
        ),
      );

      // Check if progress text is correct for last question
      expect(find.text('5/5'), findsOneWidget);
    });
  });
} 