import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/umkm_model.dart';
import 'package:investkuy/data/repository/umkm_repository.dart';

class DetailUmkmCubit extends Cubit<DataState> {
  final UmkmRepository repository = UmkmRepository();

  DetailUmkmCubit() : super(InitialState());

  void getDetailUmkm(String id) async {
    try {
      emit(LoadingState());
      final data = await repository.getDetailUmkm(id);
      final isVerified = await repository.getVerified();
      emit(SuccessState<Map<String, dynamic>>(
        {
          'data': data,
          'isVerified': isVerified,
        },
      ));
    } on DioException catch (e) {
      emit(ErrorState(e.response!.data['message'].toString()));
      rethrow;
    }
  }

  void cancelPengajuan(String id) async {
    try {
      emit(LoadingState());
      final data = await repository.cancelPengajuan(id);
      log(data.toString());
      emit(SuccessState<bool>(data));
    } on DioException catch (e) {
      emit(ErrorState(e.response!.data['message'].toString()));
      rethrow;
    }
  }

  void resetState() {
    emit(InitialState());
  }
}
