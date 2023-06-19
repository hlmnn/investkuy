import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/repository/umkm_repository.dart';

class BayarCicilanCubit extends Cubit<DataState> {
  final UmkmRepository repository = UmkmRepository();

  BayarCicilanCubit() : super(InitialState());

  void bayarCicilan(String id) async {
    try {
      final data = await repository.bayarCicilan(id);
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
