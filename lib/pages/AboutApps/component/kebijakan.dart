import 'package:bbm_tracking/pages/home.dart';
import 'package:bbm_tracking/resource/resource.dart';
import 'package:flutter/material.dart';

class Kebijakan extends StatefulWidget {
  const Kebijakan({super.key});

  @override
  State<Kebijakan> createState() => _KebijakanState();
}

class _KebijakanState extends State<Kebijakan> {
  TextStyle styles = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    fontWeight: FontWeight.w200,
  );
  TextStyle styles1 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    fontWeight: FontWeight.w700,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE3EAEA),
      body: Container(
        child: SingleChildScrollView(
          reverse: true,
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    height: 55,
                  ),
                  Container(
                    child: InkWell(
                      onTap: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => Home("tentang", ""))),
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            size: 15,
                          ),
                          Text(
                            "Kembali",
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              color: Color(0xff1A0F0F),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "Kebijakan & Privasi",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        color: Color(0xff1A0F0F),
                      ),
                    ),
                  ),
                  Divider(
                    color: Color(0xFF1A0F0F3D),
                    height: 2,
                    thickness: 2,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Image.asset(
                            "assets/images/logoMesinPom.png",
                            width: 35,
                            height: 40,
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "BBM",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF3B3C48),
                                ),
                              ),
                              Text(
                                "Tracking",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF3B3C48),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Text(
                      Kebijakan1,
                      style: styles,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Text(
                      Kebijakan2,
                      style: styles,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Text(
                      Kebijakan3,
                      style: styles,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            Salam1,
                            style: styles,
                          ),
                        ),
                        Container(
                          child: Text(
                            Salam2,
                            style: styles1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
