// data/repositories/weather_repo.dart
// ignore_for_file: public_member_api_docs, sort_constructors_first
// data/repositories/weather_repo.dart
import 'package:walkie_talkie/data/models/weather/current_weather.dart';
import 'package:walkie_talkie/data/models/weather/forecast_weather.dart';
import 'package:walkie_talkie/data/services/local_services/weather_cache/weather_cacheing.dart';
import 'package:walkie_talkie/data/services/web_services/weather/weather_service.dart';

class WeatherRepository {
  final WeatherService weatherService;
  final WeatherCacheing weatherCacheing;

  WeatherRepository({
    required this.weatherService,
    required this.weatherCacheing,
  });

  Future<CurrentWeather> fetchCurrentWeather(String cityName) async {
    try {
      final currentWeather = await weatherService.getCurrentWeather(cityName);
       weatherCacheing.cacheingCurrentWeather(currentWeather);
      return currentWeather;
    } catch (e) {
      return weatherCacheing.displayCachedCurrentWeather();
    }
  }

  Future<ForecastResponse> fetchForeCastWeather(String cityName) async {
    try {
      final foreCast = await weatherService.getForecast(cityName);
      weatherCacheing.cacheingForeCast(foreCast);
      return foreCast;
    } catch (e) {
      return weatherCacheing.displayCachedForeCast();
    }
  }
}
