import 'package:bbm_tracking/model/kendaraan_m.dart';
import 'package:flutter/material.dart';

class MainCardKendaraan extends StatelessWidget {
  final KendaraanModel? kendaraanModel;

  MainCardKendaraan(this.kendaraanModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          kendaraanModel != null
              ? Image.asset(
                  "assets/images/card.png",
                  width: double.infinity,
                  fit: BoxFit.fill,
                )
              : Image.asset(
                  "assets/images/card_empty.png",
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
          Container(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Text(
                      "Data Pribadi Kendaraan Anda",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Color(0xFF3B3C48),
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        kendaraanModel != null
                            ? kendaraanModel?.jenisKendaraan != "motor"
                                ? Image.asset(
                                    "assets/images/car.png",
                                    width: 120,
                                    height: 120,
                                  )
                                : Image.asset(
                                    "assets/images/motor.png",
                                    width: 120,
                                    height: 120,
                                  )
                            : Image.asset(
                                "assets/images/img_empty.png",
                                width: 110,
                                height: 110,
                              ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Tipe Kendaraan : ",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF25235B),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            kendaraanModel != null
                                                ? kendaraanModel!.namaKendaraan
                                                : "-",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xFFffffff),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Nomor Plat :",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF25235B),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            kendaraanModel != null
                                                ? kendaraanModel!.nomorPlat
                                                : "-",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xFFffffff),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Bahan Bakar saat ini",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF25235B),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 5,
                                    // ),
                                    Text(
                                      kendaraanModel != null
                                          ? kendaraanModel!.bahanBakar
                                          : "-",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFFffffff),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
