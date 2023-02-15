import 'dart:async';

import 'package:bbm_tracking/onBoard/on_board_start.dart';
import 'package:flutter/material.dart';

class SplsScreen extends StatefulWidget {
  const SplsScreen({super.key});

  @override
  State<SplsScreen> createState() => _SplsScreen();
}

class _SplsScreen extends State<SplsScreen> {
  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
    }

    Timer(
      Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => OnBoardStart()));
      },
    );

    return Scaffold(
      backgroundColor: Color(0xffE3EAEA),
      body: Container(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [Image.asset("assets/images/Logo.png")],
          ),
        ),
      ),
    );
  }
}
