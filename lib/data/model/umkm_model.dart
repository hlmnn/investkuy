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
  String img;

  DetailPemilikUmkmModel(
      {required this.name, required this.alamat, required this.img});

  factory DetailPemilikUmkmModel.fromJson(Map<String, dynamic> json) {
    return DetailPemilikUmkmModel(
        name: json['name'],
        alamat: json['alamat'] ?? "Tidak ada alamat",
        img: json['img_url'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "alamat": alamat, "img_url": img};
  }
}

class DetailUmkmModel extends UmkmModel {
  bool isFunded;
  String pekerjaan;
  String deskripsi;
  String penghasilan;
  String jenisAngsuran;
  String akad;
  String tanggalMulaiBayar;
  String status;
  bool isWithdraw;
  int angsuranDibayar;
  int pemilikId;
  int jumlahAngsuran;
  FotoUmkmModel fotoUmkm;

  DetailUmkmModel({
    required super.id,
    required super.sektor,
    required super.plafond,
    required super.bagiHasil,
    required super.tenor,
    required super.jumlahPendanaan,
    required super.tanggalMulai,
    required super.tanggalBerakhir,
    required super.lunasDiniCount,
    required super.detailPemilik,
    required this.isFunded,
    required this.pekerjaan,
    required this.akad,
    required this.angsuranDibayar,
    required this.deskripsi,
    required this.fotoUmkm,
    required this.isWithdraw,
    required this.jenisAngsuran,
    required this.pemilikId,
    required this.penghasilan,
    required this.status,
    required this.tanggalMulaiBayar,
    required this.jumlahAngsuran
  });

  factory DetailUmkmModel.fromJson(Map<String, dynamic> json) {
    return DetailUmkmModel(
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
      isFunded: json['isFunded'],
      pekerjaan: json['pekerjaan'],
      akad: json['akad'],
      angsuranDibayar: json['angsuran_dibayar'],
      deskripsi: json['deskripsi'],
      fotoUmkm: FotoUmkmModel.fromJson(json['foto_umkm']),
      isWithdraw: json['is_withdraw'],
      jenisAngsuran: json['jenis_angsuran'],
      pemilikId: json['pemilikId'],
      penghasilan: json['penghasilan'],
      status: json['status'],
      tanggalMulaiBayar: json['tgl_mulai_bayar'],
      jumlahAngsuran: json['jml_angsuran']
    );
  }
}

class FotoUmkmModel {
  String imgUrl1;
  String imgUrl2;
  String imgUrl3;

  FotoUmkmModel(
      {required this.imgUrl1, required this.imgUrl2, required this.imgUrl3});

  factory FotoUmkmModel.fromJson(Map<String, dynamic> json) {
    return FotoUmkmModel(
      imgUrl1: json['image1_url'],
      imgUrl2: json['image2_url'],
      imgUrl3: json['image2_url'],
    );
  }

  Map<String, dynamic> tojson() {
    return {
      "image1_url": imgUrl1,
      "image2_url": imgUrl2,
      "image3_url": imgUrl3
    };
  }
}
