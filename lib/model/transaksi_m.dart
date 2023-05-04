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
  String linkGambar;
  String catatan;
  int status;

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
    required this.linkGambar,
    required this.catatan,
    required this.status,
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
        linkGambar = json['linkGambar'],
        catatan = json['catatan'],
        status = json['status'];

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
        'linkGambar': linkGambar,
        'catatan': catatan,
        'status': status,
      };
}
