class KendaraanModel {
  int id;
  String bahanBakar;
  String jenisKendaraan;
  String namaKendaraan;
  String nomorPlat;
  int cc;
  String odometer;
  String kepemilikan;
  int status;

  KendaraanModel({
    required this.id,
    required this.jenisKendaraan,
    required this.namaKendaraan,
    required this.nomorPlat,
    required this.bahanBakar,
    required this.cc,
    required this.odometer,
    required this.kepemilikan,
    required this.status,
  });

  KendaraanModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        jenisKendaraan = json['jenisKendaraan'],
        namaKendaraan = json['namaKendaraan'],
        nomorPlat = json['nomorPlat'],
        bahanBakar = json['bahanBakar'],
        cc = json['cc'],
        odometer = json['odometer'],
        kepemilikan = json['kepemilikan'],
        status = json['status'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'jenisKendaraan': jenisKendaraan,
        'namaKendaraan': namaKendaraan,
        'nomorPlat': nomorPlat,
        'bahanBakar': bahanBakar,
        'cc': cc,
        'odometer': odometer,
        'kepemilikan': kepemilikan,
        'status': status
      };
}
