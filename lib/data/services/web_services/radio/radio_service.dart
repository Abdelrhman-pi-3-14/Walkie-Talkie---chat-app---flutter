// data/services/web_services/radio/radio_service.dart

import 'package:dio/dio.dart';
import 'package:get_country_code_by_name/get_country_code_by_name.dart';
import '../../../../constants/radio_server_manger.dart';
import '../../../models/radio/radio_model.dart';
import '../../../network/dio_clint.dart';

class RadioService {
  final RadioServerManager _serverManager = RadioServerManager();
  final resolver = CountryCodeResolver();
  final Dio _dio = DioClient().dio;

  Future<Response> _safeGet(String path) async {
    for (int i = 0; i < _serverManager.allServers.length; i++) {
      final server = i == 0
          ? _serverManager.getRandomServer()
          : _serverManager.nextServer();

      try {
        final response = await _dio.get('$server$path');

        if (response.statusCode == 200) {
          return response;
        }
      } on DioException {
        if (i == _serverManager.allServers.length - 1) {
          rethrow;
        }
      }
    }

    throw Exception('All Radio Browser servers failed');
  }


  Future<List<RadioStation>> getTopStations({int limit = 70}) async {
    final response =
    await _safeGet('/json/stations/topclick/$limit');

    final List data = response.data as List;
    return data.map((e) => RadioStation.fromJson(e)).toList();
  }
Future<List<RadioStation>> searchWithCountry(String countryName) async {
  final code = resolver.getCountryCode(countryName);

  if (code == null || code.isEmpty) {
    throw Exception('Invalid country name: $countryName');
  }

  final response = await _safeGet(
    '/json/stations/search?countrycode=$code',
  );

  final List data = response.data as List;
  return data.map((e) => RadioStation.fromJson(e)).toList();
}

}
