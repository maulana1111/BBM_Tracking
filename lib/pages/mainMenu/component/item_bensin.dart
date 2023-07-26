import 'package:bbm_tracking/model/bensin_m.dart';
import 'package:bbm_tracking/resource/convert_money/convert_money.dart';
import 'package:flutter/material.dart';

class ItemBensin extends StatelessWidget {
  final BensinModel data;

  const ItemBensin({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 75,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFF677D81),
          width: 1.0,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.text,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF677D81),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF677D81),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Image.asset(
                  "assets/images/gas-pump.png",
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "${CurrencyFormat.convertToIdr(data.harga,0)} /Liter",
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF677D81),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Container(
              width: double.maxFinite,
              child: Text(
                "Update on Juli 24, 2023",
                style: TextStyle(
                  fontSize: 9,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF677D81),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
