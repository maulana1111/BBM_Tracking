part of 'bbm_bloc.dart';

abstract class BbmState extends Equatable {
  const BbmState();
  
  @override
  List<Object> get props => [];
}

class BbmInitial extends BbmState {}


class BBMLoaded extends BbmState{
  final List<KendaraanModel> kendaraan;
  final List<TransaksiModel> transaksi;
  final List<TransaksiModel> transaksiThisMonth;
  late List<BensinModel> bensin = listBensin;

  BBMLoaded(this.kendaraan, this.transaksi, this.transaksiThisMonth);
}

class BBMChangeStatus extends BbmState{
  final List<KendaraanModel> kendaraan;
  final List<TransaksiModel> transaksi;
  late List<BensinModel> bensin = listBensin;

  BBMChangeStatus({required this.kendaraan, required this.transaksi});
}


class BBMError extends BbmState{ 
  final String message;
  BBMError({required this.message});
}
