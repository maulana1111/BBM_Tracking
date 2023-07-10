part of 'bbm_bloc.dart';

abstract class BbmState extends Equatable {
  const BbmState();
  
  @override
  List<Object> get props => [];
}

class BbmInitial extends BbmState {}

class BBMSingleData extends BbmState{
  final KendaraanModel kendaraan;
  BBMSingleData({required this.kendaraan});
}

class BBMLoaded extends BbmState{
  final List<KendaraanModel> kendaraan;
  final List<TransaksiModel> transaksi;
  final List<TransaksiPerMonthModel> transaksiThisMonth;
  late List<BensinModel> bensin = listBensin;

  BBMLoaded(this.kendaraan, this.transaksi, this.transaksiThisMonth);
}

class BBMChangeStatus extends BbmState{
  final List<KendaraanModel> kendaraan;
  final List<TransaksiModel> transaksi;
  late List<BensinModel> bensin = listBensin;

  BBMChangeStatus({required this.kendaraan, required this.transaksi});
}

class BBMKendaraanLoaded extends BbmState{
  final List<KendaraanModel> kendaraan;

  BBMKendaraanLoaded({required this.kendaraan});
}


class BBMError extends BbmState{ 
  final String message;
  BBMError({required this.message});
}
