import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/repository/auth_repository.dart';

class RegisterCubit extends Cubit<DataState> {
  final AuthRepository repository;

  RegisterCubit({required this.repository}) : super(InitialState());

  void register(String name, String email, String username,
      String password, String confirmPassword, String pin, String role) async {
    try {
      emit(LoadingState());
      final data = await repository.register(name, email, username, password, confirmPassword, pin, role);
      emit(SuccessState<bool>(data));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}