
import 'package:walkie_talkie/models/weather/weather_condition.dart';

import 'current_weather.dart';

class ForecastItem {
  final DateTime dateTime;
  final double temp;
  final WeatherCondition condition;
  final String icon;

  ForecastItem({
    required this.dateTime,
    required this.temp,
    required this.condition,
    required this.icon,
  });

  factory ForecastItem.fromJson(Map<String, dynamic> json) {
    return ForecastItem(
      dateTime: DateTime.parse(json['dt_txt']),
      temp: (json['main']['temp'] as num).toDouble(),
      condition: WeatherCondition.fromJson(json['weather'][0]),
      icon: json['weather'][0]['icon'],
    );
  }
}

class ForecastResponse {
  final String cityName;
  final List<ForecastItem> items;

  ForecastResponse({
    required this.cityName,
    required this.items,
  });

  factory ForecastResponse.fromJson(Map<String, dynamic> json) {
    final city = json['city']['name'] as String;
    final list = (json['list'] as List)
        .map((e) => ForecastItem.fromJson(e))
        .toList();

    return ForecastResponse(
      cityName: city,
      items: list,
    );
  }
}
