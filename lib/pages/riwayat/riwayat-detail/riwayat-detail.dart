import 'dart:io';

import 'package:bbm_tracking/model/kendaraan_m.dart';
import 'package:bbm_tracking/model/photo_m.dart';
import 'package:bbm_tracking/model/transaksi_m.dart';
import 'package:bbm_tracking/pages/home.dart';
import 'package:bbm_tracking/pages/riwayat/component/viewImage.dart';
import 'package:bbm_tracking/repository/transaksi/transaksi_repository.dart';
import 'package:flutter/material.dart';
import 'package:bbm_tracking/resource/resource.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

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

  Future<List<PhotoModel>> loadPhoto(param) async {
    List<PhotoModel> photo = await TransaksiRepository().getPhoto(param);
    return photo;
  }

  _showImage(path) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    List<PhotoModel> photo = await loadPhoto(path);
    List<File> data = [];
    photo.forEach((element) {
      data.add(File(appDocDir.uri.toString() + element.namePhoto + ".jpg"));  
    });

    print("counting = ${data.length.toString()}");
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewImage(imagePath: data)));
  }

  String reformatDate(DateTime date) {
    String data = "";
    for (int i = 0; i < bulan.length; i++) {
      if (i + 1 == date.month) {
        data += "${date.day} ${bulan[i]} ${date.year}";
      }
    }
    return data;
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
                            flex: 2,
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
                itemDetail(
                    "Data Transaksi", reformatDate(data.tanggalTransaksi)),
                itemDetail("Waktu",
                    "${data.tanggalTransaksi.hour}:${data.tanggalTransaksi.minute} WIB"),
                itemDetail("Jenis Bahan Bakar",
                    listBensin[int.parse(data.bensinId) - 1].text),
                itemDetail("Total Liter", "${data.totalLiter} Liter"),
                itemDetail("Harga/Liter",
                    "${CurrencyFormat.convertToIdr(listBensin[int.parse(data.bensinId) - 1].harga, 0)}"),
                itemDetail("Total Pembayaran",
                    "${CurrencyFormat.convertToIdr(data.totalBayar, 0)}"),
                itemDetail("Odometer/km", "${data.odometer} km"),
                itemDetaill("Gambar", "..........", data.odometer),
                itemDetail("Catatan Tambahan", data.catatan),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget itemDetaill(item, value, val) {
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
              child: InkWell(
                onTap: () {
                  _showImage(val);
                },
                child: Container(
                  child: Text(
                    value,
                    textAlign: TextAlign.right,
                    style: style,
                  ),
                ),
              ),
            ),
          ],
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
