import 'package:bbm_tracking/bloc/bbm_bloc.dart';
import 'package:bbm_tracking/model/bensin_m.dart';
import 'package:bbm_tracking/model/kendaraan_m.dart';
import 'package:bbm_tracking/model/transaksiPerMonth_m.dart';
import 'package:bbm_tracking/model/transaksi_m.dart';
import 'package:bbm_tracking/repository/kendaraan/kendaraan_repository.dart';
import 'package:bbm_tracking/repository/transaksi/transaksi_repository.dart';
import 'package:bbm_tracking/resource/component-bersama/chart.dart';
import 'package:bbm_tracking/pages/mainMenu/component/item_bensin.dart';
import 'package:bbm_tracking/resource/component-bersama/card_kendaraan.dart';
import 'package:bbm_tracking/resource/resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
// import 'package:month_year_picker/month_year_picker.dart';
import 'package:simple_month_year_picker/simple_month_year_picker.dart';
import 'package:intl/intl.dart';

class IndexMainMenu extends StatefulWidget {
  const IndexMainMenu({super.key});

  @override
  State<IndexMainMenu> createState() => _IndexMainMenuState();
}

class _IndexMainMenuState extends State<IndexMainMenu> {
  String _toggle = "Harga";
  DateTime? _selected = DateTime.now();
  int totalPengeluaran = 0;
  double totalBBM = 0;
  late int count;

  List<TransaksiPerMonthModel>? dataTransaksiThisMonth;
  List<KendaraanModel>? dataKendaraan;
  List<TransaksiModel>? dataTransaksi;
  KendaraanModel? dataKendaraanObject;
  @override
  void initState() {
    super.initState();
    context.read<BbmBloc>()..add(BBMStarted());
    initializeDateFormatting();
    count = 0;
    loadDataTransaksiThisMonth();
    loadDataKendaraan();
    loadDataTransaksi();

    bool cond = false;
    int i = 0;
    var numK = dataKendaraan?.length ?? 0;
    while (i < numK) {
      if (cond == false) {
        if (dataKendaraan![i].status == 1) {
          dataKendaraanObject = dataKendaraan![i];
          cond = true;
        }
      }
      i++;
    }
    // for (int i = 0; i < dataKendaraan!.length; i++) {
    //   if (cond == false) {
    //     if (dataKendaraan![i].status == 1) {
    //       dataKendaraanObject = dataKendaraan![i];
    //       cond = true;
    //     }
    //   }
    // }

    // if (count == 0) {
    //   dataTransaksi!.forEach((element) {
    //     if (dataKendaraanObject!.status == 1) {
    //       totalPengeluaran += element.totalBayar.toInt();
    //       totalBBM += double.parse(element.totalLiter);
    //     }
    //   });
    //   count++;
    // }
  }

  void loadDataTransaksiThisMonth() async {
    List<TransaksiPerMonthModel> dt = await TransaksiRepository()
        .loadTransaksiThisMonth(DateFormat("yyyy-MM-dd")
            .parse(DateTime.now().toString())
            .toString());
    dt.forEach((element) {
      if (element.kendaraanId == dataKendaraanObject?.id.toString()) {
        setState(() {
          dataTransaksiThisMonth!.add(element);
        });
      }
    });
  }

  void loadDataTransaksi() async {
    List<TransaksiModel> dtM = await TransaksiRepository().loadTransaksi();
    dtM.forEach((element) {
        if (dataKendaraanObject!.status == 1) {
          totalPengeluaran += element.totalBayar.toInt();
          totalBBM += double.parse(element.totalLiter);
        }
    });
    dataTransaksi!.addAll(dtM);
  }

  void loadDataKendaraan() async {
    List<KendaraanModel> dtKendaraan =
        await KendaraanRepository().loadKendaraan();
    setState(() {
      dataKendaraan!.addAll(dtKendaraan);
    });
  }

  TextStyle styleData = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 6,
    color: Color(0xFF3B3C48),
    fontWeight: FontWeight.w500,
  );

  void selectedDate(DateTime time) {
    setState(() {
      _selected = time;
    });
    context
        .read<BbmBloc>()
        .add(BBMChangeDataTransaction(selectedDate: _selected.toString()));
  }

  void selectedToggle(String toogle) {
    setState(() {
      count++;
      _toggle = toogle;
    });
  }

  // String _month = 0;
  // int _year = 0;

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
                    MainCardKendaraan(dataKendaraanObject),
                    SecondWidget(),
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
                            "10 Januari 2023",
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
                    ItemListBensin(listBensin),
                    SizedBox(
                      height: 15,
                    ),
                    DatePerforma(dataTransaksiThisMonth),
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

  Widget DatePerforma(dataTransaksiThisMonth) {
    return Container(
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
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return MonthPicker(
                            onChangeDate: (bulan, tahun) {
                              setState(() {
                                _selected =
                                    DateTime.parse("${tahun}-${bulan}-01");
                              });
                            },
                          );
                        },
                      );
                    },
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
                          // _selected.toString(),
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
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => selectedToggle("Harga"),
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
                          onTap: () => selectedToggle("Liter"),
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
              child: BarChartSample3(
                dataTransaksi: dataTransaksiThisMonth,
                param: _toggle,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text(
                "Bulan : ${DateFormat('MMMM').format(DateTime(0, _selected!.month.toInt()))} ${_selected!.year.toString()}",
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
    );
  }

  Widget SecondWidget() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 4,
      ),
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
            ItemTotalLiterUang("Total Pengeluaran", "pengeluaran"),
            SizedBox(
              width: 10,
            ),
            ItemTotalLiterUang("Total Bahan Bakar", "liter"),
          ],
        ),
      ),
    );
  }

  Widget ItemTotalLiterUang(text, param) {
    return Expanded(
      flex: 1,
      child: Container(
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
                text,
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Poppins',
                  color: Color(0xFF1A0F0F),
                ),
              ),
              Row(
                children: [
                  Image.asset(
                    param == "pengeluaran"
                        ? "assets/images/compass.png"
                        : "assets/images/gas-pump.png",
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    param == "pengeluaran"
                        ? "${CurrencyFormat.convertToIdr(totalPengeluaran, 0)}"
                        : "${totalBBM.toStringAsFixed(2)} Liter",
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
    );
  }

  Widget ItemListBensin(List<BensinModel> dataModel) {
    return Container(
      width: double.infinity,
      height: 80,
      child: Expanded(
        child: ListView.builder(
          itemCount: dataModel.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(right: 10),
              child: ItemBensin(data: dataModel.elementAt(index)),
            );
          },
        ),
      ),
    );
  }
}
