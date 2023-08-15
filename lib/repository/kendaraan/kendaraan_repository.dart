
import 'package:bbm_tracking/model/kendaraan_m.dart';
import 'package:bbm_tracking/model/transaksi_m.dart';
import 'package:bbm_tracking/services/databases.dart';

// const _delay = Duration(milliseconds: 800);

class KendaraanRepository{

  DatabasesMain service = DatabasesMain();

  Future<List<KendaraanModel>> loadKendaraan() {
    return service.getAllKendaraan();
  }

  Future<void> addedKendaraan(KendaraanModel kendaraan)
  {
    return service.insertDataKendaraan(kendaraan);
  }

  Future<void> changeStatuKendaraan(int id, int status)
  {
    return service.updateStatusAktifKendaraan(id, status);
  }

  Future<void> deleteDataKendaraan(int id) async
  {
    await service.deleteDataKendaraan(id);
  }

  Future<void> updateDataKendaraan(KendaraanModel data) async
  {
    await service.updateDataKendaraan(data);
  }

}