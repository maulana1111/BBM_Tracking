import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:bbm_tracking/pages/home.dart';
import 'package:bbm_tracking/resource/resource.dart';
import 'package:flutter/material.dart';

class FormTamabahDataBensin extends StatefulWidget {
  const FormTamabahDataBensin({super.key});

  @override
  State<FormTamabahDataBensin> createState() => _FormTamabahDataBensinState();
}

class _FormTamabahDataBensinState extends State<FormTamabahDataBensin> {
  String kendaraan = "mobil";

  final test = TextEditingController();
  List<String> listNamaBensin = List.from(listBensin.map((e) => e.text));
  RangeLabels labels = RangeLabels('1', "10");
  RangeValues _rangeValues = RangeValues(1, 10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE3EAEA),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: 50,
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                BackButton(),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "Pengisian Bahan Bakar",
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
                  height: 15,
                ),
                Container(
                  height: 75,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    color: Color(0xFFFC8D05),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Image.asset(
                        kendaraan == "motor"
                            ? "assets/images/motor.png"
                            : "assets/images/car.png",
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Tipe Kendaraan : ",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11,
                              color: Color(0xFF3B3C48),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Toyota Vitz / B 1000 JAJ",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    "Edit Informasi",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF1C7A44),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "Masukan Data Pengisian Bahan Bakar",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0xff1A0F0F),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                formPengisian(),
                SizedBox(
                  height: 10,
                ),
                formLokasiSPBU(),
                SizedBox(
                  height: 10,
                ),
                formGambar(),
                SizedBox(
                  height: 10,
                ),
                formCatatan(),
                SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 80,
                    height: 35,
                    // alignment: Alignment.topRight,
                    padding: EdgeInsets.only(top: 7, left: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      color: Color(0xFF2ECC71),
                    ),
                    child: Text(
                      "Tambahkan",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget BackButton() {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pop(MaterialPageRoute(builder: (context) => Home("home", ""))),
      child: Container(
        child: Container(
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
    );
  }

  Widget formCatatan() {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 10,
              top: 3,
            ),
            width: double.infinity,
            height: 25,
            decoration: BoxDecoration(
              color: Color(0xFF677D81),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Text(
              "Optional",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 11,
                color: Color(0xffFFFFFF),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Row(
              children: [
                Container(
                  child: Image.asset(
                    "assets/images/edit.png",
                    width: 34,
                    height: 34,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    child: TextField(
                      controller: test,
                      maxLines: 7,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                          borderSide: BorderSide(
                            color: Color(0xFF677D81),
                          ),
                        ),
                        // border: BoxDecoration(border:),
                        contentPadding: EdgeInsets.only(
                          top: 4,
                          bottom: 4,
                          left: 15,
                          right: 15,
                        ),
                        hintText: "hint",
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xFFAEAEAE),
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget formGambar() {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 10,
              top: 3,
            ),
            width: double.infinity,
            height: 25,
            decoration: BoxDecoration(
              color: Color(0xFF677D81),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Text(
              "Gambar",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 11,
                color: Color(0xffFFFFFF),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                child: Image.asset(
                  "assets/images/frmImage.png",
                  width: 34,
                  height: 34,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                child: Image.asset(
                  "assets/images/frmAdd.png",
                  width: 34,
                  height: 34,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                child: Image.asset(
                  "assets/images/frmAdd.png",
                  width: 34,
                  height: 34,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget formLokasiSPBU() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: 10,
            top: 3,
          ),
          width: double.infinity,
          height: 25,
          decoration: BoxDecoration(
            color: Color(0xFF677D81),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Text(
            "Lokasi SPBU",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 11,
              color: Color(0xffFFFFFF),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFFC8D05)),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Text(
            "Lokasi SPBU dapat Anda temukan melalui google map",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 9,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFAEAEAE)),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 10,
              ),
              child: Image.asset(
                "assets/images/titikpoint.png",
                width: 24,
                height: 24,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                child: TextField(
                  controller: test,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      borderSide: BorderSide(
                        color: Color(0xFF677D81),
                      ),
                    ),
                    // border: BoxDecoration(border:),
                    contentPadding: EdgeInsets.only(
                      top: 4,
                      bottom: 4,
                      left: 15,
                      right: 15,
                    ),
                    hintText: "hint",
                    hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xFFAEAEAE),
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget formPengisian() {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 10,
              top: 3,
            ),
            width: double.infinity,
            height: 25,
            decoration: BoxDecoration(
              color: Color(0xFF677D81),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Text(
              "Pengisian",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 11,
                color: Color(0xffFFFFFF),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          formPengisianKendaraan(),
          formTanggalPengisian(),
          SizedBox(
            height: 10,
          ),
          formJumlahBensin()
        ],
      ),
    );
  }

  Widget formPengisianKendaraan() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 10,
          ),
          child: Image.asset(
            "assets/images/radar.png",
            width: 24,
            height: 24,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            // decoration: BoxDecoration(color: Colors.greenAccent),
            child: Column(
              children: [
                TextField(
                  controller: test,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      borderSide: BorderSide(
                        color: Color(0xFF677D81),
                      ),
                    ),
                    // border: BoxDecoration(border:),
                    contentPadding: EdgeInsets.only(
                      top: 4,
                      bottom: 4,
                      left: 15,
                      right: 15,
                    ),
                    hintText: "hint",
                    hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xFFAEAEAE),
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    "Sebelumnya : 2080 km",
                    style: TextStyle(
                      color: Color(0xFF1A0F0F),
                      fontFamily: 'Poppins',
                      fontSize: 5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomDropdown.search(
                  fillColor: Color(0xffE3EAEA),
                  borderSide: BorderSide(
                    color: Color(0xFF677D81),
                  ),
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                  // errorText: _submitted
                  //     ? _errorText(controller)
                  //     : null,
                  items: listNamaBensin,
                  controller: test,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Kondisi Bensin Saat ini",
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      color: Color(0xff1A0F0F),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: RangeSlider(
                    divisions: 10,
                    activeColor: Color(0xFFFC8D05),
                    inactiveColor: Color(0xFFDDB05E),
                    min: 1,
                    max: 10,
                    labels: RangeLabels(
                      _rangeValues.start.round().toString(),
                      _rangeValues.end.round().toString(),
                    ),
                    values: _rangeValues,
                    onChanged: (RangeValues val) {
                      if (val.start == 1) {
                        setState(() {
                          _rangeValues = val;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget formTanggalPengisian() {
    return Row(
      children: [
        Container(
          child: Image.asset(
            "assets/images/calendaradd.png",
            width: 24,
            height: 24,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            child: Row(
              children: [
                Flexible(
                  flex: 5,
                  child: Container(
                    child: TextField(
                      controller: test,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                          borderSide: BorderSide(
                            color: Color(0xFF677D81),
                          ),
                        ),
                        // border: BoxDecoration(border:),
                        contentPadding: EdgeInsets.only(
                          top: 4,
                          bottom: 4,
                          left: 15,
                          right: 15,
                        ),
                        hintText: "hint",
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xFFAEAEAE),
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 5,
                      right: 5,
                    ),
                    child: Image.asset(
                      "assets/images/timer.png",
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: Container(
                    child: TextField(
                      controller: test,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                          borderSide: BorderSide(
                            color: Color(0xFF677D81),
                          ),
                        ),
                        // border: BoxDecoration(border:),
                        contentPadding: EdgeInsets.only(
                          top: 4,
                          bottom: 4,
                          left: 15,
                          right: 15,
                        ),
                        hintText: "hint",
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xFFAEAEAE),
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget formJumlahBensin() {
    return Row(
      children: [
        Container(
          child: Image.asset(
            "assets/images/dollarsquare.png",
            width: 24,
            height: 24,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          child: Expanded(
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: TextField(
                    controller: test,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                        borderSide: BorderSide(
                          color: Color(0xFF677D81),
                        ),
                      ),
                      // border: BoxDecoration(border:),
                      contentPadding: EdgeInsets.only(
                        top: 4,
                        bottom: 4,
                        left: 15,
                        right: 15,
                      ),
                      hintText: "hint",
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xFFAEAEAE),
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  flex: 2,
                  child: TextField(
                    controller: test,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                        borderSide: BorderSide(
                          color: Color(0xFF677D81),
                        ),
                      ),
                      // border: BoxDecoration(border:),
                      contentPadding: EdgeInsets.only(
                        top: 4,
                        bottom: 4,
                        left: 15,
                        right: 15,
                      ),
                      hintText: "hint",
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xFFAEAEAE),
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  flex: 3,
                  child: TextField(
                    controller: test,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                        borderSide: BorderSide(
                          color: Color(0xFF677D81),
                        ),
                      ),
                      // border: BoxDecoration(border:),
                      contentPadding: EdgeInsets.only(
                        top: 4,
                        bottom: 4,
                        left: 15,
                        right: 15,
                      ),
                      hintText: "hint",
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xFFAEAEAE),
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
