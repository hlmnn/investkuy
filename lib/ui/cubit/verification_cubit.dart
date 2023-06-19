import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/repository/profile_repository.dart';

class VerificationCubit extends Cubit<DataState> {
  final ProfileRepository repository = ProfileRepository();

  VerificationCubit() : super(InitialState());

  void accountVerification(FormData formData, String imgKtp, String imgSelf) async {
    try {
      emit(LoadingState());
      final data = await repository.accountVerification(formData, imgKtp, imgSelf);
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