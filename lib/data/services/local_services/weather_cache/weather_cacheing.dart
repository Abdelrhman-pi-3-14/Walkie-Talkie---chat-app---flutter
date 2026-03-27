// data/services/local_services/weather_cache/weather_cacheing.dart
import 'package:hive_flutter/hive_flutter.dart';
import 'package:walkie_talkie/data/models/weather/current_weather.dart';
import 'package:walkie_talkie/data/models/weather/forecast_weather.dart';

class WeatherCaching {
  final Box currentWeatherBox;
  final Box forecastBox;

  WeatherCaching({required this.currentWeatherBox, required this.forecastBox});

  // Cache current weather
  Future<void> cacheCurrentWeather(CurrentWeather data) async {
    await currentWeatherBox.clear();
    await currentWeatherBox.put('current_weather', data);
  }

  // Cache forecast weather
  Future<void> cacheForecast(ForecastResponse data) async {
    await forecastBox.clear();
    await forecastBox.put('forecast', data);
  }

  // Get cached current weather
  CurrentWeather? getCachedCurrentWeather() {
    return currentWeatherBox.get('current_weather');
  }

  // Get cached forecast
  ForecastResponse? getCachedForecast() {
    return forecastBox.get('forecast');
  }
}
