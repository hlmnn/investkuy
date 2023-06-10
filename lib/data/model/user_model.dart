class UserModel {
  String name;
  String username;
  String email;
  String telp;
  String alamat;
  String role;
  bool isVerified;
  String token;

  UserModel(
      {required this.name,
        required this.username,
        required this.email,
        required this.telp,
        required this.alamat,
        required this.role,
        required this.isVerified,
        required this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      username: json['username'],
      email: json['email'],
      telp: json['no_telepon'].toString() ?? "",
      alamat: json['alamat'] ?? "",
      role: json['role'],
      isVerified: json['is_verified'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "username": username,
      "email": email,
      "no_telepon": telp,
      "alamat": alamat,
      "role": role,
      "is_verified": isVerified,
      "token": token
    };
  }
}
