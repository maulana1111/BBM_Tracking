import 'package:bbm_tracking/bloc/bbm_bloc.dart';
import 'package:bbm_tracking/model/kendaraan_m.dart';
import 'package:bbm_tracking/model/transaksi_m.dart';
import 'package:bbm_tracking/pages/AboutApps/index.dart';
import 'package:bbm_tracking/pages/form-tambah-data-bensin/index.dart';
import 'package:bbm_tracking/pages/kendaraan/form-tambah-kendaraan/form.dart';
import 'package:bbm_tracking/pages/kendaraan/index_kendaraan.dart';
import 'package:bbm_tracking/repository/kendaraan/kendaraan_repository.dart';
import 'package:bbm_tracking/repository/transaksi/transaksi_repository.dart';
import 'package:bbm_tracking/resource/component-bersama/chart.dart';
import 'package:bbm_tracking/pages/mainMenu/component/item_bensin.dart';
import 'package:bbm_tracking/pages/mainMenu/index.dart';
import 'package:bbm_tracking/pages/riwayat/index.dart';
import 'package:bbm_tracking/resource/popup/popup.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  late String screen = 'home';
  late String param;
  late List<KendaraanModel> dataKendaraan;
  KendaraanModel? dt;
  late bool paramKendaran = false;
  late int paramText = 0;
  late bool cond = false;
  var firstCamera;

  void ButtonAddTransaksi() {
    if (dataKendaraan != null || dataKendaraan.length != 0) {
      for (KendaraanModel element in dataKendaraan) {
        if (element.status == 1) {
          paramKendaran = true;
          dt = element;
          cond = true;
          paramText = 2;
          break;
        }
        paramKendaran = false;
        paramText = 1;
      }
    } else {
      paramKendaran = false;
      paramText = 0;
    }
    if (paramKendaran == true) {
      print("object kendaraan = " + dt!.id.toString());
    }
    // paramKendaran
    //     ? Navigator.of(context).push(
    //         MaterialPageRoute(
    //           builder: (context) => FormTamabahDataBensin(
    //             kendaraanModel: dt,
    //             camera: firstCamera,
    //             key: UniqueKey(),
    //           ),
    //         ),
    //       )
    //     : showDialog(
    //         context: context,
    //         builder: (BuildContext context) {
    //           return PopUp(
    //             text: paramText == 1
    //                 ? "Maaf, Silakan aktifkan kendaraan Anda terlebih dahulu"
    //                 : "Maaf, Silakan tambahkan kendaraan Anda terlebih dahulu",
    //             param: "negative",
    //           );
    //         },
    //       );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    screen = widget.screen;
    param = widget.param;
    // setState(() {
    //   widget.screen != null ? screen = "${widget.screen}" : screen = "home";
    // });
    initilizeCamera();
  }

  Future<void> initilizeCamera() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    setState(() {
      firstCamera = cameras.first;
    });
  }

  // String page = 'home';
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
            id: 'riwayat',
            icon: Icons.account_balance_wallet_outlined,
            title: 'Riwayat',
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
        onFabButtonPressed: () {
          setState(() {
            context.read<BbmBloc>().add(BBMStarted());
          });
          ButtonAddTransaksi();
        },
      ),
      body: BlocBuilder<BbmBloc, BbmState>(
        builder: (context, state) {
          if (state is BBMLoaded) {
            dataKendaraan = state.kendaraan;
            return SafeArea(
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
                        // context.read<BbmBloc>().add(BBMStarted());
                        return IndexMainMenu();
                      case 'kendaraan':
                        // context.read<BbmBloc>().add(BBMAllDataKendaraan());
                        return IndexKendaraan();
                      case 'riwayat':
                        return Riwayat();
                      case 'tentang':
                        return AboutApps();
                      default:
                        return IndexMainMenu();
                    }
                  },
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
