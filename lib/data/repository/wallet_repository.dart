import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletRepository {
  late final Dio _dio;

  // Constructor
  WalletRepository() {
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

  Future<bool> postPendanaan(String nominal, int pengajuanId) async {
    try {
      final id = await getId();
      await _dio.post("/pendanaan/$pengajuanId/$id", data: {
        "nominal": nominal,
      });
      return true;
    } on DioException catch (e) {
      log(e.response!.statusCode.toString());
      log(e.message.toString());
      rethrow;
    }
  }
  
  Future<bool> cancelPendanaan(int pengajuanId) async {
    try {
      final id = await getId();
      await _dio.put("/pendanaan/cancel/$pengajuanId/$id");
      return true;
    } on DioException catch (e) {
      log(e.response!.statusCode.toString());
      log(e.message.toString());
      rethrow;
    }
  }

  Future<bool> withdrawPendanaan(int pendanaanId) async {
    try {
      await _dio.put("/pendanaan/$pendanaanId/tarik-pendanaan");
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

  Future<String> getUsername() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final username = prefs.getString('username') ?? "";
      return username;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getInt('id') ?? 1;
      return id;
    } catch (e) {
      rethrow;
    }
  }
}
