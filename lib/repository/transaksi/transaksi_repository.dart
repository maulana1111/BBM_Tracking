import 'package:bbm_tracking/model/photo_m.dart';
import 'package:bbm_tracking/model/transaksiPerMonth_m.dart';
import 'package:bbm_tracking/model/transaksi_m.dart';
import 'package:bbm_tracking/services/databases.dart';

class TransaksiRepository
{
  DatabasesMain service = DatabasesMain();
  Future<List<TransaksiModel>> loadTransaksi()
  {
    return service.getAllTransaksiStatusSuccessfull();
  }

  Future<List<TransaksiPerMonthModel>> loadTransaksiThisMonth(String datetime)
  {
    return service.getAllTransaksiStatusSuccessfullThisMonth(datetime);
  }

  Future<void> insertTransaksi(TransaksiModel model) async 
  {
    await service.insertDataTransaksi(model);
  }

  //photo
  Future<void> insertPhoto(PhotoModel model) async
  {
      await service.insertDataPhoto(model);
  }

}