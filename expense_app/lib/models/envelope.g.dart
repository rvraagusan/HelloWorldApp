// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'envelope.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EnvelopeAdapter extends TypeAdapter<Envelope> {
  @override
  final int typeId = 0;

  @override
  Envelope read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Envelope(
      name: fields[0] as String,
      budget: fields[1] as double,
      spent: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Envelope obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.budget)
      ..writeByte(2)
      ..write(obj.spent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnvelopeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
