import 'package:investkuy/data/model/merchant_model.dart';

class WalletModel {
  int id;
  int balance;

  WalletModel({
    required this.id,
    required this.balance,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      id: json['id'],
      balance: json['balance'],
    );
  }
}

class CreditTransactionModel {
  int amount;
  String transactionCode;
  String type;
  String createdAt;
  MerchantModel? merchantDetails;

  CreditTransactionModel({
    required this.amount,
    required this.type,
    required this.transactionCode,
    required this.createdAt,
    required this.merchantDetails,
  });

  factory CreditTransactionModel.fromJson(Map<String, dynamic> json) {
    return CreditTransactionModel(
      amount: json['amount'],
      type: json['type'],
      transactionCode: json['transactionCode'],
      createdAt: json['createdAt'],
      merchantDetails: json['merchantDetails'] != null
          ? MerchantModel.fromJson(json['merchantDetails'])
          : null,
    );
  }
}

class DebitTransactionModel {
  int amount;
  String transactionCode;
  String paymentCode;
  String type;
  String createdAt;
  MerchantModel? merchantDetails;

  DebitTransactionModel({
    required this.amount,
    required this.type,
    required this.transactionCode,
    required this.paymentCode,
    required this.createdAt,
    required this.merchantDetails,
  });

  factory DebitTransactionModel.fromJson(Map<String, dynamic> json) {
    return DebitTransactionModel(
      amount: json['amount'],
      type: json['type'],
      transactionCode: json['transactionCode'],
      paymentCode: json['paymentCode'],
      createdAt: json['createdAt'],
      merchantDetails: json['merchantDetails'] != null
          ? MerchantModel.fromJson(json['merchantDetails'])
          : null,
    );
  }
}
