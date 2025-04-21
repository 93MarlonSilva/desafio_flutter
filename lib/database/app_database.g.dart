// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $QuizHistoryTableTable extends QuizHistoryTable
    with TableInfo<$QuizHistoryTableTable, QuizHistory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuizHistoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalTimeMeta = const VerificationMeta(
    'totalTime',
  );
  @override
  late final GeneratedColumn<int> totalTime = GeneratedColumn<int>(
    'total_time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _correctAnswersMeta = const VerificationMeta(
    'correctAnswers',
  );
  @override
  late final GeneratedColumn<int> correctAnswers = GeneratedColumn<int>(
    'correct_answers',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wrongAnswersMeta = const VerificationMeta(
    'wrongAnswers',
  );
  @override
  late final GeneratedColumn<int> wrongAnswers = GeneratedColumn<int>(
    'wrong_answers',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    totalTime,
    score,
    correctAnswers,
    wrongAnswers,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quiz_history_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuizHistory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('total_time')) {
      context.handle(
        _totalTimeMeta,
        totalTime.isAcceptableOrUnknown(data['total_time']!, _totalTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_totalTimeMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('correct_answers')) {
      context.handle(
        _correctAnswersMeta,
        correctAnswers.isAcceptableOrUnknown(
          data['correct_answers']!,
          _correctAnswersMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_correctAnswersMeta);
    }
    if (data.containsKey('wrong_answers')) {
      context.handle(
        _wrongAnswersMeta,
        wrongAnswers.isAcceptableOrUnknown(
          data['wrong_answers']!,
          _wrongAnswersMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_wrongAnswersMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuizHistory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuizHistory(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      date:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}date'],
          )!,
      totalTime:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}total_time'],
          )!,
      score:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}score'],
          )!,
      correctAnswers:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}correct_answers'],
          )!,
      wrongAnswers:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}wrong_answers'],
          )!,
    );
  }

  @override
  $QuizHistoryTableTable createAlias(String alias) {
    return $QuizHistoryTableTable(attachedDatabase, alias);
  }
}

class QuizHistory extends DataClass implements Insertable<QuizHistory> {
  final int id;
  final DateTime date;
  final int totalTime;
  final int score;
  final int correctAnswers;
  final int wrongAnswers;
  const QuizHistory({
    required this.id,
    required this.date,
    required this.totalTime,
    required this.score,
    required this.correctAnswers,
    required this.wrongAnswers,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['total_time'] = Variable<int>(totalTime);
    map['score'] = Variable<int>(score);
    map['correct_answers'] = Variable<int>(correctAnswers);
    map['wrong_answers'] = Variable<int>(wrongAnswers);
    return map;
  }

  QuizHistoryTableCompanion toCompanion(bool nullToAbsent) {
    return QuizHistoryTableCompanion(
      id: Value(id),
      date: Value(date),
      totalTime: Value(totalTime),
      score: Value(score),
      correctAnswers: Value(correctAnswers),
      wrongAnswers: Value(wrongAnswers),
    );
  }

  factory QuizHistory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuizHistory(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      totalTime: serializer.fromJson<int>(json['totalTime']),
      score: serializer.fromJson<int>(json['score']),
      correctAnswers: serializer.fromJson<int>(json['correctAnswers']),
      wrongAnswers: serializer.fromJson<int>(json['wrongAnswers']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'totalTime': serializer.toJson<int>(totalTime),
      'score': serializer.toJson<int>(score),
      'correctAnswers': serializer.toJson<int>(correctAnswers),
      'wrongAnswers': serializer.toJson<int>(wrongAnswers),
    };
  }

  QuizHistory copyWith({
    int? id,
    DateTime? date,
    int? totalTime,
    int? score,
    int? correctAnswers,
    int? wrongAnswers,
  }) => QuizHistory(
    id: id ?? this.id,
    date: date ?? this.date,
    totalTime: totalTime ?? this.totalTime,
    score: score ?? this.score,
    correctAnswers: correctAnswers ?? this.correctAnswers,
    wrongAnswers: wrongAnswers ?? this.wrongAnswers,
  );
  QuizHistory copyWithCompanion(QuizHistoryTableCompanion data) {
    return QuizHistory(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      totalTime: data.totalTime.present ? data.totalTime.value : this.totalTime,
      score: data.score.present ? data.score.value : this.score,
      correctAnswers:
          data.correctAnswers.present
              ? data.correctAnswers.value
              : this.correctAnswers,
      wrongAnswers:
          data.wrongAnswers.present
              ? data.wrongAnswers.value
              : this.wrongAnswers,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuizHistory(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('totalTime: $totalTime, ')
          ..write('score: $score, ')
          ..write('correctAnswers: $correctAnswers, ')
          ..write('wrongAnswers: $wrongAnswers')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, date, totalTime, score, correctAnswers, wrongAnswers);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuizHistory &&
          other.id == this.id &&
          other.date == this.date &&
          other.totalTime == this.totalTime &&
          other.score == this.score &&
          other.correctAnswers == this.correctAnswers &&
          other.wrongAnswers == this.wrongAnswers);
}

class QuizHistoryTableCompanion extends UpdateCompanion<QuizHistory> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<int> totalTime;
  final Value<int> score;
  final Value<int> correctAnswers;
  final Value<int> wrongAnswers;
  const QuizHistoryTableCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.totalTime = const Value.absent(),
    this.score = const Value.absent(),
    this.correctAnswers = const Value.absent(),
    this.wrongAnswers = const Value.absent(),
  });
  QuizHistoryTableCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required int totalTime,
    required int score,
    required int correctAnswers,
    required int wrongAnswers,
  }) : date = Value(date),
       totalTime = Value(totalTime),
       score = Value(score),
       correctAnswers = Value(correctAnswers),
       wrongAnswers = Value(wrongAnswers);
  static Insertable<QuizHistory> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<int>? totalTime,
    Expression<int>? score,
    Expression<int>? correctAnswers,
    Expression<int>? wrongAnswers,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (totalTime != null) 'total_time': totalTime,
      if (score != null) 'score': score,
      if (correctAnswers != null) 'correct_answers': correctAnswers,
      if (wrongAnswers != null) 'wrong_answers': wrongAnswers,
    });
  }

  QuizHistoryTableCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<int>? totalTime,
    Value<int>? score,
    Value<int>? correctAnswers,
    Value<int>? wrongAnswers,
  }) {
    return QuizHistoryTableCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      totalTime: totalTime ?? this.totalTime,
      score: score ?? this.score,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      wrongAnswers: wrongAnswers ?? this.wrongAnswers,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (totalTime.present) {
      map['total_time'] = Variable<int>(totalTime.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (correctAnswers.present) {
      map['correct_answers'] = Variable<int>(correctAnswers.value);
    }
    if (wrongAnswers.present) {
      map['wrong_answers'] = Variable<int>(wrongAnswers.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuizHistoryTableCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('totalTime: $totalTime, ')
          ..write('score: $score, ')
          ..write('correctAnswers: $correctAnswers, ')
          ..write('wrongAnswers: $wrongAnswers')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $QuizHistoryTableTable quizHistoryTable = $QuizHistoryTableTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [quizHistoryTable];
}

typedef $$QuizHistoryTableTableCreateCompanionBuilder =
    QuizHistoryTableCompanion Function({
      Value<int> id,
      required DateTime date,
      required int totalTime,
      required int score,
      required int correctAnswers,
      required int wrongAnswers,
    });
typedef $$QuizHistoryTableTableUpdateCompanionBuilder =
    QuizHistoryTableCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<int> totalTime,
      Value<int> score,
      Value<int> correctAnswers,
      Value<int> wrongAnswers,
    });

class $$QuizHistoryTableTableFilterComposer
    extends Composer<_$AppDatabase, $QuizHistoryTableTable> {
  $$QuizHistoryTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalTime => $composableBuilder(
    column: $table.totalTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctAnswers => $composableBuilder(
    column: $table.correctAnswers,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wrongAnswers => $composableBuilder(
    column: $table.wrongAnswers,
    builder: (column) => ColumnFilters(column),
  );
}

class $$QuizHistoryTableTableOrderingComposer
    extends Composer<_$AppDatabase, $QuizHistoryTableTable> {
  $$QuizHistoryTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalTime => $composableBuilder(
    column: $table.totalTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctAnswers => $composableBuilder(
    column: $table.correctAnswers,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wrongAnswers => $composableBuilder(
    column: $table.wrongAnswers,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$QuizHistoryTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuizHistoryTableTable> {
  $$QuizHistoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get totalTime =>
      $composableBuilder(column: $table.totalTime, builder: (column) => column);

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<int> get correctAnswers => $composableBuilder(
    column: $table.correctAnswers,
    builder: (column) => column,
  );

  GeneratedColumn<int> get wrongAnswers => $composableBuilder(
    column: $table.wrongAnswers,
    builder: (column) => column,
  );
}

class $$QuizHistoryTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuizHistoryTableTable,
          QuizHistory,
          $$QuizHistoryTableTableFilterComposer,
          $$QuizHistoryTableTableOrderingComposer,
          $$QuizHistoryTableTableAnnotationComposer,
          $$QuizHistoryTableTableCreateCompanionBuilder,
          $$QuizHistoryTableTableUpdateCompanionBuilder,
          (
            QuizHistory,
            BaseReferences<_$AppDatabase, $QuizHistoryTableTable, QuizHistory>,
          ),
          QuizHistory,
          PrefetchHooks Function()
        > {
  $$QuizHistoryTableTableTableManager(
    _$AppDatabase db,
    $QuizHistoryTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$QuizHistoryTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$QuizHistoryTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$QuizHistoryTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> totalTime = const Value.absent(),
                Value<int> score = const Value.absent(),
                Value<int> correctAnswers = const Value.absent(),
                Value<int> wrongAnswers = const Value.absent(),
              }) => QuizHistoryTableCompanion(
                id: id,
                date: date,
                totalTime: totalTime,
                score: score,
                correctAnswers: correctAnswers,
                wrongAnswers: wrongAnswers,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required int totalTime,
                required int score,
                required int correctAnswers,
                required int wrongAnswers,
              }) => QuizHistoryTableCompanion.insert(
                id: id,
                date: date,
                totalTime: totalTime,
                score: score,
                correctAnswers: correctAnswers,
                wrongAnswers: wrongAnswers,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$QuizHistoryTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuizHistoryTableTable,
      QuizHistory,
      $$QuizHistoryTableTableFilterComposer,
      $$QuizHistoryTableTableOrderingComposer,
      $$QuizHistoryTableTableAnnotationComposer,
      $$QuizHistoryTableTableCreateCompanionBuilder,
      $$QuizHistoryTableTableUpdateCompanionBuilder,
      (
        QuizHistory,
        BaseReferences<_$AppDatabase, $QuizHistoryTableTable, QuizHistory>,
      ),
      QuizHistory,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$QuizHistoryTableTableTableManager get quizHistoryTable =>
      $$QuizHistoryTableTableTableManager(_db, _db.quizHistoryTable);
}
