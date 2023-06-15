import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:investkuy/data/model/umkm_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RiwayatRepository {
  late final Dio _dio;

  // Constructor
  RiwayatRepository() {
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

  Future<List<RiwayatCrowdfundingModel>> getAll() async {
    try {
      final username = await getUsername();
      final response = await _dio.get('/riwayat-crowdfunding/$username');

      List<RiwayatCrowdfundingModel> data = [];
      for (var value in response.data['data']) {
        data.add(RiwayatCrowdfundingModel.fromJson(value));
      }
      return data;
    } on DioException catch (e) {
      log(e.response!.statusCode.toString());
      log(e.message.toString());
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
}
