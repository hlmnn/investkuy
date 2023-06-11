class ArticleModel {
  int id;
  String title;
  String tglTerbit;
  String konten;
  String imgUrl;
  String adminName;

  ArticleModel(
      {required this.id,
      required this.title,
      required this.tglTerbit,
      required this.konten,
      required this.imgUrl,
      required this.adminName});

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'],
      title: json['title'],
      tglTerbit: json['tgl_terbit'],
      konten: json['konten'] ?? "",
      imgUrl: json['img_url'] ?? "",
      adminName: json['adminName'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "tgl_terbit": tglTerbit,
      "konten": konten,
      "img_url": imgUrl,
      "adminId": adminName
    };
  }
}
