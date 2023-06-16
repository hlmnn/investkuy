import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:investkuy/data/model/pendanaan_model.dart';
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

  Future<List<RiwayatCrowdfundingModel>> getAllCf() async {
    try {
      final username = await getUsername();
      final response = await _dio.get('/riwayat-crowdfunding/$username');

      List<RiwayatCrowdfundingModel> data = [];
      if (response.data['data'] != null) {   
        for (var value in response.data['data']) {
          data.add(RiwayatCrowdfundingModel.fromJson(value));
        }
      }
      return data;
    } on DioException catch (e) {
      log(e.response!.statusCode.toString());
      log(e.message.toString());
      rethrow;
    }
  }

  Future<List<RiwayatPaymentModel>> getAllPayment() async {
    try {
      final username = await getUsername();
      final response = await _dio.get('/riwayat-payment/$username');

      List<RiwayatPaymentModel> data = [];
      if (response.data['data'] != null) {    
        for (var value in response.data['data']) {
          data.add(RiwayatPaymentModel.fromJson(value));
        }
      }
      return data;
    } on DioException catch (e) {
      log(e.response!.statusCode.toString());
      log(e.message.toString());
      rethrow;
    }
  }
  
  Future<List<InProgressPendanaanModel>> getInProgressPendanaan() async {
    try {
      final id = await getId();
      final response = await _dio.get("/pendanaan/riwayat-in-progress/$id");
      List<InProgressPendanaanModel> data = [];
      for (var val in response.data['data']) {
        data.add(InProgressPendanaanModel.fromJson(val));
      }
      return data;
    } on DioException catch (e) {
      log(e.response!.statusCode.toString());
      log(e.message.toString());
      rethrow;
    }
  }

  Future<List<CompletedPendanaanModel>> getCompletedPendanaan() async {
    try {
      final id = await getId();
      final response = await _dio.get("/pendanaan/riwayat-completed/$id");
      List<CompletedPendanaanModel> data = [];
      for (var val in response.data['data']) {
        data.add(CompletedPendanaanModel.fromJson(val));
      }
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