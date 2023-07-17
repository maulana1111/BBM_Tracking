import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:bbm_tracking/bloc/bbm_bloc.dart';
import 'package:bbm_tracking/model/bensin_m.dart';
import 'package:bbm_tracking/model/kendaraan_m.dart';
import 'package:bbm_tracking/model/photo_m.dart';
import 'package:bbm_tracking/model/transaksi_m.dart';
import 'package:bbm_tracking/pages/component/success_dialog_box.dart';
import 'package:bbm_tracking/pages/form-tambah-data-bensin/displayImage.dart';
import 'package:bbm_tracking/pages/home.dart';
import 'package:bbm_tracking/resource/popup/popup.dart';
import 'package:bbm_tracking/resource/resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:developer' as developer;
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uri_to_file/uri_to_file.dart';

class FormTamabahDataBensin extends StatefulWidget {
  KendaraanModel kendaraanModel;
  // TransaksiModel transaksiModel;
  final CameraDescription camera;

  FormTamabahDataBensin(
      {required this.kendaraanModel, required this.camera, Key? key})
      : super(key: key);
  // FormTamabahDataBensin(this.transaksiModel, {required this.kendaraanModel, required this.camera});

  @override
  State<FormTamabahDataBensin> createState() => _FormTamabahDataBensinState();
}

class _FormTamabahDataBensinState extends State<FormTamabahDataBensin>
    with RestorationMixin {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  late KendaraanModel dataKendaraan;
  var formatDate = DateFormat("yyyy-MM-dd");
  DateTime dateNow = DateTime.now();
  late String selectedDate = formatDate.format(dateNow).toString();
  late TimeOfDay _time = TimeOfDay(hour: dateNow.hour, minute: dateNow.minute);
  late bool conditionBbm = false;

  late String literTxt = '';
  late String hargaPerLiterTxt = '';
  late String totalBiayaTxt = '';

  final String wifiOff =
      "Maps tidak dapat dibuka, Anda saat ini sedang di luar jaringan. Silakan periksa jaringan internet Anda";
  final String gpsOff = "Maps tidak dapat dibuka, GPS tidak aktif";

  final odometerController = TextEditingController();
  final bbmController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final literController = TextEditingController();
  final totalBiayaController = TextEditingController();
  final alamatController = TextEditingController();
  final catatanController = TextEditingController();
  final hargaPerLiterController = TextEditingController();
  final lokasiController = TextEditingController();

  GoogleMapController? _controllerMap;
  Location currentLocation = Location();
  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);

  late bool _gpsEnable;
  late bool _internetEnable = false;

  Set<Marker> _markers = {};

  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;

  List<File?> _image = [];
  File? tryImage;

  bool _submittedForm = false;

  BensinModel? dtBensin;

  String latitude = "0";
  String langitude = "0";

  List<PhotoModel> dataPhoto = <PhotoModel>[];

  bool _isButtonDisabled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      timeController.text = _time.format(context).toString();
      dateController.text = selectedDate;
    });

    initConnectivity();
    // checkGPS();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    dataKendaraan = widget.kendaraanModel;

    bbmController.addListener(() {
      if (bbmController.text == "") {
        conditionBbm == true;
      } else {
        conditionBbm = false;
        dtBensin = listBensin
            .firstWhere((element) => element.text == bbmController.text);
        hargaPerLiterController.text =
            CurrencyFormat.convertToIdr(dtBensin!.harga, 0);
        hargaPerLiterTxt = dtBensin!.harga.toString();
      }
    });

    totalBiayaController.addListener(() {
      var txt = _replaceFormat(totalBiayaController.text);
      totalBiayaTxt = txt;
      _counter();
    });

    hargaPerLiterController.addListener(() {
      var txt = _replaceFormat(hargaPerLiterController.text);
      hargaPerLiterTxt = txt;
      _counter();
    });

    setState(() {
      initialLocation();
      // getLocation();
    });

    _cameraController = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _controllerMap!.dispose();
    _connectivitySubscription.cancel();
    _cameraController.dispose();
    odometerController.dispose();
    bbmController.dispose();
    dateController.dispose();
    timeController.dispose();
    literController.dispose();
    totalBiayaController.dispose();
    alamatController.dispose();
    catatanController.dispose();
    hargaPerLiterController.dispose();
    lokasiController.dispose();
  }

  void initialLocation() async {
    Position position = await checkGPS();

    _controllerMap?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            position.latitude,
            position.longitude,
          ),
          zoom: 16,
        ),
      ),
    );
    _markers.clear();
    latitude = position.latitude.toString();
    langitude = position.longitude.toString();

    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: LatLng(position.latitude, position.longitude),
        ),
      );
    });
  }

  Future<Position> checkGPS() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    } else {
      _gpsEnable = true;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      if (result != ConnectivityResult.none) {
        _internetEnable = true;
      }
      _connectionStatus = result;
    });
  }

  List<String> listNamaBensin = List.from(listBensin.map((e) => e.text));
  RangeLabels labels = RangeLabels('1', "10");
  RangeValues _rangeValues = RangeValues(1, 10);

  @override
  String? get restorationId => 'main';

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        dateController.text = DateFormat("yyyy-MM-dd").format(newSelectedDate).toString(); 
        selectedDate = DateFormat("yyyy-MM-dd").format(newSelectedDate).toString();
      });
    }
  }

  void _selectTime() async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        timeController.text = _time.format(context).toString();
      });
    }
  }

  String _replaceFormat(String data) {
    var txt = data.replaceAll("Rp. ", '');
    txt = txt.replaceAll(".", '');
    return txt;
  }

  void _counter() {
    if (bbmController.text == "") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return PopUp(
            text: "Maaf, Silakan pilih jenis BBM terlebih dahulu",
            param: "negative",
          );
        },
      );
    } else {
      double res = 0;
      hargaPerLiterTxt != '' && totalBiayaTxt != ''
          ? res = int.parse(totalBiayaTxt) / int.parse(hargaPerLiterTxt)
          : res = 0;

      // BensinModel dtBensin = listBensin
      //     .firstWhere((element) => element.text == bbmController.text);
      if (res == 0) {
        literController.text = '';
        literTxt = '';
      } else {
        literController.text = res.toStringAsFixed(2).toString();
        literTxt = res.toStringAsFixed(2).toString();
      }
    }
  }

  void _checkBBMselected() {
    conditionBbm == true
        ? showDialog(
            context: context,
            builder: (BuildContext context) {
              return PopUp(
                text: "Maaf, Silakan pilih jenis BBM terlebih dahulu",
                param: "negative",
              );
            },
          )
        : null;
  }

  String _setFormat(data) {
    return CurrencyFormat.convertToIdr(data, 0);
  }

  Future<void> _navigateAndDisplayImage(
    BuildContext context,
    File file,
  ) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DisplayImage(imagePath: file),
      ),
    );
    if (!mounted) return;

    if (result != null) {
      setState(() {
        _image.remove(result);
      });
      print(_image);
    }
  }

  void _submitted() async {
    setState(() {
      _isButtonDisabled = true;
    });
    var rng = Random();
    String _kodeTransaksi =
        "BBM-T/F0001/${bbmController.text}/XIII/${rng.nextInt(999999)}";

    final dateNow = DateTime.now().toString();
    print("printing");
    await insertedImageToGallery(dateNow, _kodeTransaksi);

    Future.delayed(Duration(seconds: 2), () {
      insertedTransaksi(_kodeTransaksi);
    });
  }

  Future<void> insertedTransaksi(String _kodeTransaksi) async {
    String strsub;
    if (timeController.text.toString()[4] == " ") {
      strsub = timeController.text.substring(0, 4) + ":00";
    } else {
      strsub = timeController.text.substring(0, 5) + ":00";
    }

    TransaksiModel transaksiModel = TransaksiModel(
      id: 0,
      kendaraanId: dataKendaraan.id.toString(),
      bensinId: dtBensin!.id.toString(),
      kodeTransaksi: _kodeTransaksi,
      tanggalTransaksi: DateFormat("yyyy-MM-dd").parse(dateController.text),
      waktuTransaksi: DateFormat("HH:mm:ss").parse(strsub),
      lokasiPertamina: lokasiController.text,
      totalLiter: literController.text,
      hargaPerLiter: int.parse(hargaPerLiterTxt),
      totalBayar: int.parse(totalBiayaTxt),
      odometer: odometerController.text,
      catatan: catatanController.text,
      lat: latitude,
      lang: langitude,
      status: 1,
    );
    context
        .read<BbmBloc>()
        .add(BBMInsertTransaksion(transaksi: transaksiModel, photo: dataPhoto));
    setState(() {
      BlocProvider.of<BbmBloc>(context).add(BBMStarted());
    });
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => Home("", "")));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SuccessDialogBox(deskripsi: "Berhasil Menambah Data");
      },
    );
  }

  Future<void> insertedImageToGallery(
      String dateNow, String _kodeTransaksi) async {
    _image.forEach((element) async {
      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(element!.readAsBytesSync()),
        quality: 60,
        name: dateNow,
      );
      // File file = await toFile(Uri.parse(result['filePath']).toString());
      // print("files = "+file.path.toString());
      PhotoModel modelPhoto = PhotoModel(
        id: 0,
        transaksi_id: _kodeTransaksi,
        linkPhoto: result['filePath'],
        namePhoto: dateNow,
      );
      setState(() {
        dataPhoto.add(modelPhoto);
      });
    });
  }

  String? _errorText(TextEditingController controller) {
    var val = controller.value.text.isEmpty ? "Tidak Boleh Kosong" : null;
    return val;
  }

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
                Card(dataKendaraan),
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
                SizedBox(
                  height: 25,
                ),
                ButtonSave(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ButtonSave() {
    return InkWell(
      onTap: () {
        _isButtonDisabled ? null : _submitted();
      },
      child: Container(
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
    );
  }

  Widget Card(KendaraanModel dataKendaraan) {
    return Container(
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
            dataKendaraan.jenisKendaraan == "motor"
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
                dataKendaraan.namaKendaraan,
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
    );
  }

  Widget BackButton() {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Home("home", ""))),
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
                      controller: catatanController,
                      maxLines: 5,
                      keyboardType: TextInputType.text,
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
                        hintText: "Catatan (optional)",
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
                  "assets/images/frmImage1.png",
                  width: 34,
                  height: 34,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF677D81),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            try {
                              final pickedImage = await ImagePicker()
                                  .pickImage(source: ImageSource.camera);

                              setState(() {
                                _image.add(File(pickedImage!.path));
                              });
                            } catch (e) {
                              // If an error occurs, log the error to the console.
                              print(e);
                            }
                          },
                          child: Container(
                            child: Image.asset(
                              "assets/images/frmAdd.png",
                              width: 34,
                              height: 34,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 34,
                            child: ListView.builder(
                              itemCount: _image.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  child: InkWell(
                                    onTap: () {
                                      _navigateAndDisplayImage(
                                          context, _image[index]!);
                                    },
                                    child: Container(
                                      child: Image.file(
                                        File(_image[index]!.path),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
        _internetEnable == false
            ? frameNegativeMaps(wifiOff)
            : _gpsEnable == false
                ? frameNegativeMaps(gpsOff)
                : framePositiveMaps(),
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
                  controller: lokasiController,
                  keyboardType: TextInputType.text,
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
                    hintText: "Alamat SPBU (optional)",
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

  Widget framePositiveMaps() {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFAEAEAE)),
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(48.8561, 2.2930),
          zoom: 15,
        ),
        markers: _markers,
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controllerMap = controller;
        },
      ),
    );
  }

  Widget frameNegativeMaps(text) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFAEAEAE)),
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Image.asset(
            "assets/images/wifi-off.png",
            width: 40,
          ),
          Container(
            width: 250,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Color(0xFF828282),
                fontSize: 9,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
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
                  controller: odometerController,
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
                    hintText: "Odometer (km)",
                    errorText:
                        _submittedForm ? _errorText(odometerController) : null,
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
                  controller: bbmController,
                  hintText: "Tipe Bahan Bakar",
                  errorText: _submittedForm ? _errorText(bbmController) : null,
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
                      controller: dateController,
                      readOnly: true,
                      onTap: () {
                        _restorableDatePickerRouteFuture.present();
                      },
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
                        hintText: selectedDate,
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
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
                      controller: timeController,
                      readOnly: true,
                      onTap: () {
                        _selectTime();
                      },
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
                        hintText: _time.format(context),
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
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
                  flex: 2,
                  child: TextField(
                    controller: literController,
                    keyboardType: TextInputType.number,
                    onTap: () => _checkBBMselected(),
                    readOnly: true,
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
                      hintText: "Liter",
                      errorText:
                          _submittedForm ? _errorText(literController) : null,
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
                    inputFormatters: <TextInputFormatter>[
                      CurrencyTextInputFormatter(
                        locale: 'id',
                        symbol: 'Rp. ',
                        decimalDigits: 0,
                      ),
                    ],
                    controller: hargaPerLiterController,
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
                      errorText: _submittedForm
                          ? _errorText(hargaPerLiterController)
                          : null,
                      hintText: "Harga/Liter",
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
                    inputFormatters: <TextInputFormatter>[
                      CurrencyTextInputFormatter(
                        locale: 'id',
                        symbol: 'Rp. ',
                        decimalDigits: 0,
                      ),
                    ],
                    controller: totalBiayaController,
                    keyboardType: TextInputType.number,
                    onTap: () => _checkBBMselected(),
                    // readOnly: !conditionBbm,
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
                      hintText: "Total Biaya",
                      errorText: _submittedForm
                          ? _errorText(totalBiayaController)
                          : null,
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
