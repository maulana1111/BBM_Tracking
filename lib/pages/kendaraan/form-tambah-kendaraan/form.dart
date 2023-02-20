import 'package:flutter/material.dart';

class FormKendaraan extends StatefulWidget {
  String kendaraan;
  FormKendaraan({super.key, required this.kendaraan});

  @override
  State<FormKendaraan> createState() => _FormKendaraanState();
}

class _FormKendaraanState extends State<FormKendaraan> {
  late String kendaraan;
  @override
  void initState() {
    super.initState();
    kendaraan = widget.kendaraan;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE3EAEA),
      body: Container(
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
                height: 75,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  color: Color(0xFFDDB05E),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Image.asset(
                      kendaraan == "motor"
                          ? "assets/images/motor.png"
                          : "assets/images/car.png",
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      kendaraan == "motor" ? "Motor" : "Mobil",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        color: Color(0xFF1A0F0F),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
