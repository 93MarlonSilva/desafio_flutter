// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_history_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuizHistoryModelAdapter extends TypeAdapter<QuizHistoryModel> {
  @override
  final int typeId = 0;

  @override
  QuizHistoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuizHistoryModel(
      date: fields[0] as DateTime,
      totalTime: fields[1] as int,
      score: fields[2] as int,
      correctAnswers: fields[3] as int,
      wrongAnswers: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, QuizHistoryModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.totalTime)
      ..writeByte(2)
      ..write(obj.score)
      ..writeByte(3)
      ..write(obj.correctAnswers)
      ..writeByte(4)
      ..write(obj.wrongAnswers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizHistoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
