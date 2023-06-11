import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/merchant_model.dart';
import 'package:investkuy/data/model/rekening_model.dart';
import 'package:investkuy/data/repository/profile_repository.dart';

class SettingCubit extends Cubit<DataState> {
  final ProfileRepository repository = ProfileRepository();

  SettingCubit() : super(InitialState());

  void changePassword(String oldPass, String newPass, String confNewPass, String pin) async {
    try {
      emit(LoadingState());
      final data = await repository.changePassword(oldPass, newPass, confNewPass, pin);
      emit(SuccessState<bool>(data));
    } on DioException catch (e) {
      emit(ErrorState(e.response!.data['message'].toString()));
      rethrow;
    }
  }

  void changePin(String oldPin, String newPin, String confNewPin, String password) async {
    try {
      emit(LoadingState());
      final data = await repository.changePin(oldPin, newPin, confNewPin, password);
      emit(SuccessState<bool>(data));
    } on DioException catch (e) {
      emit(ErrorState(e.response!.data['message'].toString()));
      rethrow;
    }
  }

  void getAllRekening() async {
    try {
      emit(LoadingState());
      final data = await repository.getAllRekening();
      emit(SuccessState<List<RekeningModel>>(data));
    } on DioException catch (e) {
      emit(ErrorState(e.response!.data['message'].toString()));
      rethrow;
    }
  }

  void deleteRekening(int id) async {
    try {
      emit(LoadingState());
      final data = await repository.deleteRekening(id);
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