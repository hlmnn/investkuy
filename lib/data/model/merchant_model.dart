class MerchantModel {
  int id;
  String name;
  String type;

  MerchantModel({required this.id, required this.name, required this.type});

  factory MerchantModel.fromJson(Map<String, dynamic> json) {
    return MerchantModel(id: json['id'], name: json['name'], type: json['type']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "type": type
    };
  }
}