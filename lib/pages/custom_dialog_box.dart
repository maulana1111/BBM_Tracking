import 'package:flutter/material.dart';

class CustomeDialogBox extends StatefulWidget {
  String title, description, positiveText, negativeText, screen;
  final Function onChangeStatus;

  CustomeDialogBox({
    super.key,
    required this.title,
    required this.description,
    required this.positiveText,
    required this.negativeText,
    required this.screen,
    required this.onChangeStatus,
  });

  @override
  State<CustomeDialogBox> createState() => _CustomeDialogBoxState();
}

class _CustomeDialogBoxState extends State<CustomeDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
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
          Container(
            width: double.infinity,
            child: Text(
              widget.title,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Color(0xFF29170B),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            child: Text(
              widget.description,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 11,
                color: Color(0xFF080705),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    child: Text(
                      widget.negativeText,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Color(0xFF29170B),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    widget.onChangeStatus();
                  },
                  child: Container(
                    width: 115,
                    padding: EdgeInsets.fromLTRB(
                      10,
                      10,
                      10,
                      10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFF2ECC71),
                    ),
                    child: Text(
                      widget.positiveText,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Color(0xFFFFFFFF),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
