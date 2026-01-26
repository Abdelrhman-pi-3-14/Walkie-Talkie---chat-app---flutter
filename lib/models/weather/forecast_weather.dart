


import 'package:walkie_talkie/models/weather/weather_condition.dart';

class ForecastWeather {
  final DateTime dateTime;
  final double temp;
  final WeatherCondition condition;
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
}

class ForecastResponse {
  final String cityName;
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

    return ForecastResponse(
      cityName: city,
      items: list,
    );
  }
}
