import 'package:bbm_tracking/model/Kendaraan_model.dart';
import 'package:bbm_tracking/model/kendaraan_m.dart';
import 'package:bbm_tracking/pages/component/custom_dialog_box.dart';
import 'package:flutter/material.dart';

class CardKendaraan extends StatefulWidget {
  final KendaraanModel kendaraan;
  final Function onChangeStatus;
  CardKendaraan({
    required this.kendaraan,
    required this.onChangeStatus,
    Key? key
  }) : super(key: key);

  @override
  State<CardKendaraan> createState() => _CardKendaraanState();
}

class _CardKendaraanState extends State<CardKendaraan> {
  late KendaraanModel kendaraan;
  late Function onChangeStatus;
  @override
  void initState() {
    super.initState();
    kendaraan = widget.kendaraan;
    onChangeStatus = widget.onChangeStatus;
  }

  int count = 0;
  changeStatus(id, status)
  {
    onChangeStatus(id, status);
  }
  TextStyle styleText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: Color(0xFF3B3C48),
  );

  TextStyle cardTitle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: Color(0xFF3B3C48),
  );

  TextStyle cardData = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xFFFFFFFF),
  );

  @override
  Widget build(BuildContext context) {
    print("child rerender = ");
    return InkWell(
      key: widget.key,
      onTap: () {
        kendaraan.status == 0
            ? showDialog(
                context: context,
                builder: (BuildContext context) {
                  return showDialogError();
                },
              )
            : print("object");
      },
      child: Container(
        width: double.infinity,
        height: 135,
        margin: EdgeInsets.only(
          top: 8,
          bottom: 8,
        ),
        decoration: BoxDecoration(
          color: kendaraan.status == 1 ? Color(0xFFFC8D05) : Color(0xFFDDB05E),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      kendaraan.status == 1
                          ? "Kendaraan Anda Saat ini"
                          : "Kendaraan Lainnya",
                      style: styleText,
                    ),
                  ),
                  Container(
                    // padding: EdgeInsets.all(10),
                    child: Switch(
                      activeColor: Color(0xFFDDB05E),
                      activeTrackColor: Colors.white,
                      inactiveThumbColor: Color(0xFFE3EAEA),
                      inactiveTrackColor: Colors.white,
                      splashRadius: 50,
                      value: kendaraan.status == 0 ? false : true,
                      onChanged: (value) {
                        kendaraan.status == 0
                            ? showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomeDialogBox(
                                    title: 'Aktifkan Kendaraan?',
                                    description:
                                        'Anda dapat melihat semua detail data kendaraan ketika status kendaraan sudah aktif kembali',
                                    positiveText: "Ya, Aktifkan",
                                    negativeText: "Batalkan",
                                    screen: "cardKendaraan",
                                    onChangeStatus: () => {
                                      changeStatus(kendaraan.id, 1),
                                    },
                                  );
                                },
                              )
                            : changeStatus(kendaraan.id, 0);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tipe Kendaraan : ",
                                  style: cardTitle,
                                ),
                                Text(
                                  "${kendaraan.namaKendaraan}",
                                  style: cardData,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Nomor Plat : ",
                                  style: cardTitle,
                                ),
                                Text(
                                  "${kendaraan.nomorPlat}",
                                  style: cardData,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Bahan Bakar saat ini ",
                              style: cardTitle,
                            ),
                            Text(
                              "${kendaraan.bahanBakar}",
                              style: cardData,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Image.asset(
                      kendaraan.jenisKendaraan == "mobil"
                          ? "assets/images/car.png"
                          : "assets/images/motor.png",
                      width: 80,
                      height: 80,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Dialog showDialogError() {
    return Dialog(
      elevation: 1,
      backgroundColor: Colors.white,
      child: Container(
        height: 230,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/error_kendaraan.png"),
            SizedBox(
              height: 25,
            ),
            Text(
              "Maaf, Anda menonaktifkan kendaraan ini",
              style: TextStyle(
                color: Color(0xFF677D81),
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
