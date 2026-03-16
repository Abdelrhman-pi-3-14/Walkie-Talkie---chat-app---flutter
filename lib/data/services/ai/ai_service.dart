// data/services/ai/ai_service.dart
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:walkie_talkie/data/network/dio_clint.dart';

class AiService {
  final Dio _dio = DioClient().dio;

  static const String _baseUrl = "http://10.0.2.2:8000/api/ai/chat/";
  static const String _loginUrl = "http://10.0.2.2:8000/api/accounts/login/";

  String _reply = "";
  String _emotion = "";
  String? _token;
  bool _isLoading = false;

  String get reply => _reply;
  String get emotion => _emotion;
  bool get isLoading => _isLoading ;

  Future<void> _login() async {
    if (_token != null) return;

    final response = await _dio.post(
      _loginUrl,
      data: {
        'phone_number': '01016082335',
        'password': '123456',
      },
    );

    _token = response.data['access'];
    _dio.options.headers["Authorization"] = "Bearer $_token";
  }

  Future<void> sendMessageToAi({
    required bool imageMode,
    required String prompt,
  }) async {
    try {
      await _login();

      final response = await _dio.post(
        _baseUrl,
        data: {
          'prompt': prompt,
          'mode': imageMode ? 'image' : 'text',
        },
      );

      _isLoading = true;
      if (response.statusCode == 200 || response.statusCode == 201) {

        final data = _cleanJson(response.data['output']);
        final jsonData = jsonDecode(data);

        _emotion = jsonData['emotion'] ?? "neutral";
        _reply = jsonData['reply'] ?? "No reply received.";
        _isLoading = false;
        print("AI Emotion: $_emotion");
        print("AI Reply: $_reply");
      }
    } on DioException catch (e) {
      print("Dio error: ${e.message}");
    } catch (e) {
      print("Unexpected error: $e");
    }
  }


  String _cleanJson(String input) {
    final start = input.indexOf('{');
    final end = input.lastIndexOf('}');
    return input.substring(start, end + 1);
  }

  }