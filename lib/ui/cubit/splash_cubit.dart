import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/repository/auth_repository.dart';

class SplashCubit extends Cubit<DataState> {
  final AuthRepository repository = AuthRepository();

  SplashCubit() : super(InitialState()) {
    getCurrentUserRole();
  }

  void getCurrentUserRole() async {
    try {
      emit(LoadingState());
      final data = await repository.getRole();
      emit(SuccessState<String>(data));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}