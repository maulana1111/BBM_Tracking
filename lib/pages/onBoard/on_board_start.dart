import 'package:bbm_tracking/model/status_m.dart';
import 'package:bbm_tracking/pages/home.dart';
import 'package:bbm_tracking/repository/transaksi/transaksi_repository.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class OnBoardStart extends StatefulWidget {
  const OnBoardStart({super.key});

  @override
  State<OnBoardStart> createState() => _OnBoardStartState();
}

class _OnBoardStartState extends State<OnBoardStart> {
  bool isFirst = true;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    print("object");
    loadData();
  }

  Future<void> loadData() async {
    List<StatusModel> dt = await TransaksiRepository().getStatusIn();
    if (dt.isNotEmpty) {
      setState(() {
        isFirst = false;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> updateFirstIn() async {
    await TransaksiRepository().insertStatusIn();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container()
        : Scaffold(
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
                      isFirst
                          ? showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                updateFirstIn();
                                return showDialogKendaraan(context);
                              },
                            )
                          : Navigator.of(context).pushReplacement(
                              _createRoute(),
                            );
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

Dialog showDialogKendaraan(BuildContext context) {
  return Dialog(
    elevation: 1,
    backgroundColor: Color(0xffE3EAEA),
    child: Container(
      height: 400,
      padding: EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Required Permissions',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Perhatian!",
            ),
            SizedBox(height: 10),
            Text(
              "Kami ingin memberitahukan bahwa kami hanya menggunakan layanan lokasi saat Anda ingin mengisi bensin. Lokasi Anda tidak akan digunakan di latar belakang atau dalam situasi lainnya. Kami menghargai privasi Anda dan hanya menggunakan informasi lokasi yang diberikan saat Anda memilih untuk mengisi bensin. Jika Anda memiliki pertanyaan lebih lanjut tentang penggunaan lokasi dalam aplikasi kami, jangan ragu untuk menghubungi kami",
            ),
            SizedBox(height: 20),
            Text(
              "Terima kasih sudah menggunakan aplikasi BBM Tracking",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Management System",
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
            // Text(
            //   "Pilih Kendaraan",
            //   style: stylee,
            //   textAlign: TextAlign.center,
            // ),
            SizedBox(
              height: 7,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  _createRoute(),
                );
              },
              child: Text(
                "Okay",
                style: TextStyle(
                  color: Color(0xFF677D81),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Home("", ""),
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
