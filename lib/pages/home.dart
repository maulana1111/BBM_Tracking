import 'package:bbm_tracking/pages/kendaraan/form-tambah-kendaraan/form.dart';
import 'package:bbm_tracking/pages/kendaraan/index_kendaraan.dart';
import 'package:bbm_tracking/pages/mainMenu/component/chart.dart';
import 'package:bbm_tracking/pages/mainMenu/component/item_bensin.dart';
import 'package:bbm_tracking/pages/mainMenu/index.dart';
import 'package:flutter/material.dart';
import 'package:pandabar/main.view.dart';
import 'package:pandabar/model.dart';

class Home extends StatefulWidget {
  final String screen;
  final String param;

  Home(this.screen, this.param);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String screen;
  late String param;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    screen = widget.screen;
    param = widget.param;
  }

  String page = 'home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE3EAEA),
      bottomNavigationBar: PandaBar(
        backgroundColor: Color(0xFFD2E1E1),
        buttonSelectedColor: Color(0xFFFC8D05),
        fabColors: [Color(0xFFFC8D05), Color(0xFFDDB05E)],
        buttonData: [
          PandaBarButtonData(
            id: 'home',
            icon: Icons.home,
            title: 'Home',
          ),
          PandaBarButtonData(
            id: 'kendaraan',
            icon: Icons.directions_car_filled_outlined,
            title: 'Kendaraan',
          ),
          PandaBarButtonData(
            id: 'jelajah',
            icon: Icons.language,
            title: 'Jelajah',
          ),
          PandaBarButtonData(
            id: 'tentang',
            icon: Icons.assignment_late_outlined,
            title: 'Tentang',
          ),
        ],
        onChange: (id) {
          setState(() {
            screen = id;
          });
        },
        onFabButtonPressed: () {},
      ),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Builder(
              builder: (context) {
                // print("screen = " + param);
                switch (screen) {
                  case 'home':
                    return IndexMainMenu();
                  case 'kendaraan':
                    return IndexKendaraan();
                  case 'kendaraan':
                    return IndexMainMenu();
                  case 'kendaraan':
                    return IndexMainMenu();
                  case 'formKendaraan':
                    return FormKendaraan(
                      kendaraan: param,
                    );
                  default:
                    return IndexMainMenu();
                }
              },
            )),
      ),
    );
  }
}
