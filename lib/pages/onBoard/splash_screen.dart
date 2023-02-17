import 'dart:async';

import 'package:bbm_tracking/pages/onBoard/on_board_start.dart';
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
          _createRoute(),
        );
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

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const OnBoardStart(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(4.0, 3.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
