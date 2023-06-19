import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/umkm_model.dart';
import 'package:investkuy/data/repository/umkm_repository.dart';

class ListInvestorCubit extends Cubit<DataState> {
  final UmkmRepository repository = UmkmRepository();

  ListInvestorCubit() : super(InitialState()) {}

  void getAllInvestor(String id) async {
    try {
      emit(LoadingState());
      final data = await repository.getListInvestor(id);
      emit(SuccessState<List<DaftarInvestorModel>>(data));
    } on DioException catch (e) {
      emit(ErrorState(e.response!.data['message'].toString()));
      rethrow;
    }
  }
}
