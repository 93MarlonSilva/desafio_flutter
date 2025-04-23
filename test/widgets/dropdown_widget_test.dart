import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizchallenge/widgets/dropdown_widget.dart';

void main() {
  group('CustomDropdownWidget Tests', () {
    late String selectedValue;
    late List<String> items;
    late Function(String?) onChanged;

    setUp(() {
      selectedValue = 'Option 1';
      items = ['Option 1', 'Option 2', 'Option 3'];
      onChanged = (value) {
        selectedValue = value!;
      };
    });

    testWidgets('should display selected value', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomDropdownWidget<String>(
              value: selectedValue,
              items: items,
              onChanged: onChanged,
              label: 'Select an option',
              itemToString: (item) => item,
            ),
          ),
        ),
      );

      expect(find.text('Option 1'), findsOneWidget);
    });

    testWidgets('should show all options when tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomDropdownWidget<String>(
              value: selectedValue,
              items: items,
              onChanged: onChanged,
              label: 'Select an option',
              itemToString: (item) => item,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(CustomDropdownWidget<String>));
      await tester.pumpAndSettle();

      expect(find.text('Option 1'), findsNWidgets(2));
      expect(find.text('Option 2'), findsOneWidget);
      expect(find.text('Option 3'), findsOneWidget);
    });

    testWidgets('should call onChanged when new option is selected', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomDropdownWidget<String>(
              value: selectedValue,
              items: items,
              onChanged: onChanged,
              label: 'Select an option',
              itemToString: (item) => item,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(CustomDropdownWidget<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Option 2').last);
      await tester.pumpAndSettle();

      expect(selectedValue, equals('Option 2'));
    });
  });
}
