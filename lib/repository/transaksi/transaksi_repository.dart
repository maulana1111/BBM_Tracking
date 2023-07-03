import 'package:bbm_tracking/model/photo_m.dart';
import 'package:bbm_tracking/model/transaksi_m.dart';
import 'package:bbm_tracking/services/databases.dart';

class TransaksiRepository
{
  DatabasesMain service = DatabasesMain();
  Future<List<TransaksiModel>> loadTransaksi()
  {
    return service.getAllTransaksiStatusSuccessfull();
  }

  Future<List<TransaksiModel>> loadTransaksiThisMonth()
  {
    return service.getAllTransaksiStatusSuccessfullThisMonth();
  }

  Future<void> insertTransaksi(TransaksiModel model) async 
  {
    await service.insertDataTransaksi(model);
  }

  //photo
  Future<void> insertPhoto(List<PhotoModel> model) async
  {
    model.forEach((element) async{
      await service.insertDataPhoto(element);
    });
  }

}