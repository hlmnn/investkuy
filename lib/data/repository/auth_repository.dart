import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:investkuy/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  late final Dio _dio;

  // Constructor
  AuthRepository() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "http://18.140.79.85",
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
    } on DioException catch (e) {
      log(e.response!.statusCode.toString());
      log(e.message.toString());
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
    } on DioException catch (e) {
      log(e.response!.statusCode.toString());
      log(e.message.toString());
      rethrow;
    }
  }

  Future<String> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userToken = prefs.getString('token') ?? "";
      return userToken;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getRole() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userRole = prefs.getString('role') ?? "Visitor";
      return userRole;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> saveUser(String token, String role, String username, int id, bool isVerified) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString("role", role);
      await prefs.setString("username", username);
      await prefs.setInt("id", id);
      await prefs.setBool('isVerified', isVerified);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('role');
      await prefs.remove('username');
      await prefs.remove('id');
      await prefs.remove('isVerified');
      return true;
    } catch (e) {
      rethrow;
    }
  }
}