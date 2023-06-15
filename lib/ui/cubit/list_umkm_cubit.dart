import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/umkm_model.dart';
import 'package:investkuy/data/repository/umkm_repository.dart';

class ListUmkmCubit extends Cubit<DataState> {
  final UmkmRepository repository = UmkmRepository();

  ListUmkmCubit() : super(InitialState());

  int page = 1;
  final int _perPage = 10;

  void getAllPengajuan(bool isRefresh, String sort, String order, String tenor,
      String sektor, String plafond) {
    try {
      if (isRefresh) page = 1;
      if (state is LoadingPaginationState) return;

      final currentState = state;

      List<UmkmModel> oldData = [];
      if (currentState is SuccessState && !isRefresh) {
        oldData = currentState.data;
      }

      emit(LoadingPaginationState(oldData, isFirstFetch: page == 1));

      repository
          .getAllPengajuan(page.toString(), _perPage.toString(), sort, order,
              tenor, sektor, plafond)
          .then((value) {
        page++;

        final List<UmkmModel> data = (state as LoadingPaginationState).oldData;
        data.addAll(value);

        emit(SuccessState<List<UmkmModel>>(data));
      });
    } on DioException catch (e) {
      emit(ErrorState(e.response!.data['message'].toString()));
      rethrow;
    }
  }

  void resetState() {
    emit(InitialState());
  }
}
