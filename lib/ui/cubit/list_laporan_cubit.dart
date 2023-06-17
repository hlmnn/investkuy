import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/umkm_model.dart';
import 'package:investkuy/data/repository/umkm_repository.dart';

class ListLaporanCubit extends Cubit<DataState> {
  final UmkmRepository repository = UmkmRepository();

  ListLaporanCubit() : super(InitialState());

  void getAllLaporan(int id) async {
    try {
      emit(LoadingState());
      final data = await repository.getListLaporan(id);
      emit(SuccessState<List<LaporanModel>>(data));
    } on DioException catch (e) {
      emit(ErrorState(e.response!.data['message'].toString()));
      rethrow;
    }
  }
}