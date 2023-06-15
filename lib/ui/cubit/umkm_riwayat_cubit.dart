import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/umkm_model.dart';
import 'package:investkuy/data/repository/riwayat_repository.dart';

class UmkmRiwayatCubit extends Cubit<DataState> {
  final RiwayatRepository repository = RiwayatRepository();

  UmkmRiwayatCubit() : super(InitialState()) {
    getAllRiwayatCrowdfunding();
  }

  void resetState() async {
    emit(InitialState());
  }

  void getAllRiwayatCrowdfunding() async {
    try {
      emit(LoadingState());
      final data = await repository.getAll();
      emit(SuccessState<List<RiwayatCrowdfundingModel>>(data));
    } on DioException catch (e) {
      emit(ErrorState(e.response!.data['message'].toString()));
      rethrow;
    }
  }


}
