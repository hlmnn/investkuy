import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:investkuy/data/model/umkm_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UmkmRepository {
  late final Dio _dio;

  // Constructor
  UmkmRepository() {
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

  Future<List<UmkmModel>> getAllPengajuan(
    String page,
    String pageSize,
    String sort,
    String order,
    String tenor,
    String sektor,
    String plafond,
  ) async {
    try {
      final response = await _dio.get(
          "/pengajuan/list?page=$page&pageSize=$pageSize&sort=$sort&order=$order&tenor=$tenor&sektor=$sektor&plafond=$plafond");
      List<UmkmModel> data = [];
      for (var val in response.data['data']) {
        data.add(UmkmModel.fromJson(val));
      }
      return data;
    } on DioException catch (e) {
      log(e.response!.statusCode.toString());
      log(e.message.toString());
      rethrow;
    }
  }
  
  Future<DetailUmkmModel> getDetailUmkm(String id) async {
    try {
      final userId = await getId();
      final response = await _dio.get("/pengajuan-details/$id/$userId");
      final data = DetailUmkmModel.fromJson(response.data['data']);
      return data;
    } on DioException catch (e) {
      log(e.response!.statusCode.toString());
      log(e.message.toString());
      rethrow;
    }
  }

  Future<int> getId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getInt('id') ?? 0;
      return id;
    } catch (e) {
      rethrow;
    }
  }
}
