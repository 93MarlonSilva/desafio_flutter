import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizchallenge/widgets/cron_quiz_widget.dart';

void main() {
  group('CronQuizWidget Tests', () {
    testWidgets('should display correct time', (WidgetTester tester) async {
      final isRunning = ValueNotifier<bool>(true);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CronQuizWidget(
              isRunning: isRunning,
              initialSeconds: 60,
              onTimeUpdate: (time) {},
              onTimeEnd: () {},
            ),
          ),
        ),
      );

      expect(find.text('60'), findsOneWidget);
    });

    testWidgets('should call onTimeUp when time reaches zero', (WidgetTester tester) async {
      final isRunning = ValueNotifier<bool>(true);
      var timeUpCalled = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CronQuizWidget(
              isRunning: isRunning,
              initialSeconds: 1,
              onTimeUpdate: (time) {},
              onTimeEnd: () {
                timeUpCalled = true;
              },
            ),
          ),
        ),
      );

      // Check if time is displayed correctly
      expect(find.text('1'), findsOneWidget);

      // Wait 1 second for time to reach zero
      await tester.pump(const Duration(seconds: 1));

      // Check if time was updated to zero
      expect(find.text('0'), findsOneWidget);

      // Wait longer to ensure callback is called
      await tester.pump(const Duration(seconds: 2));

      // Check if callback was called
      expect(timeUpCalled, isTrue);
    });
  });
} 