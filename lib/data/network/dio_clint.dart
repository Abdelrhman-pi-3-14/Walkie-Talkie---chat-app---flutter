// data/network/dio_clint.dart
import 'package:dio/dio.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();

  factory DioClient() => _instance;

  late final Dio dio;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        request: false,
  requestHeader: false,
  requestBody: false,
  responseHeader: false,
  responseBody: true,
      ),
    );
  }
}
