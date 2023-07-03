import 'package:bbm_tracking/model/photo_m.dart';

class TransaksiModel {
  int id;
  String kendaraanId;
  String bensinId;
  String kodeTransaksi;
  DateTime tanggalTransaksi;
  String lokasiPertamina;
  String totalLiter;
  int hargaPerLiter;
  int totalBayar;
  String odometer;
  String catatan;
  String lat;
  String lang;
  int status;
  List<PhotoModel> dataPhoto;

  TransaksiModel({
    required this.id,
    required this.kendaraanId,
    required this.bensinId,
    required this.kodeTransaksi,
    required this.tanggalTransaksi,
    required this.lokasiPertamina,
    required this.totalLiter,
    required this.hargaPerLiter,
    required this.totalBayar,
    required this.odometer,
    required this.catatan,
    required this.lat,
    required this.lang,
    required this.status,
    required this.dataPhoto,
  });

  TransaksiModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        kendaraanId = json['kendaraanId'],
        bensinId = json['bensinId'],
        kodeTransaksi = json['kodeTransaksi'],
        tanggalTransaksi = json['tanggalTransaksi'],
        lokasiPertamina = json['lokasiPertamina'],
        totalLiter = json['totalLiter'],
        hargaPerLiter = json['hargaPerLiter'],
        totalBayar = json['totalBayar'],
        odometer = json['odometer'],
        catatan = json['catatan'],
        lat = json['lat'],
        lang = json['lang'],
        status = json['status'],
        dataPhoto = json['dataPhoto'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'kendaraanId': kendaraanId,
        'bensinId': bensinId,
        'kodeTransaksi': kodeTransaksi,
        'tanggalTransaksi': tanggalTransaksi,
        'lokasiPertamina': lokasiPertamina,
        'totalLiter': totalLiter,
        'hargaPerLiter': hargaPerLiter,
        'totalBayar': totalBayar,
        'odometer': odometer,
        'catatan': catatan,
        'lat': lat,
        'lang': lang,
        'status': status,
        'dataPhoto': dataPhoto,
      };
}
