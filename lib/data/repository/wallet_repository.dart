import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:investkuy/data/model/merchant_model.dart';
import 'package:investkuy/data/model/rekening_model.dart';
import 'package:investkuy/data/model/wallet_model.dart';
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

  Future<WalletModel> getWallet() async {
    try {
      final token = await getToken();
      final username = await getUsername();
      final response = await _dio.get(
        "/wallet/$username",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      final data = WalletModel.fromJson(response.data['data']);
      return data;
    } on DioException catch (e) {
      log(e.response!.statusCode.toString());
      log(e.message.toString());
      rethrow;
    }
  }

  Future<List<CreditTransactionModel>> getCreditTransactions(int id) async {
    try {
      final token = await getToken();
      final response = await _dio.get(
        "/wallet/credits/$id",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      List<CreditTransactionModel> data = [];
      for (var val in response.data['data']) {
        data.add(CreditTransactionModel.fromJson(val));
      }
      return data;
    } on DioException catch (e) {
      log(e.response!.statusCode.toString());
      log(e.message.toString());
      rethrow;
    }
  }

  Future<List<DebitTransactionModel>> getDebitTransactions(int id) async {
    try {
      final token = await getToken();
      final response = await _dio.get(
        "/wallet/debits/$id",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      List<DebitTransactionModel> data = [];
      for (var val in response.data['data']) {
        data.add(DebitTransactionModel.fromJson(val));
      }
      return data;
    } on DioException catch (e) {
      log(e.response!.statusCode.toString());
      log(e.message.toString());
      rethrow;
    }
  }

  Future<List<MerchantModel>> getAllMerchants() async {
    try {
      final response = await _dio.get('/merchants');
      List<MerchantModel> data = [];
      for (var val in response.data['data']) {
        data.add(MerchantModel.fromJson(val));
      }
      return data;
    } on DioException catch (e) {
      log(e.response!.statusCode.toString());
      log(e.message.toString());
      rethrow;
    }
  }

  Future<bool> topUp(int walletId, int merchantId, int amount) async {
    try {
      final token = await getToken();
      await _dio.post(
        "/wallet/debits",
        data: {
          "walletId": walletId,
          "merchantId": merchantId,
          "amount": amount,
          "type": "TopUp"
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      return true;
    } on DioException catch (e) {
      log(e.response!.statusCode.toString());
      log(e.message.toString());
      rethrow;
    }
  }

  Future<bool> withdraw(int walletId, int merchantId, int amount) async {
    try {
      final token = await getToken();
      await _dio.post(
        "/wallet/credits",
        data: {
          "walletId": walletId,
          "merchantId": merchantId,
          "amount": amount,
          "type": "Withdraw"
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      return true;
    } on DioException catch (e) {
      log(e.response!.statusCode.toString());
      log(e.message.toString());
      rethrow;
    }
  }

  Future<List<RekeningModel>> getAllRekening() async {
    try {
      final id = await getId();
      final token = await getToken();
      final response = await _dio.get(
        "/rekenings/$id",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      List<RekeningModel> data = [];
      for (var val in response.data['data']) {
        data.add(RekeningModel.fromJson(val));
      }
      return data;
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
