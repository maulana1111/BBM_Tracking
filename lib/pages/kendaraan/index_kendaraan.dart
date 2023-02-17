import 'package:bbm_tracking/model/Kendaraan_model.dart';
import 'package:bbm_tracking/pages/kendaraan/component/card-kendaraan.dart';
import 'package:flutter/material.dart';

class IndexKendaraan extends StatefulWidget {
  const IndexKendaraan({super.key});

  @override
  State<IndexKendaraan> createState() => _IndexKendaraanState();
}

class _IndexKendaraanState extends State<IndexKendaraan> {
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
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(10),
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
    );
  }
}
