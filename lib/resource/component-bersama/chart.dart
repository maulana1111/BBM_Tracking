// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
// import 'package:fl_chart_app/util/extensions/color_extensions.dart';
import 'package:bbm_tracking/model/transaksi_m.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class _BarChart2 extends StatefulWidget {
  List<TransaksiModel> dataTransaksi;
  String? param;
  _BarChart2({required this.dataTransaksi, required param});

  @override
  State<_BarChart2> createState() => _BarChart2State();
}

class _BarChart2State extends State<_BarChart2> {
  List<double> dtTotalBayar = [];
  List<double> dtTotalLiter = [];
  late List<TransaksiModel> dtTransaksi;
  String? param;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    param = widget.param;
    dtTransaksi = widget.dataTransaksi;
    dtTransaksi.forEach((element) {
      dtTotalBayar.add(element.totalBayar);
      dtTotalLiter.add(element.totalLiter);
    });
    if(dtTotalBayar.length < 30)
    {
      bool cond = true;
      while(cond == true)
      {
        dtTotalBayar.length != 30 ? dtTotalBayar.add(0) : cond = false;
      }
    }
    if(dtTotalLiter.length < 30)
    {
      bool cond = true;
      while(cond == true)
      {
        dtTotalLiter.length != 30 ? dtTotalLiter.add(0) : cond = false;
      }
    }
    print(dtTotalBayar);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfSparkLineChart(
        //Enable the trackball
        trackball: SparkChartTrackball(
          activationMode: SparkChartActivationMode.tap,
          color: Colors.black,
        ),
        //Enable marker
        marker: SparkChartMarker(
            displayMode: SparkChartMarkerDisplayMode.all, color: Colors.black),
        //Enable data label
        labelDisplayMode: SparkChartLabelDisplayMode.none,
        color: Color(0xFFFC8D05),
        // dashArray: [],
        data: param == "Harga" ? dtTotalBayar : dtTotalLiter,
      ),
    );
  }
}

class BarChartSample3 extends StatefulWidget {
  List<TransaksiModel> dataTransaksi;
  String param;
  BarChartSample3({required this.dataTransaksi, required this.param});

  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: _BarChart2(dataTransaksi: widget.dataTransaksi, param: widget.param),
    );
  }
}
