import 'package:bbm_tracking/model/bensin_m.dart';
import 'package:bbm_tracking/model/kendaraan_m.dart';
import 'package:bbm_tracking/model/transaksi_m.dart';
import 'package:bbm_tracking/pages/home.dart';
import 'package:bbm_tracking/pages/riwayat/riwayat-detail/riwayat-detail.dart';
import 'package:bbm_tracking/resource/resource.dart';
import 'package:flutter/material.dart';

class ItemHistory extends StatefulWidget {
  TransaksiModel data;
  KendaraanModel kendaraan;
  ItemHistory({super.key, required this.data, required this.kendaraan});

  @override
  State<ItemHistory> createState() => _ItemHistoryState();
}

class _ItemHistoryState extends State<ItemHistory> {
  TransaksiModel? data;
  List<BensinModel> dataBensin = listBensin;
  KendaraanModel? kendaraan;

  @override
  void initState() {
    super.initState();
    data = widget.data;
    kendaraan = widget.kendaraan;
  }

  String reformatDate(DateTime date) {
    String data = "";
    for(int i = 0; i < bulan.length; i++)
    {
      if( i+1 == date.month)
      {
        data += "${bulan[i].substring(0, 3)}, ${date.day} ${date.year}";
      }
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => RiwayatDetail(
                  data: data!,
                  key: UniqueKey(),
                  kendaraan: kendaraan!,
                ))),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Color(0xFF677D81)),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(color: Color(0xFFE1E1E1)),
                height: 42,
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 10,
                          top: 5,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pengisian",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                                color: Colors.black,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  dataBensin[int.parse(data!.bensinId) - 1]
                                      .text
                                      .toString(),
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 8,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Data : ${reformatDate(data!.tanggalTransaksi)}",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 8,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                  "assets/images/${dataBensin[int.parse(data!.bensinId) - 1].perusahaan.toLowerCase()}.png"),
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.only(top: 4),
                              width: 50,
                              height: 25,
                              decoration: BoxDecoration(
                                color: data?.status == 1
                                    ? Color(0xFF58D68D)
                                    : Color(0XFFFC8D05),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              // alignment: Alignment.topRight,
                              child: Text(
                                data?.status == 1 ? "selesai" : "draft",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 35,
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 10,
                          top: 5,
                        ),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Harga:",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 8,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              CurrencyFormat.convertToIdr(data?.totalBayar, 0),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 8,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 10,
                          top: 5,
                        ),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Lokasi SPBU:",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 8,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "${data?.lokasiPertamina}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 8,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF3B3C48),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
