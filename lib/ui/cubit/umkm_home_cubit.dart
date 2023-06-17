import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/umkm_model.dart';
import 'package:investkuy/data/repository/umkm_repository.dart';

class UmkmHomeCubit extends Cubit<DataState> {
  final UmkmRepository repository = UmkmRepository();

  UmkmHomeCubit() : super(InitialState());

  void getVerifiedState() async {
    try {
      final verifiedState = await repository.getVerified();
      // return verifiedState;
      emit(SuccessState<bool>(verifiedState));
    } catch (e) {
      rethrow;
    }
  }

  void resetState() async {
    emit(InitialState());
  }
}
