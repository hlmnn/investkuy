import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/user_model.dart';
import 'package:investkuy/data/repository/profile_repository.dart';

class ProfileCubit extends Cubit<DataState> {
  final ProfileRepository repository = ProfileRepository();

  ProfileCubit() : super(InitialState());

  void getUser() async {
    try {
      emit(LoadingState());
      final data = await repository.getUser();
      emit(SuccessState<UserModel>(data));
    } on DioException catch (e) {
      emit(ErrorState(e.response!.data['message'].toString()));
      rethrow;
    }
  }

  void logout() async {
    try {
      emit(LoadingState());
      final data = await repository.deleteUser();
      emit(SuccessState<bool>(data));
    } catch (e) {
      emit(ErrorState(e.toString()));
      rethrow;
    }
  }

  void resetState() async {
    emit(InitialState());
  }
}