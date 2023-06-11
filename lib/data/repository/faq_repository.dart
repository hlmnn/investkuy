import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:investkuy/data/model/faq_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FaqRepository {
  late final Dio _dio;

  // Constructor
  FaqRepository() {
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

  Future<List<FaqModel>> faq() async {
    try {
      final response = await _dio.get("/faq");
      List<FaqModel> data = [];
      for(var val in response.data['data']) {
        data.add(FaqModel.fromJson(val));
      }
      return data;
    } on DioException catch (e) {
      log(e.response!.statusCode.toString());
      log(e.message.toString());
      rethrow;
    }
  }
}