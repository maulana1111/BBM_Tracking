part of 'bbm_bloc.dart';

abstract class BbmEvent extends Equatable {
  const BbmEvent();

  @override
  List<Object> get props => [];
}

class BBMStarted extends BbmEvent{}

class BBMDataKendaraanAdded extends BbmEvent{
  const BBMDataKendaraanAdded(this.kendaraanModel);
  final KendaraanModel kendaraanModel;
  
  @override
  List<Object> get props => [kendaraanModel];
}

class BBMDataKendaraan extends BbmEvent{
  final KendaraanModel kendaraanModel;
  const BBMDataKendaraan({required this.kendaraanModel});

  @override
  List<Object> get props => [kendaraanModel];
}

class BBMChangeStatusKendaraan extends BbmEvent{
  final int id;
  final int status;
  const BBMChangeStatusKendaraan(this.id, this.status);

  @override
  List<Object> get props => [id, status];
}

class BBMInsertTransaksion extends BbmEvent{
  final TransaksiModel transaksi;
  final List<PhotoModel> photo;
  const BBMInsertTransaksion({required this.transaksi, required this.photo});

  @override
  List<Object> get props => [transaksi];
}