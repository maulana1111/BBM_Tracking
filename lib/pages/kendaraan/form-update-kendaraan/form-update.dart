import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:bbm_tracking/bloc/bbm_bloc.dart';
import 'package:bbm_tracking/model/kendaraan_m.dart';
import 'package:bbm_tracking/pages/component/success_dialog_box.dart';
import 'package:bbm_tracking/pages/home.dart';
import 'package:bbm_tracking/pages/mainMenu/index.dart';
import 'package:bbm_tracking/resource/resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FormUpdateKendaraan extends StatefulWidget {
  KendaraanModel kendaraan;
  FormUpdateKendaraan({super.key, required this.kendaraan});

  @override
  State<FormUpdateKendaraan> createState() => _FormUpdateKendaraanState();
}

class _FormUpdateKendaraanState extends State<FormUpdateKendaraan> {
  late KendaraanModel kendaraan;
  late String selectedValueBensin;
  late KendaraanModel kendaraanModel;

  bool _submitted = false;

  final tipeKendaraanController = TextEditingController();
  final dateController = TextEditingController();
  final kilometerController = TextEditingController();
  final jenisBBMController = TextEditingController();
  final kepemilikanController = TextEditingController();
  final nomorPlatController = TextEditingController();
  final ccController = TextEditingController();

  @override
  void initState() {
    super.initState();
    kendaraan = widget.kendaraan;
    tipeKendaraanController.text = kendaraan.namaKendaraan;
    kilometerController.text = kendaraan.odometer;
    jenisBBMController.text = kendaraan.bahanBakar;
    kepemilikanController.text = kendaraan.kepemilikan;
    nomorPlatController.text = kendaraan.nomorPlat;
    ccController.text = kendaraan.cc.toString();
    print(kendaraan.jenisKendaraan);

  }

  void _submit() {
    setState(() {
      _submitted = true;
    });
    if (tipeKendaraanController.value.text != "" &&
        dateController.value.text != "" &&
        kilometerController.value.text != "" &&
        jenisBBMController.value.text != "" &&
        kepemilikanController.value.text != "" &&
        nomorPlatController.value.text != "" &&
        ccController.value.text != "") {
      kendaraanModel = KendaraanModel(
        id: kendaraan.id,
        jenisKendaraan: kendaraan.jenisKendaraan,
        namaKendaraan: tipeKendaraanController.value.text,
        nomorPlat: nomorPlatController.value.text,
        bahanBakar: jenisBBMController.value.text,
        cc: int.parse(ccController.value.text),
        odometer: kilometerController.value.text,
        kepemilikan: kepemilikanController.value.text,
        status: kendaraan.status,
      );
      context.read<BbmBloc>().add(BBMDataKendaraanUpdated(kendaraanModel));
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Home("", ""),
      ));
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SuccessDialogBox(deskripsi: "Berhasil Mengubah Data");
        },
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tipeKendaraanController.dispose();
    dateController.dispose();
    kilometerController.dispose();
    jenisBBMController.dispose();
    kepemilikanController.dispose();
    nomorPlatController.dispose();
    ccController.dispose();
  }

  List<String> listNamaBensin = List.from(listBensin.map((e) => e.text));
  List<String> listKepemilikan = [
    'Pribadi',
    'Perusahaan',
    'Sewa',
    'Lainnya',
  ];
  // listBensin.map

  Future<bool> _onWillPop() async {
    Navigator.pop(context);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        backgroundColor: Color(0xffE3EAEA),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    height: 55,
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "Data Pribadi Kendaraan Anda",
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
                  Card(),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        inputField(
                          "Tipe Kendaraan",
                          "Type Of Brand",
                          "text",
                          tipeKendaraanController,
                        ),
                        dropdownField(
                          "Jenis Bahan Bakar",
                          listNamaBensin,
                          jenisBBMController,
                        ),
                        dropdownField(
                          "Kepemilikan",
                          listKepemilikan,
                          kepemilikanController,
                        ),
                        inputField(
                          "Data Penerimaan Kendaraan",
                          "MM/DD/YYYY",
                          "date",
                          dateController,
                        ),
                        inputField(
                          "Kilometers Kendaraan",
                          "0 Km",
                          "number",
                          kilometerController,
                        ),
                        inputField(
                          "CC Kendaraan",
                          "CC",
                          "number",
                          ccController,
                        ),
                        inputField(
                          "Nomor Plat Kendaraan",
                          "Contoh : XX XXXX XXX",
                          "text",
                          nomorPlatController,
                        ),
                        SaveButton(),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _errorText(TextEditingController controller) {
    var val = controller.value.text.isEmpty ? "Tidak Boleh Kosong" : null;
    return val;
  }

  Widget Card() {
    return Container(
      height: 75,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        color: Color(0xFFDDB05E),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          Image.asset(
            kendaraan.jenisKendaraan == "motor"
                ? "assets/images/motor.png"
                : "assets/images/car.png",
            width: 50,
            height: 50,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            kendaraan.jenisKendaraan == "motor" ? "Motor" : "Mobil",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              color: Color(0xFF1A0F0F),
            ),
          )
        ],
      ),
    );
  }

  Widget SaveButton() {
    return InkWell(
      onTap: _submit,
      child: Container(
        width: 90,
        height: 35,
        margin: EdgeInsets.only(
          top: 10,
        ),
        padding: EdgeInsets.only(
          top: 7,
        ),
        decoration: BoxDecoration(
          color: Color(0xFF2ECC71),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Text(
          "Save Data",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 15,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget dropdownField(title, data, TextEditingController controller) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF1A0F0F),
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          title != "Kepemilikan"
              ? CustomDropdown.search(
                  fillColor: Color(0xffE3EAEA),
                  borderSide: BorderSide(
                    color: Color(0xFF677D81),
                  ),
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                  errorText: _submitted ? _errorText(controller) : null,
                  items: data,
                  controller: controller,
                )
              : CustomDropdown(
                  fillColor: Color(0xffE3EAEA),
                  borderSide: BorderSide(
                    color: Color(0xFF677D81),
                  ),
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                  items: data,
                  controller: controller,
                ),
        ],
      ),
    );
  }

  Widget inputField(title, hint, typeField, TextEditingController controller) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF1A0F0F),
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextField(
            textCapitalization: title == "Nomor Plat Kendaraan"
                ? TextCapitalization.characters
                : title == "Kendaraan"
                    ? TextCapitalization.characters
                    : TextCapitalization.none,
            maxLength: title == "Nomor Plat Kendaraan" ? 11 : 100,
            controller: controller,
            readOnly: typeField == "date" && true,
            keyboardType: typeField != "date" && typeField != "text"
                ? TextInputType.number
                : TextInputType.text,
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
              hintText: hint,
              hintStyle: TextStyle(
                fontFamily: 'Poppins',
                color: Color(0xFFAEAEAE),
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
              errorText: _submitted ? _errorText(controller) : null,
            ),
            onTap: () async {
              if (typeField == "date") {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2024),
                );
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);

                  setState(
                    () {
                      controller.text =
                          formattedDate; //set foratted date to TextField value.
                    },
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
