import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/user_model.dart';
import 'package:investkuy/data/repository/auth_repository.dart';

class LoginCubit extends Cubit<DataState> {
  final AuthRepository repository;

  LoginCubit({required this.repository}) : super(InitialState());

  void login(String username, String password) async {
    try {
      emit(LoadingState());
      final data = await repository.login(username, password);
      emit(SuccessState<UserModel>(data));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  void saveUser(String token) async {
    try {
      emit(LoadingState());
      final data = await repository.saveUser(token);
      emit(SuccessState<bool>(data));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}