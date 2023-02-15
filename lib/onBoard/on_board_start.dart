import 'package:bbm_tracking/mainMenu/home.dart';
import 'package:flutter/material.dart';

class OnBoardStart extends StatefulWidget {
  const OnBoardStart({super.key});

  @override
  State<OnBoardStart> createState() => _OnBoardStartState();
}

class _OnBoardStartState extends State<OnBoardStart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE3EAEA),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: ,
          children: [
            Image.asset('assets/images/firstIcon.png'),
            Text(
              "BBM",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 40,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            Column(
              children: [
                Text(
                  "Lacak & Pantau bahan bakar",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF1A0F0F),
                  ),
                ),
                Text(
                  "Kendaraan Anda",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF1A0F0F),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Dapat dengan mudah memantau penggunaan bahan bakar atau BBM yang kendaraan Anda gunakan ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF3B3C48),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Home()));
                // print("object");
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: 100,
                      right: 100,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFFFC8D05),
                        width: 25.0,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/images/arrow-right.png',
                    width: 40,
                    height: 40,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
