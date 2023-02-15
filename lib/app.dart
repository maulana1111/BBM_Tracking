import 'package:bbm_tracking/onBoard/on_board_start.dart';
import 'package:bbm_tracking/onBoard/splash_screen.dart';
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
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      home: const SplsScreen(),
    );
  }
}
