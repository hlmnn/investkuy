import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/pendanaan_model.dart';
import 'package:investkuy/data/repository/riwayat_repository.dart';

class InvestorRiwayatInProgressCubit extends Cubit<DataState> {
  final RiwayatRepository repository = RiwayatRepository();

  InvestorRiwayatInProgressCubit() : super(InitialState());

  void getAllInProgressPendanaan() async {
    try {
      emit(LoadingState());
      final data = await repository.getInProgressPendanaan();
      emit(SuccessState<List<InProgressPendanaanModel>>(data));
    } on DioException catch (e) {
      emit(ErrorState(e.response!.data['message'].toString()));
      rethrow;
    }
  }

  void resetState() {
    emit(LoadingState());
  }
}

class InvestorRiwayatCompletedCubit extends Cubit<DataState> {
  final RiwayatRepository repository = RiwayatRepository();

  InvestorRiwayatCompletedCubit() : super(InitialState());

  void getAllCompletedPendanaan() async {
    try {
      emit(LoadingState());
      final data = await repository.getCompletedPendanaan();
      emit(SuccessState<List<CompletedPendanaanModel>>(data));
    } on DioException catch (e) {
      emit(ErrorState(e.response!.data['message'].toString()));
      rethrow;
    }
  }

  void resetState() {
    emit(LoadingState());
  }
}