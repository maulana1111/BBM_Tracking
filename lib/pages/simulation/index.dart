import 'package:flutter/material.dart';

class SimulationScreen extends StatefulWidget {
  const SimulationScreen({super.key});

  @override
  State<SimulationScreen> createState() => _SimulationScreenState();
}

class _SimulationScreenState extends State<SimulationScreen> {
  List<String> data = ["satu", "Dua", "tiga", "empat"];

  bool toogleTipe = false;
  bool toogleBBM = false;
  bool tooglePriode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE3EAEA),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            margin: EdgeInsets.only(top: 52),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 70,
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
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "Simulasi Pemakaian",
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
                  height: 6,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Simulasi Performa Bahan Bakar Kendaraan",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFBFE5DF),
                    // border: Border(
                    //   bottom: BorderSide(width: 1.5, color: Colors.grey.shade300),
                    // ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "-- Pilih Tipe Kendaraan --",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            color: Color(0xFF677D81),
                          ),
                        ),
                      ),
                      Container(
                        child: Icon(
                          Icons.arrow_circle_down,
                          color: Color(0xFFAEAEAE),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFBFE5DF),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    "-- Pilih Tipe Kendaraan --",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      color: Color(0xFF677D81),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
