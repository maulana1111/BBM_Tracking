import 'package:bbm_tracking/resource/resource.dart';
import 'package:flutter/material.dart';

class SimulationScreen extends StatefulWidget {
  const SimulationScreen({super.key});

  @override
  State<SimulationScreen> createState() => _SimulationScreenState();
}

class _SimulationScreenState extends State<SimulationScreen> {
  List<String> tipe_kendaraan = ["Motor", "Mobil"];
  List<String> merek_kendaraan = ["Beat", "NMax", "PCX", "Ninja"];

  bool toogleTipe = false;
  bool toogleMerek = false;
  bool toogleBBM = false;
  bool tooglePriode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE3EAEA),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            margin: EdgeInsets.only(top: 52),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 70,
                    child: InkWell(
                      onTap: () {},
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
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "Simulasi Pemakaian",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color(0xff3B3C48),
                    ),
                  ),
                ),
                Divider(
                  color: Color(0xFF1A0F0F3D),
                  height: 2,
                  thickness: 2,
                ),
                SizedBox(
                  height: 6,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Simulasi Performa Bahan Bakar Kendaraan",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FormField("-- Pilih Tipe Kendaraan --", tipe_kendaraan,
                    toogleTipe, "tipe"),
                SizedBox(
                  height: 5,
                ),
                FormField("-- Pilih Kendaraan --", merek_kendaraan, toogleMerek,
                    "merek"),
                SizedBox(
                  height: 5,
                ),
                FormField("-- Pilih Jenis Bahan Bakar --", listBensin,
                    toogleBBM, "bbm"),
                SizedBox(
                  height: 5,
                ),
                FormField("-- Pilih Periode --", null, tooglePriode, "periode"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget FormField(
    txtTitle,
    data,
    toogle,
    toogleParam,
  ) {
    return Container(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFBFE5DF),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    txtTitle,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      color: Color(0xFF677D81),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      toogleParam == "tipe"
                          ? toogleTipe = !toogleTipe
                          : toogleParam == "merek"
                              ? toogleMerek = !toogleMerek
                              : toogleParam == "bbm"
                                  ? toogleBBM = !toogleBBM
                                  : toogleParam == "peride"
                                      ? tooglePriode = !tooglePriode
                                      : null;
                    });
                    // print(toogleTipe);
                  },
                  child: Container(
                    child: Icon(
                      Icons.arrow_circle_down,
                      color: Color(0xFFAEAEAE),
                    ),
                  ),
                )
              ],
            ),
          ),
          AnimatedContainer(
            duration: Duration(seconds: 1),
            width: double.infinity,
            height: toogleParam == "tipe"
                ? toogleTipe == true
                    ? (36 * data.length).toDouble()
                    : 0
                : toogleParam == "merek"
                    ? toogleMerek == true
                        ? (36 * data.length).toDouble()
                        : 0
                    : toogleParam == "bbm"
                        ? toogleBBM == true
                            ? (26 * data.length).toDouble()
                            : 0
                        : toogleParam == "periode"
                            ? tooglePriode == true
                                ? 30
                                : 0
                            : 0,
            curve: Curves.fastOutSlowIn,
            child: toogleParam != "periode"
                ? listBuilderWidget(data, toogleParam)
                : formPeriode(),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget formPeriode() {
    return Container(
      height: 20,
      width: 20,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 22),
                margin: EdgeInsets.symmetric(vertical: 2),
                decoration: BoxDecoration(
                  color: Color(0xFFBFE5DF),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_month_outlined),
                    Text(
                      "Awal",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        color: Color(0xFF677D81),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                width: double.infinity,
                height: 10,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 22),
                margin: EdgeInsets.symmetric(vertical: 2),
                decoration: BoxDecoration(
                  color: Color(0xFFBFE5DF),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget listBuilderWidget(data, toogleParam) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: data.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return toogleParam != "bbm"
            ? itemDropDown(data.elementAt(index))
            : itemDropDown(listBensin[index].text);
      },
    );
  }

  Widget itemDropDown(key) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 22),
      margin: EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: Color(0xFFBFE5DF),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Text(
        key,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 10,
          color: Color(0xFF677D81),
        ),
      ),
    );
  }
}
