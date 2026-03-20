// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_weather.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ForecastWeatherAdapter extends TypeAdapter<ForecastWeather> {
  @override
  final int typeId = 2;

  @override
  ForecastWeather read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ForecastWeather(
      dateTime: fields[0] as DateTime,
      temp: fields[1] as double,
      condition: fields[2] as WeatherCondition,
      icon: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ForecastWeather obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.dateTime)
      ..writeByte(1)
      ..write(obj.temp)
      ..writeByte(2)
      ..write(obj.condition)
      ..writeByte(3)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForecastWeatherAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ForecastResponseAdapter extends TypeAdapter<ForecastResponse> {
  @override
  final int typeId = 3;

  @override
  ForecastResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ForecastResponse(
      cityName: fields[0] as String,
      items: (fields[1] as List).cast<ForecastWeather>(),
    );
  }

  @override
  void write(BinaryWriter writer, ForecastResponse obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.cityName)
      ..writeByte(1)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForecastResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
