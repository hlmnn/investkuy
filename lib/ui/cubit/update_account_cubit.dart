import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/user_model.dart';
import 'package:investkuy/data/repository/profile_repository.dart';

class UpdateAccountCubit extends Cubit<DataState> {
  final ProfileRepository repository = ProfileRepository();

  UpdateAccountCubit() : super(InitialState());

  void updateAccount(FormData formData, String img) async {
    try {
      emit(LoadingState());
      final data = await repository.updateAccount(formData, img);
      emit(SuccessState<bool>(data));
    } on DioException catch (e) {
      emit(ErrorState(e.response!.data['message'].toString()));
      rethrow;
    }
  }

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

  void resetState() async {
    emit(InitialState());
  }
}