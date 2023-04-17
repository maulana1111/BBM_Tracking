import 'package:bbm_tracking/resource/resource.dart';
import 'package:flutter/material.dart';

class MonthPicker extends StatefulWidget {
  // final Function onChangeNextMonth;
  final Function onChangeDate;
  // final String bulan;

  const MonthPicker({
    super.key,
    required this.onChangeDate,
    // required this.onChangBeforeMonth,
    // required this.bulan
  });

  @override
  State<MonthPicker> createState() => _MonthPickerState();
}

class _MonthPickerState extends State<MonthPicker> {
  late Function onChangeDate;

  int _month = 0;
  int _year = 2023;
  String mon = "";

  @override
  void initState() {
    super.initState();
    onChangeDate = widget.onChangeDate;
  }

  void nextMonth() {
    setState(() {
      _month == 11 ? _month = 0 : _month = _month + 1;
    });
    // print(bulan.elementAt(_month));
  }

  void beforeMonth() {
    setState(() {
      _month == 0 ? _month = 11 : _month = _month - 1;
    });
    // print(bulan.elementAt(_month));
  }

  void nextYear() {
    setState(() {
      _year = _year + 1;
    });
    // print(bulan.elementAt(_month));
  }

  void beforeYear() {
    setState(() {
      _year > 2023 ? _year = _year - 1 : null;
    });
    // print(bulan.elementAt(_month));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      backgroundColor: Color(0xffE3EAEA),
      child: Container(
        height: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Pilih Tanggal",
              style: TextStyle(
                color: Color(0xFF677D81),
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () => nextMonth(),
                        child: Icon(
                          Icons.arrow_drop_up,
                          size: 50,
                        ),
                      ),
                      Text(
                        bulan.elementAt(_month),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      InkWell(
                        onTap: () => beforeMonth(),
                        child: Icon(
                          Icons.arrow_drop_down,
                          size: 50,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () => nextYear(),
                        child: Icon(
                          Icons.arrow_drop_up,
                          size: 50,
                        ),
                      ),
                      Text(
                        _year.toString(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      InkWell(
                        onTap: () => beforeYear(),
                        child: Icon(
                          Icons.arrow_drop_down,
                          size: 50,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                if (_month < 10) {
                  mon = "0" + (_month + 1).toString();
                }
                onChangeDate(mon.toString(), _year.toString());
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 17,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                  color: Color(0xFF2ECC71),
                ),
                child: Text(
                  "Selesai",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
