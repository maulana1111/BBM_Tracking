import 'package:bbm_tracking/resource/resource.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormKendaraan extends StatefulWidget {
  String kendaraan;
  FormKendaraan({super.key, required this.kendaraan});

  @override
  State<FormKendaraan> createState() => _FormKendaraanState();
}

class _FormKendaraanState extends State<FormKendaraan> {
  late String kendaraan;
  late String selectedValueBensin;

  bool _submitted = false;

  final tipeKendaraanController = TextEditingController();
  final dateController = TextEditingController();
  final kilometerController = TextEditingController();
  // final jenisKendaraanController = TextEditingController();
  // final kepemilikanController = TextEditingController();
  final nomorPlatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    kendaraan = widget.kendaraan;
  }

  void _submit() {
    setState(() {
      _submitted = true;
    });
    if (tipeKendaraanController.value.text != "" &&
        dateController.value.text != "" &&
        kilometerController.value.text != "" &&
        // tipeKendaraanController.value.text != "" &&
        // tipeKendaraanController.value.text != "" &&
        nomorPlatController.value.text != "") {
      print("success");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tipeKendaraanController.dispose();
    dateController.dispose();
    kilometerController.dispose();
    // jenisKendaraanController.dispose();
    // kepemilikanController.dispose();
    nomorPlatController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE3EAEA),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
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
                Container(
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
                        kendaraan == "motor"
                            ? "assets/images/motor.png"
                            : "assets/images/car.png",
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        kendaraan == "motor" ? "Motor" : "Mobil",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Color(0xFF1A0F0F),
                        ),
                      )
                    ],
                  ),
                ),
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
                      inputField(
                        "Data Penerimaan Kendaraan",
                        "MM/DD/YYYY",
                        "date",
                        dateController,
                      ),
                      inputField(
                        "Kilometers",
                        "0 Km/Jam",
                        "number",
                        kilometerController,
                      ),
                      inputField(
                        "Nomor Plat Kendaraan",
                        "X XXXX XXX",
                        "text",
                        nomorPlatController,
                      ),
                      InkWell(
                        onTap: _submit,
                        child: Container(
                          width: 90,
                          height: 35,
                          margin: EdgeInsets.only(
                            top: 10,
                          ),
                          padding: EdgeInsets.only(
                            top: 5,
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
                      )
                    ],
                  ),
                ),
              ],
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

  Widget dropdownField(title) {
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
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              hint: Row(
                children: const [
                  Icon(
                    Icons.list,
                    size: 16,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Text(
                      'Select Item',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              items: listBensin
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item.value,
                      child: Text(
                        item.text,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                  .toList(),
              value: selectedValueBensin,
              onChanged: (value) {
                setState(() {
                  selectedValueBensin = value as String;
                });
              },
              icon: const Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              iconSize: 14,
              iconEnabledColor: Colors.yellow,
              iconDisabledColor: Colors.grey,
              buttonHeight: 50,
              buttonWidth: 160,
              buttonPadding: const EdgeInsets.only(left: 14, right: 14),
              buttonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.black26,
                ),
                color: Colors.redAccent,
              ),
              buttonElevation: 2,
              itemHeight: 40,
              itemPadding: const EdgeInsets.only(left: 14, right: 14),
              dropdownMaxHeight: 200,
              dropdownWidth: 200,
              dropdownPadding: null,
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.redAccent,
              ),
              dropdownElevation: 8,
              scrollbarRadius: const Radius.circular(40),
              scrollbarThickness: 6,
              scrollbarAlwaysShow: true,
              offset: const Offset(-20, 0),
            ),
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
          TextFormField(
            controller: controller,
            readOnly: typeField == "date" && true,
            keyboardType: typeField != "date" && typeField != "text"
                ? TextInputType.number
                : TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: hint,
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
