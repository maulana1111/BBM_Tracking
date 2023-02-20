import 'package:bbm_tracking/model/Kendaraan_model.dart';
import 'package:bbm_tracking/pages/home.dart';
import 'package:bbm_tracking/pages/kendaraan/component/card-kendaraan.dart';
import 'package:bbm_tracking/pages/kendaraan/form-tambah-kendaraan/form.dart';
import 'package:flutter/material.dart';

class IndexKendaraan extends StatefulWidget {
  const IndexKendaraan({super.key});

  @override
  State<IndexKendaraan> createState() => _IndexKendaraanState();
}

class _IndexKendaraanState extends State<IndexKendaraan> {
  bool condSlide = false;

  List<Kendaraan> _dataKendaraan = [
    new Kendaraan(
      id: 1,
      jenisKendaraan: 'motor',
      namaKendaraan: 'Supra',
      nomorPlat: 'B 1001 SWW',
      bahanBakar: 'Pertalite',
      status: false,
    ),
    new Kendaraan(
      id: 2,
      jenisKendaraan: 'mobil',
      namaKendaraan: 'Toyota',
      nomorPlat: 'B 1001 SWW',
      bahanBakar: 'Pertamax',
      status: false,
    ),
    new Kendaraan(
      id: 3,
      jenisKendaraan: 'motor',
      namaKendaraan: 'Ninja',
      nomorPlat: 'B 1001 SWW',
      bahanBakar: 'Pertamax Plus',
      status: true,
    ),
  ];

  void changeStatuKendaraan(id, status) {
    for (var i = 0; i < _dataKendaraan.length; i++) {
      if (_dataKendaraan[i].status == true) {
        setState(() {
          _dataKendaraan[i].status = false;
        });
      }
    }
    for (var i = 0; i < _dataKendaraan.length; i++) {
      if (_dataKendaraan[i].id == id) {
        setState(() {
          _dataKendaraan[i].status = status;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE3EAEA),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return showDialogKendaraan();
            },
          );
        },
        backgroundColor: Color(0xFF677D81),
        child: Icon(
          Icons.add,
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Container(
                      child: InkWell(
                        onTap: () {},
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
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        "Data Pribadi Kendaraan Anda",
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
                      height: 15,
                    ),
                    Container(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: _dataKendaraan.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return CardKendaraan(
                            kendaraan: _dataKendaraan[index],
                            onChangeStatus: (int id, bool status) {
                              changeStatuKendaraan(id, status);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Dialog showDialogKendaraan() {
    return Dialog(
      elevation: 1,
      backgroundColor: Color(0xffE3EAEA),
      child: Container(
        height: 230,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Pilih Kendaraan",
              style: TextStyle(
                color: Color(0xFF677D81),
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => FormKendaraan(
                //       kendaraan: "motor",
                //     ),
                //   ),
                // );
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Home("formKendaraan", "motor"),
                  ),
                );
              },
              child: chooseKendaraan(
                "assets/images/motor.png",
                "Motor",
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Divider(
              color: Color(0xFFECDEDE),
              height: 2,
              thickness: 2,
            ),
            SizedBox(
              height: 7,
            ),
            InkWell(
              onTap: () {},
              child: chooseKendaraan("assets/images/car.png", "Mobil"),
            ),
          ],
        ),
      ),
    );
  }

  Container chooseKendaraan(image, text) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: Row(
        children: [
          Image.asset(
            image,
            width: 50,
            height: 50,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            text,
            style: TextStyle(
              color: Color(0xFF677D81),
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
