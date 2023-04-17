import 'package:bbm_tracking/pages/home.dart';
import 'package:bbm_tracking/pages/simulation/index.dart';
import 'package:bbm_tracking/resource/resource.dart';
import 'package:flutter/material.dart';

class Performa extends StatefulWidget {
  const Performa({super.key});

  @override
  State<Performa> createState() => _PerformaState();
}

class _PerformaState extends State<Performa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE3EAEA),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            margin: EdgeInsets.only(top: 54),
            child: SingleChildScrollView(
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
                      "Performa Kendaraan",
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
                  // MainCardKendaraan(),
                  InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SimulationScreen())),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 15,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFF1C40F),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Buat Simulasi Kendaraan Anda",
                          style: TextStyle(
                            color: Color(0xFF1C7A44),
                            fontFamily: 'Poppins',
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color(0xffE3EAEA),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: const Offset(
                            0.5,
                            2.0,
                          ),
                          blurRadius: 5.0,
                          spreadRadius: 2.0,
                        )
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(9),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            height: 190,
                            // child: BarChartSample3(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Text(
                              "Bulan : Januari 2023",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: Color(0xFF1A0F0F),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Status Performa Kendaraan Anda minggu ini",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Status Performa",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  itemData("Status", "Baik"),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Detail Informasi",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  itemData("Merek kendaraan", "Honda Beat"),
                  itemData("Jumlah biaya", "Rp. 600.000"),
                  itemData("Jumlah liter bensin", "6 Liter"),
                  itemData("Cubicle Centimeter", "250"),
                  itemData("Jenis Bahan Bakar", "Pertalite"),
                  itemData("Odometer", "304761,25 km"),
                  itemData("Km Tempuh per hari", "8.5 km"),
                  itemData("Total Km Tempuh", "318 km"),
                  itemData("Priode pemakaian", "01 Januari 2023 - 31 Januari 2023")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget itemData(key, value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 6),
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 12,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9),
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Text(
                key,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 12,
              ),
              margin: EdgeInsets.symmetric(horizontal: 6),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFBFE5DF),
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Text(
                value,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
