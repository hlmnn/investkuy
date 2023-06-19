import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/repository/wallet_repository.dart';

class PendanaanCubit extends Cubit<DataState> {
  final WalletRepository repository = WalletRepository();

  PendanaanCubit() : super(InitialState());

  void postPendanaan(String nominal, int pengajuanId) async {
    try {
      emit(LoadingState());
      final data = await repository.postPendanaan(nominal, pengajuanId);
      emit(SuccessState<bool>(data));
    } on DioException catch (e) {
      emit(ErrorState(e.response!.data['message'].toString()));
      rethrow;
    }
  }

  void cancelPendanaan(int pengajuanId) async {
    try {
      emit(LoadingState());
      final data = await repository.cancelPendanaan(pengajuanId);
      emit(SuccessState<bool>(data));
    } on DioException catch (e) {
      emit(ErrorState(e.response!.data['message'].toString()));
      rethrow;
    }
  }

  void withdrawPendanaan(int pendanaanId) async {
    try {
      emit(LoadingState());
      final data = await repository.withdrawPendanaan(pendanaanId);
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