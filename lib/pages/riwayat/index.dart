import 'package:bbm_tracking/pages/riwayat/component/item-history.dart';
import 'package:flutter/material.dart';

class Riwayat extends StatefulWidget {
  const Riwayat({super.key});

  @override
  State<Riwayat> createState() => _RiwayatState();
}

class _RiwayatState extends State<Riwayat> {
  String kendaraan = 'motor';
  late String _tab = 'selesai';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  "Riwayat Transaksi Pengisian Anda",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                    color: Color(0xff1A0F0F),
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
                height: 75,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  color: Color(0xFFFC8D05),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Tipe Kendaraan : ",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11,
                            color: Color(0xFF3B3C48),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Toyota Vitz / B 1000 JAJ",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: Text(
                  "Ganti Kendaraan",
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF1C7A44),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _tab = 'selesai';
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "Selesai",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Divider(
                                color: _tab == 'selesai'
                                    ? Color(0xFF58D68D)
                                    : Colors.transparent,
                                height: 2,
                                thickness: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _tab = 'draft';
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "Draft",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Divider(
                                color: _tab == 'draft'
                                    ? Color(0xFF58D68D)
                                    : Colors.transparent,
                                height: 2,
                                thickness: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
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
                  "Anda memiliki 2300 data transaksi",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF828282),
                  ),
                ),
              ),
              SizedBox(
                height: 7,
              ),
              // SingleChildScrollView(
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width, 
                child: Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 400),
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return ItemHistory();
                    },
                  ),
                ),
              ),
              // )
            ],
          ),
        ),
      ),
    );
  }

}
