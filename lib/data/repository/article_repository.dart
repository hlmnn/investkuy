import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:investkuy/data/model/article_model.dart';

class ArticleRepository {
  late final Dio _dio;

  ArticleRepository() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "http://18.140.79.85",
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );

    _dio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
  }

  Future<List<ArticleModel>> getAll() async {
    try {
      final response = await _dio.get('/articles');
      List<ArticleModel> data = [];
      for (var val in response.data['data']) {
        data.add(ArticleModel.fromJson(val));
      }
      return data;
    } on DioException catch (e) {
      log(e.response!.statusCode.toString());
      log(e.message.toString());
      rethrow;
    }
  }

  Future<ArticleModel> getDetails(int id) async {
    try {
      final response = await _dio.get('/articles/$id');
      final data = ArticleModel.fromJson(response.data['data']);
      return data;
    } on DioException catch (e) {
      log(e.response!.statusCode.toString());
      log(e.message.toString());
      rethrow;
    }
  }
}
