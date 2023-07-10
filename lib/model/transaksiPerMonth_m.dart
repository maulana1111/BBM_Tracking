class TransaksiPerMonthModel{
  double totalLiter;
  int totalBayar;
  String kendaraanId;
  DateTime tanggalTransaksi;

  TransaksiPerMonthModel({
    required this.totalLiter,
    required this.totalBayar,
    required this.kendaraanId,
    required this.tanggalTransaksi
  });

  TransaksiPerMonthModel.fromJson(Map<String, dynamic> json)
    : totalBayar = json['totalBayar'],
      totalLiter = json['totalLiter'],
      kendaraanId = json['kendaraanId'],
      tanggalTransaksi = json['tanggalTransaksi'];

  Map<String, dynamic> toJson() => {
    'totalBayar' : totalBayar,
    'totalLiter' : totalLiter,
    'kendaraanId' : kendaraanId,
    'tanggalTransaksi' : tanggalTransaksi
  };

}