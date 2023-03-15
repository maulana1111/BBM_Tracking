import 'package:bbm_tracking/resource/component-bersama/chart.dart';
import 'package:bbm_tracking/pages/mainMenu/component/item_bensin.dart';
import 'package:bbm_tracking/resource/component-bersama/card_kendaraan.dart';
import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

class IndexMainMenu extends StatefulWidget {
  const IndexMainMenu({super.key});

  @override
  State<IndexMainMenu> createState() => _IndexMainMenuState();
}

class _IndexMainMenuState extends State<IndexMainMenu> {
  String _toggle = "Harga";
  DateTime? _selected = DateTime.now();

  TextStyle styleData = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 6,
    color: Color(0xFF3B3C48),
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Stack(
            children: [
              Container(
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
                    MainCardKendaraan(),
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
                                        Image.asset(
                                          "assets/images/compass.png",
                                        ),
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
                                        Image.asset(
                                            "assets/images/gas-pump.png"),
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
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      height: 80,
                      decoration: BoxDecoration(
                          // color: Colors.amber,
                          ),
                      child: Expanded(
                        child: ListView.builder(
                          itemCount: 7,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.only(right: 10),
                              child: ItemBensin(),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      height: 300,
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
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () => _onPressed(context: context),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 2,
                                          color: Color(0xffDDB05E),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 5,
                                        ),
                                        child: Text(
                                          DateFormat(
                                            "MMMM yyyy",
                                            "id_ID",
                                          ).format(_selected!),
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12,
                                            color: Color(0xFF1A0F0F),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 130,
                                    height: 30,
                                    alignment: Alignment.topRight,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 197, 129, 74),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(4),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              _toggle = "Harga";
                                            });
                                          },
                                          child: Container(
                                            width: 65,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: _toggle == "Harga"
                                                  ? Color(0xFF677D81)
                                                  : Color(0xFFffffff),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(4),
                                              ),
                                            ),
                                            child: Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Text(
                                                "Harga",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  color: _toggle == "Harga"
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              _toggle = "Liter";
                                            });
                                          },
                                          child: Container(
                                            width: 65,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: _toggle == "Harga"
                                                  ? Color(0xFFffffff)
                                                  : Color(0xFF677D81),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(4),
                                              ),
                                            ),
                                            child: Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Text(
                                                "Liter",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  color: _toggle == "Harga"
                                                      ? Colors.black
                                                      : Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
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
                              width: double.infinity,
                              height: 190,
                              child: BarChartSample3(),
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
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onPressed({
    required BuildContext context,
    String? locale,
  }) async {
    final localeObj = locale != null ? Locale(locale) : null;
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: _selected ?? DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
      locale: localeObj,
    );
    // final selected = await showDatePicker(
    //   context: context,
    //   initialDate: _selected ?? DateTime.now(),
    //   firstDate: DateTime(2019),
    //   lastDate: DateTime(2022),
    //   locale: localeObj,
    // );
    if (selected != null) {
      setState(() {
        _selected = selected;
      });
    }
  }
}
