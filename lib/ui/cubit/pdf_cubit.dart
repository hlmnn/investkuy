import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/repository/pdf_repository.dart';

class PdfCubit extends Cubit<DataState> {
  final PdfRepository repository = PdfRepository();

  PdfCubit() : super(InitialState());

  void getPdf(String url) async {
    try {
      emit(LoadingState());
      final data = await repository.loadPdf(url);
      emit(SuccessState<File>(data));
    } on DioException catch (e) {
      emit(ErrorState(e.response!.data['message'].toString()));
      rethrow;
    }
  }
}