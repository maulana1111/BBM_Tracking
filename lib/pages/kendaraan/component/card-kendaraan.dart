import 'package:bbm_tracking/model/Kendaraan_model.dart';
import 'package:bbm_tracking/model/kendaraan_m.dart';
import 'package:bbm_tracking/pages/component/custom_dialog_box.dart';
import 'package:bbm_tracking/repository/kendaraan/kendaraan_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CardKendaraan extends StatefulWidget {
  final KendaraanModel kendaraan;
  final Function onChangeStatus;
  final Function onDelete;
  final Function onUpdate;
  CardKendaraan(
      {required this.kendaraan, required this.onChangeStatus, required this.onDelete, required this.onUpdate, Key? key})
      : super(key: key);

  @override
  State<CardKendaraan> createState() => _CardKendaraanState();
}

class _CardKendaraanState extends State<CardKendaraan> {
  late KendaraanModel kendaraan;
  late Function onChangeStatus;
  late Function onDelete;
  late Function onUpdate;
  @override
  void initState() {
    super.initState();
    kendaraan = widget.kendaraan;
    onChangeStatus = widget.onChangeStatus;
    onDelete = widget.onDelete;
    onUpdate = widget.onUpdate;
  }

  int count = 0;
  changeStatus(id, status) {
    onChangeStatus(id, status);
  }

  TextStyle styleText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: Color(0xFF3B3C48),
  );

  TextStyle cardTitle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: Color(0xFF3B3C48),
  );

  TextStyle cardData = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xFFFFFFFF),
  );

  void deleteData() async {
    onDelete(kendaraan.id);
  }

  void updateData() async {
    onUpdate(kendaraan);
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: const ValueKey(0),

      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const DrawerMotion(),

        // A pane can dismiss the Slidable.
        // dismissible: DismissiblePane(onDismissed: () {}),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            onPressed: (context) => deleteData(),
          ),
          SlidableAction(
            onPressed: (context) => updateData(),
            backgroundColor: Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.share,
            label: 'Update',
          ),
        ],
      ),

      child: Container(
        width: double.infinity,
        height: 145,
        margin: EdgeInsets.only(
          top: 8,
          bottom: 8,
        ),
        decoration: BoxDecoration(
          color: kendaraan.status == 1 ? Color(0xFFFC8D05) : Color(0xFFDDB05E),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      kendaraan.status == 1
                          ? "Kendaraan Anda Saat ini"
                          : "Kendaraan Lainnya",
                      style: styleText,
                    ),
                  ),
                  Container(
                    // padding: EdgeInsets.all(10),
                    child: Switch(
                      activeColor: Color(0xFFDDB05E),
                      activeTrackColor: Colors.white,
                      inactiveThumbColor: Color(0xFFE3EAEA),
                      inactiveTrackColor: Colors.white,
                      splashRadius: 50,
                      value: kendaraan.status == 0 ? false : true,
                      onChanged: (value) {
                        kendaraan.status == 0
                            ? showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomeDialogBox(
                                    title: 'Aktifkan Kendaraan?',
                                    description:
                                        'Anda dapat melihat semua detail data kendaraan ketika status kendaraan sudah aktif kembali',
                                    positiveText: "Ya, Aktifkan",
                                    negativeText: "Batalkan",
                                    screen: "cardKendaraan",
                                    onChangeStatus: () => {
                                      changeStatus(kendaraan.id, 1),
                                    },
                                  );
                                },
                              )
                            : changeStatus(kendaraan.id, 0);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tipe Kendaraan : ",
                                  style: cardTitle,
                                ),
                                Text(
                                  "${kendaraan.namaKendaraan}",
                                  style: cardData,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Nomor Plat : ",
                                  style: cardTitle,
                                ),
                                Text(
                                  "${kendaraan.nomorPlat}",
                                  style: cardData,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Bahan Bakar saat ini ",
                              style: cardTitle,
                            ),
                            Text(
                              "${kendaraan.bahanBakar}",
                              style: cardData,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Image.asset(
                      kendaraan.jenisKendaraan == "mobil"
                          ? "assets/images/car.png"
                          : "assets/images/motor.png",
                      width: 80,
                      height: 80,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Dialog showDialogError() {
    return Dialog(
      elevation: 1,
      backgroundColor: Colors.white,
      child: Container(
        height: 230,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/error_kendaraan.png"),
            SizedBox(
              height: 25,
            ),
            Text(
              "Maaf, Anda menonaktifkan kendaraan ini",
              style: TextStyle(
                color: Color(0xFF677D81),
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
