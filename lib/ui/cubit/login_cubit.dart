import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/user_model.dart';
import 'package:investkuy/data/repository/auth_repository.dart';

class LoginCubit extends Cubit<DataState> {
  final AuthRepository repository = AuthRepository();

  LoginCubit() : super(InitialState());

  void login(String username, String password) async {
    try {
      emit(LoadingState());
      final data = await repository.login(username, password);
      final res = await repository.saveUser(data.token, data.role, data.username, data.id, data.isVerified);
      emit(SuccessState<UserModel>(data));
    } on DioException catch (e) {
      log(e.message.toString());
      if (e.response?.statusCode == 400) {
        emit(ErrorState("Wrong Username or Password"));
      } else {
        emit(ErrorState(e.toString()));
      }
    }
  }

  void resetState() {
    emit(InitialState());
  }
}