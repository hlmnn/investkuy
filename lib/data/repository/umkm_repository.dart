import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
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
      FormData formData, List<File> fileImages, File fileLaporan) async {
    try {
      formData.files.addAll([
        MapEntry(
            'image1', await MultipartFile.fromFile(fileImages[0].toString())),
        MapEntry(
            'image2', await MultipartFile.fromFile(fileImages[1].toString())),
        MapEntry(
            'image3', await MultipartFile.fromFile(fileImages[2].toString())),
        MapEntry(
            'laporan', await MultipartFile.fromFile(fileLaporan.toString())),
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
