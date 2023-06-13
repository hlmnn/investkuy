class UmkmModel {
  int id;
  String sektor;
  int plafond;
  int bagiHasil;
  int tenor;
  int jumlahPendanaan;
  String tanggalMulai;
  String tanggalBerakhir;
  int lunasDiniCount;
  DetailPemilikUmkmModel detailPemilik;

  UmkmModel({
    required this.id,
    required this.sektor,
    required this.plafond,
    required this.bagiHasil,
    required this.tenor,
    required this.jumlahPendanaan,
    required this.tanggalMulai,
    required this.tanggalBerakhir,
    required this.lunasDiniCount,
    required this.detailPemilik,
  });

  factory UmkmModel.fromJson(Map<String, dynamic> json) {
    return UmkmModel(
      id: json['id'],
      sektor: json['sektor'],
      plafond: json['plafond'],
      bagiHasil: json['bagi_hasil'],
      tenor: json['tenor'],
      jumlahPendanaan: json['jml_pendanaan'],
      tanggalMulai: json['tgl_mulai'],
      tanggalBerakhir: json['tgl_berakhir'],
      lunasDiniCount: json['lunas_dini_count'] ?? 0,
      detailPemilik: DetailPemilikUmkmModel.fromJson(json['pemilikDetails']),
    );
  }
}

class DetailPemilikUmkmModel {
  String name;
  String alamat;

  DetailPemilikUmkmModel({required this.name, required this.alamat});

  factory DetailPemilikUmkmModel.fromJson(Map<String, dynamic> json) {
    return DetailPemilikUmkmModel(
        name: json['name'], alamat: json['alamat'] ?? "Tidak ada alamat");
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "alamat": alamat};
  }
}
