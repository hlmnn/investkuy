class PendanaanModel {
  int id;
  int nominal;
  PengajuanModel pengajuan;

  PendanaanModel({
    required this.id,
    required this.nominal,
    required this.pengajuan,
  });

  factory PendanaanModel.fromJson(Map<String, dynamic> json) {
    return PendanaanModel(
      id: json['id'],
      nominal: json['nominal'],
      pengajuan: PengajuanModel.fromJson(json['pengajuanDetails']),
    );
  }
}

class PengajuanModel {
  int id;
  String sektor;
  int plafond;
  int bagiHasil;
  int tenor;
  PemilikPengajuanModel pemilik;

  PengajuanModel({
    required this.id,
    required this.sektor,
    required this.plafond,
    required this.bagiHasil,
    required this.tenor,
    required this.pemilik,
  });

  factory PengajuanModel.fromJson(Map<String, dynamic> json) {
    return PengajuanModel(
      id: json['id'],
      sektor: json['sektor'],
      plafond: json['plafond'],
      bagiHasil: json['bagi_hasil'],
      tenor: json['tenor'],
      pemilik: PemilikPengajuanModel.fromJson(json['pemilikDetails']),
    );
  }
}

class PemilikPengajuanModel {
  int id;
  String name;
  String alamat;
  String imgUrl;

  PemilikPengajuanModel({
    required this.id,
    required this.name,
    required this.alamat,
    required this.imgUrl,
  });

  factory PemilikPengajuanModel.fromJson(Map<String, dynamic> json) {
    return PemilikPengajuanModel(
      id: json['id'],
      name: json['name'],
      alamat: json['alamat'] ?? "Tidak ada alamat",
      imgUrl: json['img_url'] ?? "",
    );
  }
}

class InProgressPendanaanModel extends PendanaanModel {
  int repayment;

  InProgressPendanaanModel({
    required super.id,
    required super.nominal,
    required super.pengajuan,
    required this.repayment,
  });

  factory InProgressPendanaanModel.fromJson(Map<String, dynamic> json) {
    return InProgressPendanaanModel(
      id: json['id'],
      nominal: json['nominal'],
      repayment: json['repayment'],
      pengajuan: PengajuanModel.fromJson(json['pengajuanDetails']),
    );
  }
}

class CompletedPendanaanModel extends PendanaanModel {
  int profit;
  String status;
  String tanggalSelesai;

  CompletedPendanaanModel({
    required super.id,
    required super.nominal,
    required super.pengajuan,
    required this.profit,
    required this.status,
    required this.tanggalSelesai,
  });

  factory CompletedPendanaanModel.fromJson(Map<String, dynamic> json) {
    return CompletedPendanaanModel(
      id: json['id'],
      nominal: json['nominal'],
      profit: json['profit'],
      status: json['status'],
      tanggalSelesai: json['tgl_selesai'],
      pengajuan: PengajuanModel.fromJson(json['pengajuanDetails']),
    );
  }
}
