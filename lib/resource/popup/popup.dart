import 'package:flutter/material.dart';

class PopUp extends StatefulWidget {
  String text, param;
  PopUp({super.key, required this.text, required this.param});

  @override
  State<PopUp> createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      backgroundColor: Color(0xffE3EAEA),
      child: Container(
        height: 200,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                widget.param == "negative" ? "assets/images/sad_person.png" : "assets/images/about_person.png",
                width: 70,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.text,
                style: TextStyle(
                  color: Color(0xFF677D81),
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
