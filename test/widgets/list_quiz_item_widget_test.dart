import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizchallenge/widgets/list_quiz_item_widget.dart';

void main() {
  group('ListQuizItemWidget Tests', () {
    testWidgets('should display correct text and letter', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListQuizItemWidget(
              letter: 'A',
              text: 'Test Option',
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('A'), findsOneWidget);
      expect(find.text('Test Option'), findsOneWidget);
    });

    testWidgets('should show selected state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListQuizItemWidget(
              letter: 'A',
              text: 'Test Option',
              isSelected: true,
              onTap: () {},
            ),
          ),
        ),
      );

      // Check if widget has selection color
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('should call onTap when tapped', (WidgetTester tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListQuizItemWidget(
              letter: 'A',
              text: 'Test Option',
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ListQuizItemWidget));
      expect(tapped, isTrue);
    });
  });
} 