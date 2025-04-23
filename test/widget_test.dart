import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quizchallenge/models/quiz_history_model.dart';
import 'package:flutter/services.dart';
import 'dart:io';

void main() {
  group('Main Initialization Test', () {
    setUpAll(() async {
      // Mock path_provider
      TestWidgetsFlutterBinding.ensureInitialized();
      const channel = MethodChannel('plugins.flutter.io/path_provider');
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
            if (methodCall.method == 'getApplicationDocumentsDirectory') {
              return Directory.systemTemp.path;
            }
            return null;
          });
    });

    test('Should initialize Hive and register adapter', () async {
      // Initialize Hive
      await Hive.initFlutter();

      // Verify adapter is not registered initially
      expect(
        Hive.isAdapterRegistered(QuizHistoryModelAdapter().typeId),
        isFalse,
      );

      // Register adapter
      Hive.registerAdapter(QuizHistoryModelAdapter());

      // Verify adapter is registered
      expect(
        Hive.isAdapterRegistered(QuizHistoryModelAdapter().typeId),
        isTrue,
      );

      // Open box
      final box = await Hive.openBox<QuizHistoryModel>('quizHistory');

      // Verify box is open
      expect(box, isNotNull);
      expect(box.name, equals('quizhistory'));
      expect(box.isOpen, isTrue);
    });
  });
}
