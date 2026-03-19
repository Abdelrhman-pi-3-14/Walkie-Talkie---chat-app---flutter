// data/services/web_services/weather/weather_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:walkie_talkie/constants/constants.dart';
import '../../../models/weather/current_weather.dart';
import '../../../models/weather/forecast_weather.dart';
import '../../../network/dio_clint.dart';


class WeatherService {
  
  final Dio _dioClient = DioClient().dio;
   String? apiKey = dotenv.env['WEATHER_API_KEY'];

  

  Future<CurrentWeather> getCurrentWeather(String cityName) async {
    final response = await _dioClient.get(
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
    final response = await _dioClient.get(
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
