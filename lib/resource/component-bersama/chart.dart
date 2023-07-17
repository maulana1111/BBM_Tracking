// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
// import 'package:fl_chart_app/util/extensions/color_extensions.dart';
import 'package:bbm_tracking/model/transaksiPerMonth_m.dart';
import 'package:bbm_tracking/model/transaksi_m.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartSample3 extends StatefulWidget {
  List<TransaksiPerMonthModel> dataTransaksi;
  String param;
  BarChartSample3({required this.dataTransaksi, required this.param, Key? key}): super(key: key);

  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  List<double> dtTotalBayar = [];
  List<double> dtTotalLiter = [];
  late List<TransaksiPerMonthModel> dtTransaksi;
  DateTime today = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dtTransaksi = widget.dataTransaksi;
    final daysInMonth = DateTime(today.year, today.month + 1, 0).day;

    for (var i = 1; i <= daysInMonth; i++) {
      if (dtTransaksi.length > 0) {
        for(int j = 0; j < dtTransaksi.length; j++)
        {
          if(i == dtTransaksi[j].tanggalTransaksi.day)
          {
            dtTotalBayar.add(dtTransaksi[j].totalBayar.toDouble());
            dtTotalLiter.add(dtTransaksi[j].totalLiter);
            break;
          }else{
            dtTotalBayar.add(0);
            dtTotalLiter.add(0);
            break;
          }
        }
      } else {
        dtTotalBayar.add(0);
        dtTotalLiter.add(0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.param);
    return AspectRatio(
      aspectRatio: 1.6,
      child: widget.param == "Harga"
          ? SfSparkLineChart(
              //Enable the trackball
              trackball: SparkChartTrackball(
                activationMode: SparkChartActivationMode.tap,
                color: Colors.black,
              ),
              //Enable marker
              marker: SparkChartMarker(
                  displayMode: SparkChartMarkerDisplayMode.all,
                  color: Colors.black),
              //Enable data label
              labelDisplayMode: SparkChartLabelDisplayMode.none,
              color: Color(0xFFFC8D05),
              // dashArray: [],
              data: dtTotalBayar,
            )
          : SfSparkLineChart(
              //Enable the trackball
              trackball: SparkChartTrackball(
                activationMode: SparkChartActivationMode.tap,
                color: Colors.black,
              ),
              //Enable marker
              marker: SparkChartMarker(
                  displayMode: SparkChartMarkerDisplayMode.all,
                  color: Colors.black),
              //Enable data label
              labelDisplayMode: SparkChartLabelDisplayMode.none,
              color: Color(0xFFFC8D05),
              // dashArray: [],
              data: dtTotalLiter,
            ),
    );
  }
}
