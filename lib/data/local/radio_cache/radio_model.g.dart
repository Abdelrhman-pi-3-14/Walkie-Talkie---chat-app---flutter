// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'radio_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RadioStationAdapter extends TypeAdapter<RadioStation> {
  @override
  final int typeId = 0;

  @override
  RadioStation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RadioStation(
      changeUuid: fields[0] as String,
      stationUuid: fields[1] as String,
      serverUuid: fields[2] as String?,
      name: fields[3] as String,
      url: fields[4] as String,
      urlResolved: fields[5] as String,
      homepage: fields[6] as String,
      favicon: fields[7] as String,
      tags: fields[8] as String,
      country: fields[9] as String,
      countryCode: fields[10] as String,
      state: fields[11] as String,
      language: fields[12] as String,
      languageCodes: fields[13] as String,
      votes: fields[14] as int,
      codec: fields[15] as String,
      bitrate: fields[16] as int,
      hls: fields[17] as bool,
      lastCheckOk: fields[18] as bool,
      clickCount: fields[20] as int,
      clickTrend: fields[21] as int,
      lastChangeTime: fields[22] as DateTime,
      clickTime: fields[23] as DateTime,
      favorite: fields[19] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, RadioStation obj) {
    writer
      ..writeByte(24)
      ..writeByte(0)
      ..write(obj.changeUuid)
      ..writeByte(1)
      ..write(obj.stationUuid)
      ..writeByte(2)
      ..write(obj.serverUuid)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.url)
      ..writeByte(5)
      ..write(obj.urlResolved)
      ..writeByte(6)
      ..write(obj.homepage)
      ..writeByte(7)
      ..write(obj.favicon)
      ..writeByte(8)
      ..write(obj.tags)
      ..writeByte(9)
      ..write(obj.country)
      ..writeByte(10)
      ..write(obj.countryCode)
      ..writeByte(11)
      ..write(obj.state)
      ..writeByte(12)
      ..write(obj.language)
      ..writeByte(13)
      ..write(obj.languageCodes)
      ..writeByte(14)
      ..write(obj.votes)
      ..writeByte(15)
      ..write(obj.codec)
      ..writeByte(16)
      ..write(obj.bitrate)
      ..writeByte(17)
      ..write(obj.hls)
      ..writeByte(18)
      ..write(obj.lastCheckOk)
      ..writeByte(19)
      ..write(obj.favorite)
      ..writeByte(20)
      ..write(obj.clickCount)
      ..writeByte(21)
      ..write(obj.clickTrend)
      ..writeByte(22)
      ..write(obj.lastChangeTime)
      ..writeByte(23)
      ..write(obj.clickTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RadioStationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
