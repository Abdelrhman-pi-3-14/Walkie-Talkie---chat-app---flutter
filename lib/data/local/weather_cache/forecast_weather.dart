// data/local/weather_cache/forecast_weather.dart
import 'package:hive/hive.dart';
import 'package:walkie_talkie/data/models/weather/weather_condition.dart' show WeatherCondition;

part 'forecast_weather.g.dart';

@HiveType(typeId: 2)
class ForecastWeather extends HiveObject {
  @HiveField(0)
  final DateTime dateTime;

  @HiveField(1)
  final double temp;

  @HiveField(2)
  final WeatherCondition condition;
  

  @HiveField(3)
  final String icon;

  ForecastWeather({
    required this.dateTime,
    required this.temp,
    required this.condition,
    required this.icon,
  });

  factory ForecastWeather.fromJson(Map<String, dynamic> json) {
    return ForecastWeather(
      dateTime: DateTime.parse(json['dt_txt']),
      temp: (json['main']['temp'] as num).toDouble(),
      condition: WeatherCondition.fromJson(json['weather'][0]),
      icon: json['weather'][0]['icon'],
    );
  }

  Map<String, dynamic> toJson() => {
        'dt_txt': dateTime.toIso8601String(),
        'main': {'temp': temp},
      };
}

@HiveType(typeId: 3)
class ForecastResponse extends HiveObject {
  @HiveField(0)
  final String cityName;

  @HiveField(1)
  final List<ForecastWeather> items;

  ForecastResponse({
    required this.cityName,
    required this.items,
  });

  factory ForecastResponse.fromJson(Map<String, dynamic> json) {
    final city = json['city']['name'] as String;
    final list = (json['list'] as List)
        .map((e) => ForecastWeather.fromJson(e))
        .toList();

    return ForecastResponse(cityName: city, items: list);
  }

  Map<String, dynamic> toJson() => {
        'city': {'name': cityName},
        'list': items.map((e) => e.toJson()).toList(),
      };
}