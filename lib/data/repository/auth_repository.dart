import 'package:dio/dio.dart';
import 'package:investkuy/data/model/user_model.dart';

class AuthRepository {
  late final Dio _dio;

  // Constructor
  AuthRepository() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "http://18.140.79.85/",
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );
    // Log Interceptor
    _dio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
  }

  Future<UserModel> login(String username, String password) async {
    try {
      final response = await _dio.post("/user/login",
          data: {"username": username, "password": password});
      final data = UserModel.fromJson(response.data['data']);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> register(String name, String email, String username,
      String password, String confirmPassword, String pin, String role) async {
    try {
      await _dio.post("/user/register", data: {
        "name": name,
        "email": email,
        "username": username,
        "password": password,
        "confirmPassword": confirmPassword,
        "pin": pin,
        "role": role
      });
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
