import 'package:bbm_tracking/mainMenu/component/item_bensin.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE3EAEA),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hallo,",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Color(0xFF1A0F0F),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Selamat datang di Aplikasi BBM-Tracking",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Color(0xFF1A0F0F),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    Image.asset(
                      "assets/images/card.png",
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
                                  Image.asset(
                                    "assets/images/car.png",
                                    width: 120,
                                    height: 120,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          child: Row(
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
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xFF25235B),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "Toyota Vitz",
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color:
                                                            Color(0xFFffffff),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 30,
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
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xFF25235B),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "B 506 WLG ",
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color:
                                                            Color(0xFFffffff),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          width: 180,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Bahan Bakar saat ini",
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFF25235B),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Pertalite",
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 10,
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
                Container(
                  width: double.infinity,
                  height: 58,
                  decoration: BoxDecoration(
                    color: Color(0xFF677D81),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: const Offset(
                          0.5,
                          2.0,
                        ),
                        blurRadius: 3.0,
                        spreadRadius: 2.0,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Container(
                          width: 172,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 7,
                              top: 3,
                              bottom: 3,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Pengeluaran",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF1A0F0F),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Image.asset("assets/images/compass.png"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Rp. 0.000",
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF1A0F0F),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 172,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 7,
                              top: 3,
                              bottom: 3,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Bahan Bakar",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF1A0F0F),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Image.asset("assets/images/gas-pump.png"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "0.0 Liter",
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF1A0F0F),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Pembaruan,",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 8,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        " 10 Januari 2023",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 8,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  child: ListView.builder(
                    itemCount: 7,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return ItemBensin();
                    },
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
