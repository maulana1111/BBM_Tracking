import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ViewImage extends StatefulWidget {
  final List<String> imagePath;
  const ViewImage({super.key, required this.imagePath});

  @override
  State<ViewImage> createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  late List<String> dataPhoto;
  bool loading = false;

  @override
  void initState() {
    load();
    // TODO: implement initState
    super.initState();
    print("counting ${dataPhoto.length.toString()}, path = ${dataPhoto[0]}");
  }

  Future<void> load() async {
    dataPhoto = widget.imagePath;
    setState(() {
      loading = true;
    });
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  Future<File> _getLocalFile(String filename) async {
    final dir = await getExternalStorageDirectory();
    final rep = dir.toString().replaceAll(RegExp("'"), '');
    final rep1 = rep.toString().replaceFirst(
        RegExp(
            "/storage/emulated/0/Android/data/com.example.bbm_tracking/files"),
        '/Images/Pictures');
    File file = new File("/Images/Pictures/${filename}.jpg");
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE3EAEA),
      body: loading
          ? Container(
              margin: EdgeInsets.only(
                top: 50,
              ),
              child: Column(
                children: [
                  Container(
                    child: BackButton(),
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Expanded(
                      child: ListView.builder(
                        // shrinkWrap: true,
                        itemCount: dataPhoto.length,
                        itemBuilder: (BuildContext context, int index) {
                          var replace = "/data/user/0/com.example.bbm_tracking/cache/" +
                              dataPhoto[index].replaceAll(RegExp(':'), '_')+".jpg";
                          // var replace = dataPhoto[index];
                          return ScreenImage(
                            replace,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(),
    );
  }

  Widget ScreenImage(param) {
    print("counting data ${param}");
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5,
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  color: Colors.amber),
              child: Image.file(
                File(param),
                fit: BoxFit.cover,
              ),
              // child: FutureBuilder(
              //   future: _getLocalFile(param),
              //   builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
              //     print("parh ${snapshot.data.toString()}");
              //     return snapshot.data != null
              //         ? Image.file(
              //             File(snapshot.data.toString()),
              //             fit: BoxFit.cover,
              //           )
              //         : Container();
              //   },
              // ),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget BackButton() {
    return InkWell(
      onTap: () => Navigator.pop(context),
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
}
