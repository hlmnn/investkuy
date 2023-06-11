import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/faq_model.dart';
import 'package:investkuy/data/repository/faq_repository.dart';

class FaqCubit extends Cubit<DataState> {
  final FaqRepository repository = FaqRepository();

  FaqCubit() : super(InitialState());

  void getFaq() async {
    try {
      emit(LoadingState());
      final data = await repository.faq();
      emit(SuccessState<List<FaqModel>>(data));
    } on DioException catch (e) {
      log(e.response!.data['message'].toString());
      emit(ErrorState(e.response!.data['message'].toString()));
    }
  }
}