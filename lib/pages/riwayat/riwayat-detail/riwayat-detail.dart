import 'package:bbm_tracking/model/kendaraan_m.dart';
import 'package:bbm_tracking/model/transaksi_m.dart';
import 'package:bbm_tracking/pages/home.dart';
import 'package:flutter/material.dart';

class RiwayatDetail extends StatefulWidget {
  TransaksiModel data;
  KendaraanModel kendaraan;
  RiwayatDetail({super.key, required this.data, required this.kendaraan});

  @override
  State<RiwayatDetail> createState() => _RiwayatDetailState();
}

class _RiwayatDetailState extends State<RiwayatDetail> {

  late TransaksiModel data;
  late KendaraanModel kendaraan;

  @override
  void initState() {
    super.initState();
    data = widget.data;
    kendaraan = widget.kendaraan;
  }

  TextStyle style = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 9,
    fontWeight: FontWeight.w400,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE3EAEA),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: 50,
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    child: Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            size: 15,
                          ),
                          Text(
                            "Kembali",
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              color: Color(0xff1A0F0F),
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "Detail Transaksi",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color(0xff3B3C48),
                    ),
                  ),
                ),
                Divider(
                  color: Color(0xFF1A0F0F3D),
                  height: 2,
                  thickness: 2,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Transaksi Berhasil",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF25A35A),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              child: Text(
                                data.kodeTransaksi,
                                style: style,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              child: Text(
                                "Download",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 9,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF1C7A44),
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Tipe Kendaraan",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                itemDetail(kendaraan.namaKendaraan, kendaraan.nomorPlat),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Details",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                itemDetail("Tipe transaksi", "Pengisian Bahan Bakar"),
                itemDetail("Data Transaksi", "12 Januari 2023"),
                itemDetail("Waktu", "15:16 WIB"),
                itemDetail("Jenis Bahan Bakar", "PertamaX"),
                itemDetail("Total Liter", "4 Liter"),
                itemDetail("Harga/Liter", "Rp. 11.000"),
                itemDetail("Total Pembayaran", "Rp. 33.000"),
                itemDetail("Odometer/km", "234598 km"),
                itemDetail("Gambar", ".........."),
                itemDetail("Catatan Tambahan",
                    "Pembayaran menggunakan uang kantor yang dialokasikan untuk kegiatan outbond, karena masih ada sisa uang, digunakan untuk membeli pertamax di SPBU Pertamina Ciputat."),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget itemDetail(item, value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                child: Text(
                  item,
                  style: style,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                child: Text(
                  value,
                  textAlign: TextAlign.right,
                  style: style,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
