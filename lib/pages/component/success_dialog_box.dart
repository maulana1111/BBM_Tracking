import 'package:flutter/material.dart';

class SuccessDialogBox extends StatefulWidget {
  String deskripsi;
  SuccessDialogBox({
    super.key,
    required this.deskripsi,
  });

  @override
  State<SuccessDialogBox> createState() => _SuccessDialogBoxState();
}

class _SuccessDialogBoxState extends State<SuccessDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 160,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Color(0xFF2ECC71),
          borderRadius: BorderRadius.circular(10),
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
        child: Column(
          children: [
            Image.asset('assets/images/success.png'),
            SizedBox(
              height: 10,
            ),
            Text(
              "BERHASIL",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.deskripsi,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 10,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
