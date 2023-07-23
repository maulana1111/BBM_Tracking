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
  // List<FileModel> _files = new List<FileModel>();

  @override
  void initState() {
    load();
    // TODO: implement initState
    super.initState();
  }

  Future<void> load() async {
    dataPhoto = widget.imagePath;
    setState(() {
      loading = true;
    });
  }
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
                            var replace = "/storage/emulated/0/Pictures/" +
                                dataPhoto[index].replaceAll(RegExp(':'), '_')+".jpg";
                            print("counting ${dataPhoto.length.toString()}, path = ${replace}");
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
      ),
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
