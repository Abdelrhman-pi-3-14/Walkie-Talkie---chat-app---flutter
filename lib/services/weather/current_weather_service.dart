import 'package:dio/dio.dart';
import 'package:walkie_talkie/constants/constants.dart';

class CurrentWeatherService {

  final Dio dio;

  static final baseURL = baseWeatherUrl;

  final String apiKey ;


  CurrentWeatherService({
    required this.apiKey,
    Dio? dio,
  }) : dio = dio ?? Dio();




}




