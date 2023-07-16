import 'dart:io';

import 'package:flutter/material.dart';

class ViewImage extends StatefulWidget {
  final List<File> imagePath;
  const ViewImage({super.key, required this.imagePath});

  @override
  State<ViewImage> createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  List<File>? data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = widget.imagePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE3EAEA),
      body: Container(
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
                  shrinkWrap: true,
                  itemCount: data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return screenImage(
                      data?.elementAt(index),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget screenImage(param) {
    print("param = ${param}");
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Padding(
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
