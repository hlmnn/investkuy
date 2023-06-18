import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/repository/umkm_repository.dart';

class AddNewPengajuanCubit extends Cubit<DataState> {
  final UmkmRepository repository = UmkmRepository();

  AddNewPengajuanCubit() : super(InitialState());

  void addPengajuan(
      FormData formData, List<String> fileImages, String fileLaporan) async {
    try {
      emit(LoadingState());
      final data =
          await repository.addPengajuan(formData, fileImages, fileLaporan);
      emit(SuccessState<bool>(data));
    } on DioException catch (e) {
      log(e.response!.data['message'].toString());
      emit(ErrorState(e.response!.data['message'].toString()));
    }
  }

  void getUsername() async {
    try {
      emit(LoadingState());
      final data = await repository.getUsername();
      emit(SuccessState<String>(data));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  void resetState() async {
    emit(InitialState());
  }
}
