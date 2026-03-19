// data/services/local_services/weather_cache/weather_cacheing.dart
import 'package:hive_flutter/adapters.dart';
import 'package:walkie_talkie/data/models/weather/current_weather.dart';
import 'package:walkie_talkie/data/models/weather/forecast_weather.dart';

class WeatherCacheing {
  final Box box;

  WeatherCacheing({required this.box});

  Future<void> cacheingCurrentWeather(CurrentWeather data) async {
    if (box.get('current_weather') == null) {
      await box.put('current_weather', data);
    } else {
      await box.delete('current_weather');
      await box.put('current_weather', data);
    }
  }

  Future<void> cacheingForeCast(ForecastResponse data) async {
    if (box.get('forecast') == null) {
      await box.put('forecast', data);
    } else {
      await box.delete('forecast');
      await box.put('forecast', data);
    }
  }

  Future<CurrentWeather> displayCachedCurrentWeather() async {
    return box.get("current_Weather");
  }

  Future<ForecastResponse> displayCachedForeCast() async {
    return box.get('forecast');
  }
}
