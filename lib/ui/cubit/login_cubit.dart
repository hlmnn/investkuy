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

  void saveUser(String token, String role) async {
    try {
      emit(LoadingState());
      final data = await repository.saveUser(token, role);
      emit(SuccessState<bool>(data));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}