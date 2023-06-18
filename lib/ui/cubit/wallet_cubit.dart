import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/merchant_model.dart';
import 'package:investkuy/data/model/wallet_model.dart';
import 'package:investkuy/data/repository/wallet_repository.dart';

class WalletCubit extends Cubit<DataState> {
  final WalletRepository repository = WalletRepository();

  WalletCubit() : super(InitialState());

  void getWallet() async {
    try {
      emit(LoadingState());
      final data = await repository.getWallet();
      emit(SuccessState<WalletModel>(data));
    } on DioException catch (e) {
      emit(ErrorState(e.response!.data['message'].toString()));
      rethrow;
    }
  }

  void resetState() {
    emit(InitialState());
  }
}

class CreditHistoryCubit extends Cubit<DataState> {
  final WalletRepository repository = WalletRepository();

  CreditHistoryCubit() : super(InitialState());

  void getCredits(int id) async {
    try {
      emit(LoadingState());
      final data = await repository.getCreditTransactions(id);
      emit(SuccessState<List<CreditTransactionModel>>(data));
    } on DioException catch (e) {
      emit(ErrorState(e.response!.data['message'].toString()));
      rethrow;
    }
  }

  void resetState() {
    emit(InitialState());
  }
}

class DebitHistoryCubit extends Cubit<DataState> {
  final WalletRepository repository = WalletRepository();

  DebitHistoryCubit() : super(InitialState());

  void getDebits(int id) async {
    try {
      emit(LoadingState());
      final data = await repository.getDebitTransactions(id);
      emit(SuccessState<List<DebitTransactionModel>>(data));
    } on DioException catch (e) {
      emit(ErrorState(e.response!.data['message'].toString()));
      rethrow;
    }
  }

  void resetState() {
    emit(InitialState());
  }
}

class MerchantCubit extends Cubit<DataState> {
  final WalletRepository repository = WalletRepository();

  MerchantCubit() : super(InitialState());

  void getAllMerchants() async {
    try {
      emit(LoadingState());
      final data = await repository.getAllMerchants();
      emit(SuccessState<List<MerchantModel>>(data));
    } on DioException catch (e) {
      emit(ErrorState(e.response!.data['message'].toString()));
      rethrow;
    }
  }

  void resetState() {
    emit(InitialState());
  }
}

class TopUpCubit extends Cubit<DataState> {
  final WalletRepository repository = WalletRepository();

  TopUpCubit() : super(InitialState());

  void topUp(int walletId, int merchantId, int amount) async {
    try {
      emit(LoadingState());
      final data = await repository.topUp(walletId, merchantId, amount);
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

class WithdrawCubit extends Cubit<DataState> {
  final WalletRepository repository = WalletRepository();

  WithdrawCubit() : super(InitialState());

  void withdraw(int walletId, int merchantId, int amount) async {
    try {
      emit(LoadingState());
      final data = await repository.withdraw(walletId, merchantId, amount);
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