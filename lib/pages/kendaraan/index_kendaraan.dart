import 'dart:ffi';

import 'package:bbm_tracking/bloc/bbm_bloc.dart';
import 'package:bbm_tracking/model/Kendaraan_model.dart';
import 'package:bbm_tracking/model/kendaraan_m.dart';
import 'package:bbm_tracking/pages/Performa/index.dart';
import 'package:bbm_tracking/pages/home.dart';
import 'package:bbm_tracking/pages/kendaraan/component/card-kendaraan.dart';
import 'package:bbm_tracking/pages/kendaraan/form-tambah-kendaraan/form.dart';
import 'package:bbm_tracking/pages/kendaraan/form-update-kendaraan/form-update.dart';
import 'package:bbm_tracking/repository/kendaraan/kendaraan_repository.dart';
import 'package:bbm_tracking/resource/popup/popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IndexKendaraan extends StatefulWidget {
  const IndexKendaraan({super.key});

  @override
  State<IndexKendaraan> createState() => _IndexKendaraanState();
}

class _IndexKendaraanState extends State<IndexKendaraan> {
  List<KendaraanModel> dataKendaraan = [];
  int counter = 0;

  void changeStatuKendaraan(int id, int status) {
    context.read<BbmBloc>().add(BBMChangeStatusKendaraan(id, status));
    dataKendaraan.forEach((element) {
      element.status = 0;
    });
    dataKendaraan
        .elementAt(dataKendaraan.indexWhere((element) => element.id == id))
        .status = status;
    setState(() {
      counter++;
    });
  }

  void deleteDataKendaraan(int id) async {
    await KendaraanRepository().deleteDataKendaraan(id);
    dataKendaraan.removeWhere((element) => element.id == id);
    setState(() {
      counter++;
    });
  }

  void updateKendaraan(KendaraanModel data) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FormUpdateKendaraan(
          kendaraan: data,
          key: UniqueKey(),
        ),
      ),
    );
  }

  void checkKendaraan(List<KendaraanModel> data) {
    bool cond = false;
    for (var i = 0; i < data.length; i++) {
      if (data[i].status == 1) {
        cond = true;
      }
    }
    if (cond == true) {
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => Performa()));
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return PopUp(
            text: "Masih dalam Tahap Pengembangan",
            param: "negative",
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return PopUp(
            text: data.isEmpty
                ? "Maaf, belum ada kendaraan yang Anda tambahkan"
                : "Silahkan Aktifkan Salah Satu Kendaraan Anda",
            param: "negative",
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE3EAEA),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return showDialogKendaraan();
            },
          );
        },
        backgroundColor: Color(0xFF677D81),
        child: Icon(
          Icons.add,
        ),
      ),
      body: Container(
        child: BlocBuilder<BbmBloc, BbmState>(
          builder: (context, state) {
            if (state is BbmInitial) {
              return Container(
                child: Center(child: CircularProgressIndicator()),
              );
            }
            if (state is BBMError) {
              return Container(
                child: Center(child: Text(state.message.toString())),
              );
            }
            if (state is BBMLoaded) {
              dataKendaraan = state.kendaraan;
              return SingleChildScrollView(
                child: Container(
                  child: Stack(
                    children: [
                      Container(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(),
                                  Container(
                                    child: InkWell(
                                      onTap: () =>
                                          checkKendaraan(state.kendaraan),
                                      child: Text(
                                        "Performa Kendaraan",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Poppins',
                                          color: Color(0xff25A35A),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: dataKendaraan.length,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return CardKendaraan(
                                      kendaraan: dataKendaraan.elementAt(index),
                                      onChangeStatus: (int id, int status) {
                                        changeStatuKendaraan(id, status);
                                      },
                                      onDelete: (int id) {
                                        deleteDataKendaraan(id);
                                      },
                                      onUpdate: (KendaraanModel kendaraan) {
                                        updateKendaraan(kendaraan);
                                      },
                                      key: UniqueKey(),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  // Widget ListDataKendaraan() {
  //   return Container(
  //     child: ListView.builder(
  //       scrollDirection: Axis.vertical,
  //       itemCount: _dataKendaraan.length,
  //       shrinkWrap: true,
  //       itemBuilder: (BuildContext context, int index) {
  //         return CardKendaraan(
  //           kendaraan: _dataKendaraan[index],
  //           onChangeStatus: (int id, bool status) {
  //             changeStatuKendaraan(id, status);
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget backButton() {
    return Container(
      child: InkWell(
        onTap: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Home("home", ""),
          ),
        ),
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
            ),
          ],
        ),
      ),
    );
  }

  Dialog showNotif(txt) {
    return Dialog(
      elevation: 1,
      backgroundColor: Color(0xffE3EAEA),
      child: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/sad_person.png",
              width: 70,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              txt,
              style: TextStyle(
                color: Color(0xFF677D81),
                fontSize: 13,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Dialog showDialogKendaraan() {
    return Dialog(
      elevation: 1,
      backgroundColor: Color(0xffE3EAEA),
      child: Container(
        height: 230,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Pilih Kendaraan",
              style: TextStyle(
                color: Color(0xFF677D81),
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FormKendaraan(kendaraan: "motor"),
                  ),
                );
              },
              child: chooseKendaraan(
                "assets/images/motor.png",
                "Motor",
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Divider(
              color: Color(0xFFECDEDE),
              height: 2,
              thickness: 2,
            ),
            SizedBox(
              height: 7,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FormKendaraan(kendaraan: "mobil"),
                  ),
                );
              },
              child: chooseKendaraan("assets/images/car.png", "Mobil"),
            ),
          ],
        ),
      ),
    );
  }

  Container chooseKendaraan(image, text) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: Row(
        children: [
          Image.asset(
            image,
            width: 50,
            height: 50,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            text,
            style: TextStyle(
              color: Color(0xFF677D81),
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
