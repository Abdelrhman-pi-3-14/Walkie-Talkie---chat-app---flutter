import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:walkie_talkie/constants/constants.dart';
import '../../models/weather/current_weather.dart';
import '../../models/weather/forecast_weather.dart';


class WeatherService {
  final Dio dio;
  final String apiKey;

  WeatherService({required this.apiKey, Dio? dio})
      : dio = dio ?? Dio();

  Future<CurrentWeather> getCurrentWeather(String cityName) async {
    final response = await dio.get(
      baseWeatherUrl,
      queryParameters: {
        "q": cityName,
        "appid": apiKey,
        "units": "metric",
      },
    );

    if (kDebugMode) {
    }
    return CurrentWeather.fromJson(response.data);
  }

  Future<ForecastResponse> getForecast(String cityName) async {
    final response = await dio.get(
      baseForecastUrl,
      queryParameters: {
        "q": cityName,
        "appid": apiKey,
        "units": "metric",
      },
    );

    return ForecastResponse.fromJson(response.data);
  }
}
