import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/umkm_model.dart';
import 'package:investkuy/data/repository/umkm_repository.dart';

class AddLaporanCubit extends Cubit<DataState> {
  final UmkmRepository repository = UmkmRepository();

  AddLaporanCubit() : super(InitialState());

  void addLaporan(String fileLaporan, String id) async {
    try {
      emit(LoadingState());
      final data = await repository.addLaporan(fileLaporan, id);
      emit(SuccessState<String>(data));
    } on DioException catch (e) {
      log(e.response!.data['message'].toString());
      emit(ErrorState(e.response!.data['message'].toString()));
    }
  }

  void getAllLaporan(String id) async {
    try {
      emit(LoadingState());
      final data = await repository.getListLaporan(id);
      emit(SuccessState<List<LaporanModel>>(data));
    } on DioException catch (e) {
      log(e.response!.data['message'].toString());
      emit(ErrorState(e.response!.data['message'].toString()));
    }
  }

  void resetState() async {
    emit(InitialState());
  }
}
