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

}