import 'package:bbm_tracking/bloc/bbm_bloc.dart';
import 'package:bbm_tracking/pages/onBoard/on_board_start.dart';
import 'package:bbm_tracking/pages/onBoard/splash_screen.dart';
import 'package:bbm_tracking/repository/kendaraan/kendaraan_repository.dart';
import 'package:bbm_tracking/repository/transaksi/transaksi_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color(0xffE3EAEA),
      ),
    );
    return BlocProvider(
      create: (context) => BbmBloc(
        kendaraanRepository: KendaraanRepository(),
        transaksiRepository: TransaksiRepository(),
      )..add(
          BBMStarted(),
        ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplsScreen(),
      ),
    );
  }
}
