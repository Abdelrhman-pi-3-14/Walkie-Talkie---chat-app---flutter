// data/repositories/weather_repo.dart
import 'package:walkie_talkie/data/models/weather/current_weather.dart';
import 'package:walkie_talkie/data/models/weather/forecast_weather.dart';
import 'package:walkie_talkie/data/services/local_services/weather_cache/weather_cacheing.dart';
import 'package:walkie_talkie/data/services/web_services/weather/weather_service.dart';

class WeatherRepository {
  final WeatherService weatherService;
  final WeatherCaching weatherCacheing;

  WeatherRepository({
    required this.weatherService,
    required this.weatherCacheing,
  });

  /// Always return cached current weather
  CurrentWeather? getCachedCurrentWeather() {
    return weatherCacheing.getCachedCurrentWeather();
  }

  /// Always return cached forecast
  ForecastResponse? getCachedForecast() {
    return weatherCacheing.getCachedForecast();
  }

  /// Optional: Update cache in background
  Future<CurrentWeather?> updateCurrentWeather(String cityName) async {
    try {
      final currentWeather = await weatherService.getCurrentWeather(cityName);
      await weatherCacheing.cacheCurrentWeather(currentWeather);
      return currentWeather;
    } catch (_) {
      // Ignore errors, keep cached data
      return weatherCacheing.getCachedCurrentWeather();
    }
  }

  Future<ForecastResponse?> updateForecastWeather(String cityName) async {
    try {
      final forecast = await weatherService.getForecast(cityName);
      await weatherCacheing.cacheForecast(forecast);
      return forecast;
    } catch (_) {
      // Ignore errors, keep cached data
      return weatherCacheing.getCachedForecast();
    }
  }
}
