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

class BBMChangeStatusKendaraan extends BbmEvent{
  final int id;
  final int status;
  const BBMChangeStatusKendaraan(this.id, this.status);

  @override
  List<Object> get props => [id, status];
}