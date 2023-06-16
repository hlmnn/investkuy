import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/umkm_model.dart';
import 'package:investkuy/data/repository/riwayat_repository.dart';

class UmkmRiwayatCfCubit extends Cubit<DataState> {
  final RiwayatRepository repository = RiwayatRepository();

  UmkmRiwayatCfCubit() : super(InitialState()) {
    
  }

  void resetState() async {
    emit(InitialState());
  }

  void getAllRiwayatCrowdfunding() async {
    try {
      emit(LoadingState());
      final data = await repository.getAllCf();
      emit(SuccessState<List<RiwayatCrowdfundingModel>>(data));
    } on DioException catch (e) {
      emit(ErrorState(e.response!.data['message'].toString()));
      rethrow;
    }
  }
}

class UmkmRiwayatPaymentCubit extends Cubit<DataState> {
  final RiwayatRepository repository = RiwayatRepository();

  UmkmRiwayatPaymentCubit() : super(InitialState()) {
    
  }

  void resetState() async {
    emit(InitialState());
  }

  void getAllRiwayatPayment() async {
    try {
      emit(LoadingState());
      final data = await repository.getAllPayment();
      emit(SuccessState<List<RiwayatPaymentModel>>(data));
    } on DioException catch (e) {
      emit(ErrorState(e.response!.data['message'].toString()));
      rethrow;
    }
  }
}
