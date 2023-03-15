import 'package:bbm_tracking/pages/AboutApps/component/about.dart';
import 'package:bbm_tracking/pages/AboutApps/component/kebijakan.dart';
import 'package:flutter/material.dart';

class AboutApps extends StatefulWidget {
  const AboutApps({super.key});

  @override
  State<AboutApps> createState() => _AboutAppsState();
}

class _AboutAppsState extends State<AboutApps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE3EAEA),
      body: Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              child: Text(
                "Pengisian Bahan Bakar",
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
            SizedBox(
              height: 20,
            ),
            card("kebijakan"),
            SizedBox(
              height: 5,
            ),
            card("tentang"),
            SizedBox(
              height: 100,
            ),
            Column(
              children: [
                Container(
                  child: Image.asset("assets/images/about_person.png"),
                ),
                Container(
                  child: Text(
                    "Ada Yang Bisa Kami Bantu ?",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Color(0xFF3B3C48),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget card(tujuan) {
    return InkWell(
      onTap: () {
        tujuan == "kebijakan"
            ? Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Kebijakan(),
                ),
              )
            : Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => About (),
                ),
              );
      },
      child: Container(
        width: double.infinity,
        height: 60,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.only(
          left: 15,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: const Offset(
                0.5,
                2.0,
              ),
              blurRadius: 3.0,
              spreadRadius: 2.0,
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              child: Image.asset(
                tujuan == "kebijakan"
                    ? "assets/images/help-circle.png"
                    : "assets/images/user.png",
                width: 30,
                height: 30,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tujuan == "kebijakan"
                        ? "Kebijakan & Privasi"
                        : "Tentang Aplikasi",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 11,
                      color: Color(0xFF455A64),
                    ),
                  ),
                  Text(
                    tujuan == "kebijakan"
                        ? "Baca informasi selengkapnya..."
                        : "Selengkapnya...",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 9,
                      color: Color(0xFF3B3C48),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
