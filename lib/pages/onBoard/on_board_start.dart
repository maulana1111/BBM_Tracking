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
  bool isFirst = false;
  bool isLoading = true;

  @override
  void initState() {
    loadData();
    setState(() {
      isLoading = false;
    });
    super.initState();
  }

  Future<void> loadData() async {
    List<StatusModel> dt = await TransaksiRepository().getStatusIn();
    if (dt.isNotEmpty) {
      setState(() {
        isFirst = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
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
          )
        : Container();
  }
}

TextStyle stylee = TextStyle(
  color: Color(0xFF677D81),
  fontSize: 16,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w700,
);

Dialog showDialogKendaraan(BuildContext context) {
  return Dialog(
    elevation: 1,
    backgroundColor: Color(0xffE3EAEA),
    child: Container(
      height: 230,
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
            "By using this [application/platform/website], you agree to grant us the following permissions:",
          ),
          SizedBox(height: 10),
          Text(
            "1. Camera Access: We may request access to your device's camera in order to enable [specific feature, e.g., video recording, photo capture].",
          ),
          Text(
            "2. Microphone Access: We may request access to your device's microphone to enable [specific feature, e.g., audio recording, voice input].",
          ),
          Text(
            "3. Location Access: We may request access to your device's location to provide [specific feature, e.g., location-based services, mapping].",
          ),
          Text(
            "4. Storage Access: We may request access to your device's storage to save and retrieve [specific content, e.g., images, videos, documents].",
          ),
          Text(
            "5. Internet Connectivity: Our application requires an active internet connection to [function properly, e.g., load content, sync data].",
          ),
          SizedBox(height: 20),
          Text(
            "These permissions are necessary for the proper functioning of the [application/platform/website] and to provide you with a seamless user experience. We assure you that your data and privacy will be handled according to our [Privacy Policy/Terms of Service], and we do not collect or share any personal information without your consent.",
          ),
          SizedBox(height: 20),
          Text(
            "You can manage and revoke these permissions in your device settings at any time. If you have any concerns or questions regarding these permissions, please feel free to contact our support team at [contact email/phone number].",
          ),
          SizedBox(height: 20),
          Text(
            "Thank you for using [application/platform/website]!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "[Your Company/Developer Name]",
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
