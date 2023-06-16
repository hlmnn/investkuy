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

  Future<String> addPengajuan(
      FormData formData, List<String> fileImages, String fileLaporan) async {
    try {
      formData.files.addAll([
        MapEntry('image1', await MultipartFile.fromFile(fileImages[0])),
        MapEntry('image2', await MultipartFile.fromFile(fileImages[1])),
        MapEntry('image3', await MultipartFile.fromFile(fileImages[2])),
        MapEntry('laporan', await MultipartFile.fromFile(fileLaporan)),
      ]);

      formData.fields.add(MapEntry('username', await getUsername()));
      log(formData.toString());
      final response = await _dio.post('/pengajuan', data: formData);
      return response.data['message'];
    } on DioException catch (e) {
      log(e.response!.statusCode.toString());
      log(e.message.toString());
      rethrow;
    }
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

  Future<List<DaftarInvestorModel>> getListInvestor(int id) async {
    try {
      final response = await _dio.get("/pengajuan/$id/list-investor");
      List<DaftarInvestorModel> data = [];
      for (var value in response.data['data']) {
        data.add(DaftarInvestorModel.fromJson(value));
      }
      return data;
    } on DioException catch (e) {
      log(e.response!.statusCode.toString());
      log(e.message.toString());
      rethrow;
    }
  }
  
  Future<String> addLaporan(
      String fileLaporan, int id) async {
    try {
      FormData formData = FormData();

      formData.files.add(MapEntry('laporan', await MultipartFile.fromFile(fileLaporan)));
      log(formData.toString());
      final response = await _dio.post('/pengajuan/$id/tambah-laporan', data: formData);
      return response.data['message'];
    } on DioException catch (e) {
      log(e.response!.statusCode.toString());
      log(e.message.toString());
      rethrow;
    }
  }

  Future<List<LaporanModel>> getListLaporan(int id) async {
    try {
      final response = await _dio.get("/pengajuan/$id/laporan-keuangan");
      List<LaporanModel> data = [];
      for (var value in response.data['data']) {
        data.add(LaporanModel.fromJson(value));
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

  Future<int> getId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getInt('id') ?? 0;
      return id;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> getVerified() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isVerified = prefs.getBool('isVerified') ?? false;
      return isVerified;
    } catch (e) {
      rethrow;
    }
  }
}
