class PhotoModel {
  int id;
  String transaksi_id;
  String linkPhoto;
  String namePhoto;

  PhotoModel(
      {required this.id,
      required this.transaksi_id,
      required this.linkPhoto,
      required this.namePhoto});

  PhotoModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        transaksi_id = json['transaksi_id'],
        linkPhoto = json['linkPhoto'],
        namePhoto = json['namePhoto'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'transaksi_id': transaksi_id,
        'linkPhoto': linkPhoto,
        'namePhoto': namePhoto
      };
}
