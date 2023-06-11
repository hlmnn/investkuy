import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/merchant_model.dart';
import 'package:investkuy/data/repository/profile_repository.dart';

class RekeningCubit extends Cubit<DataState> {
  final ProfileRepository repository = ProfileRepository();

  RekeningCubit() : super(InitialState());

  void addRekening(int merchantId, String noRekening) async {
    try {
      emit(LoadingState());
      final data = await repository.addRekening(merchantId, noRekening);
      emit(SuccessState<bool>(data));
    } on DioException catch (e) {
      emit(ErrorState(e.response!.data['message'].toString()));
      rethrow;
    }
  }

  void getAllMerchants() async {
    try {
      emit(LoadingState());
      final data = await repository.getAllMerchants();
      emit(SuccessState<List<MerchantModel>>(data));
    } on DioException catch (e) {
      emit(ErrorState(e.response!.data['message'].toString()));
      rethrow;
    }
  }

  void resetState() {
    emit(InitialState());
  }
}