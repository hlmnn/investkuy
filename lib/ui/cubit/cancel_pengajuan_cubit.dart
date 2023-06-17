import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/repository/umkm_repository.dart';

class CancelPengajuanCubit extends Cubit<DataState> {
  final UmkmRepository repository = UmkmRepository();

  CancelPengajuanCubit() : super(InitialState());

  void cancelPengajuan(String id) async {
    try {
      final data = await repository.cancelPengajuan(id);
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
