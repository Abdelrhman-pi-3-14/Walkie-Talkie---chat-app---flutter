import 'package:dio/dio.dart';
import 'package:walkie_talkie/models/ai/ai_text_data.dart';
import 'package:walkie_talkie/network/dio_clint.dart';

class AiService {
  final Dio _dio = DioClient().dio;
  final String baseUrl = "http://10.0.2.2:8000/api/ai/chat/";
  final String loginUrl = "http://10.0.2.2:8000/api/accounts/login/";

  Future<void> sendMessageToAi(bool imageMode, String prompt) async {




    final ai = AiTextData(sender: "user", content: prompt, time: DateTime.now().toString());

    print("Logging in...");
    final loginRes = await _dio.post(
    loginUrl
    , data: {
      'phone_number': '01016082335',
      'password': '123456',
    });
    final token = loginRes.data['access'];
    print("Login success! Token: $token");
    // 2. Add the token to Dio headers for all future calls
    _dio.options.headers["Authorization"] = "Bearer $token";
    // 3. Test the AI Chat immediately
    print("Testing AI Chat...");
    if (imageMode == false) {
      try {
        final response = await _dio.post(
          baseUrl,
          data: {
            'prompt': prompt,
            'mode': 'text'
          },

        );

        if(response.statusCode == 200 || response.statusCode == 201){
          print("Message sent successfully!");
          print("Ai Response: ${response.data}");
        }
      } on DioException catch(e) {
        print("A Dio error occurred: $e");
      } catch (e) {
        print("An unknown error occurred: $e");
      }
    } else {}
  }
}
