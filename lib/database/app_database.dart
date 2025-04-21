import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

@DataClassName('QuizHistory')
class QuizHistoryTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  IntColumn get totalTime => integer()();
  IntColumn get score => integer()();
  IntColumn get correctAnswers => integer()();
  IntColumn get wrongAnswers => integer()();
}

@DriftDatabase(tables: [QuizHistoryTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection()) {
    print('AppDatabase initialized');
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        print('Creating database tables');
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        print('Upgrading database from version $from to $to');
        // Implementar upgrade se necessário
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    print('Opening database connection');
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'quiz_history.sqlite'));
    print('Database file path: ${file.path}');

    // Verifica se o arquivo existe
    if (!await file.exists()) {
      print('Database file does not exist, creating new database');
      await file.create(recursive: true);
    }

    // Cria o banco de dados de forma síncrona
    return NativeDatabase(file);
  });
}
