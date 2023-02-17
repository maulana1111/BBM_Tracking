import 'package:flutter/material.dart';

class ItemBensin extends StatelessWidget {
  const ItemBensin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 153,
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
                  "Pertalite",
                  style: TextStyle(
                    fontSize: 10,
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
                  "Rp. 10.000 /Liter",
                  style: TextStyle(
                    fontSize: 8,
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
                "Update on January 06, 2023",
                style: TextStyle(
                  fontSize: 8,
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
