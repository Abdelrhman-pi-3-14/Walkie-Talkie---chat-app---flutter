// data/services/auth/auth_service.dart
import 'package:dio/dio.dart';
import 'package:walkie_talkie/data/models/userdata/register_user.dart';
import 'package:walkie_talkie/data/network/dio_clint.dart';

class AuthService {

  final Dio _dioClient = DioClient().dio;


  Future<void> userRegister(RegisterUser user) async {

    try {
       final response = await _dioClient.post(
        "http://10.0.2.2:8000/api/accounts/register/",
        data: user.toJson(),
      );
    } on DioException catch (e) {
      print("❌ Error: ${e.response?.data}");
    }
  }

}
