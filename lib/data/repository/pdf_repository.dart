import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class PdfRepository {
  late final Dio _dio;

  // Constructor
  PdfRepository() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );
    // Log Interceptor
    _dio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
  }

  Future<File> loadPdf(String url) async {
    try {
      final response = await _dio.get<List<int>>(
        url, options: Options(responseType: ResponseType.bytes),
      );
      return _storeFile(url, response.data!);
    } on DioException catch (e) {
      log(e.response!.statusCode.toString());
      log(e.message.toString());
      rethrow;
    }
  }

  Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}