import 'package:investkuy/data/model/merchant_model.dart';

class RekeningModel {
  int id;
  String noRekening;
  int merchantId;
  int userId;
  MerchantModel merchant;

  RekeningModel(
      {required this.id,
      required this.noRekening,
      required this.merchantId,
      required this.userId,
      required this.merchant});

  factory RekeningModel.fromJson(Map<String, dynamic> json) {
    return RekeningModel(
        id: json['id'],
        noRekening: json['no_rekening'],
        merchantId: json['merchantId'],
        userId: json['userId'],
        merchant: MerchantModel.fromJson(json['merchantsDetails']));
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "no_rekening": noRekening,
      "merchantId": merchantId,
      "userId": userId,
      "merchantsDetails": merchant
    };
  }
}
