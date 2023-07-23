import 'dart:typed_data';

import 'package:bbm_tracking/model/kendaraan_m.dart';
import 'package:bbm_tracking/model/photo_m.dart';
import 'package:bbm_tracking/model/transaksi_m.dart';
import 'package:bbm_tracking/repository/transaksi/transaksi_repository.dart';
import 'package:bbm_tracking/resource/convert_money/convert_money.dart';
import 'package:bbm_tracking/resource/data-bensin/data-bensin.dart';
import 'package:bbm_tracking/resource/data-tanggal/bulan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:io';

class MakePdf extends StatelessWidget {
  TransaksiModel transaksi;
  KendaraanModel kendaraan;
  MakePdf({super.key, required this.transaksi, required this.kendaraan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF Preview"),
      ),
      body: PdfPreview(
        build: (context) => makePdf(transaksi, kendaraan),
      ),
    );
  }

  List<PhotoModel> photos = [];
  List<Uint8List> imagesUint8list = [];
  List<pw.Widget> pdfImagesWidget = [];

  Future<List<PhotoModel>> loadPhoto(param) async {
    List<PhotoModel> photo = await TransaksiRepository().getPhoto(param);
    return photo;
  }

  String reformatDate(DateTime date) {
    String data = "";
    for (int i = 0; i < bulan.length; i++) {
      if (i + 1 == date.month) {
        data += "${date.day} ${bulan[i]} ${date.year}";
      }
    }
    return data;
  }

  Future<Uint8List> makePdf(
    TransaksiModel transaksi,
    KendaraanModel kendaraan,
  ) async {
    final pdf = pw.Document();
    photos = await loadPhoto(transaksi.kodeTransaksi);

    photos.forEach((element) async {
      var replace = "/storage/emulated/0/Pictures/" +
          element.namePhoto.replaceAll(RegExp(':'), '_') +
          ".jpg";
      Uri myUri = Uri.parse(replace);
      File imageFile = new File.fromUri(myUri);
      // final ByteData bytes = await imageFile.readAsBytes();
      final Uint8List byteList = imageFile.readAsBytesSync();
      
      imagesUint8list.add(byteList);
    });

    pdfImagesWidget = imagesUint8list.map(
      (image) {
        return pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisSize: pw.MainAxisSize.max,
            children: [
              pw.SizedBox(height: 10),
              pw.Image(
                  pw.MemoryImage(
                    image,
                  ),
                  height: 400,
                  fit: pw.BoxFit.fitHeight),
            ],
          ),
        );
      },
    ).toList();


    final fontData = await rootBundle.load("assets/fonts/Poppins-Medium.ttf");
    final ttf = pw.Font.ttf(fontData.buffer.asByteData());
    pdf.addPage(
      pw.Page(
        margin: pw.EdgeInsets.all(10),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "Detail Transaksi",
                style: pw.TextStyle(
                  font: ttf,
                  fontSize: 16,
                  color: PdfColor.fromInt(0xff3B3C48),
                ),
              ),
              pw.Divider(borderStyle: pw.BorderStyle.dashed),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    "Kode Transaksi",
                    style: pw.TextStyle(
                      font: ttf,
                      fontSize: 13,
                      color: PdfColor.fromInt(0xff000000),
                    ),
                  ),
                  pw.Text(
                    transaksi.kodeTransaksi,
                    style: pw.TextStyle(
                      font: ttf,
                      fontSize: 13,
                      color: PdfColor.fromInt(0xff000000),
                    ),
                  ),
                ],
              ),
              pw.Divider(borderStyle: pw.BorderStyle.dashed),
              pw.Text(
                "Tipe Kendaraan",
                style: pw.TextStyle(
                  font: ttf,
                  fontSize: 16,
                  color: PdfColor.fromInt(0xff000000),
                ),
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    kendaraan.namaKendaraan,
                    style: pw.TextStyle(
                      font: ttf,
                      fontSize: 13,
                      color: PdfColor.fromInt(0xff000000),
                    ),
                  ),
                  pw.Text(
                    kendaraan.nomorPlat,
                    style: pw.TextStyle(
                      font: ttf,
                      fontSize: 13,
                      color: PdfColor.fromInt(0xff000000),
                    ),
                  ),
                ],
              ),
              pw.Divider(borderStyle: pw.BorderStyle.dashed),
              pw.Text(
                "Detail",
                style: pw.TextStyle(
                  font: ttf,
                  fontSize: 16,
                  color: PdfColor.fromInt(0xff000000),
                ),
              ),
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(horizontal: 50),
                child: pw.Column(
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Center(
                          child: pw.Text(
                            "Tipe Transaksi",
                            style: pw.TextStyle(
                              font: ttf,
                              fontSize: 13,
                              color: PdfColor.fromInt(0xff000000),
                            ),
                          ),
                        ),
                        pw.Center(
                          child: pw.Text(
                            "Pengisian Bahan Bakar",
                            style: pw.TextStyle(
                              font: ttf,
                              fontSize: 13,
                              color: PdfColor.fromInt(0xff000000),
                            ),
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Align(
                          alignment: pw.Alignment.topLeft,
                          child: pw.Text(
                            "Data Transaksi",
                            style: pw.TextStyle(
                              font: ttf,
                              fontSize: 13,
                              color: PdfColor.fromInt(0xff000000),
                            ),
                          ),
                        ),
                        pw.Align(
                          alignment: pw.Alignment.topRight,
                          child: pw.Text(
                            reformatDate(transaksi.tanggalTransaksi),
                            style: pw.TextStyle(
                              font: ttf,
                              fontSize: 13,
                              color: PdfColor.fromInt(0xff000000),
                            ),
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "Waktu",
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 13,
                            color: PdfColor.fromInt(0xff000000),
                          ),
                        ),
                        pw.Text(
                          "${transaksi.tanggalTransaksi.hour}:${transaksi.tanggalTransaksi.minute} WIB",
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 13,
                            color: PdfColor.fromInt(0xff000000),
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "Jenis Bahan Bakar",
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 13,
                            color: PdfColor.fromInt(0xff000000),
                          ),
                        ),
                        pw.Text(
                          listBensin[int.parse(transaksi.bensinId) - 1].text,
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 13,
                            color: PdfColor.fromInt(0xff000000),
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "Alamat SPBU",
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 13,
                            color: PdfColor.fromInt(0xff000000),
                          ),
                        ),
                        pw.Text(
                          transaksi.lokasiPertamina,
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 13,
                            color: PdfColor.fromInt(0xff000000),
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "Total Liter",
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 13,
                            color: PdfColor.fromInt(0xff000000),
                          ),
                        ),
                        pw.Text(
                          "${transaksi.totalLiter} Liter",
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 13,
                            color: PdfColor.fromInt(0xff000000),
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "Harga / Liter",
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 13,
                            color: PdfColor.fromInt(0xff000000),
                          ),
                        ),
                        pw.Text(
                          "${CurrencyFormat.convertToIdr(listBensin[int.parse(transaksi.bensinId) - 1].harga, 0)}",
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 13,
                            color: PdfColor.fromInt(0xff000000),
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "Total Pembayaran",
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 13,
                            color: PdfColor.fromInt(0xff000000),
                          ),
                        ),
                        pw.Text(
                          CurrencyFormat.convertToIdr(transaksi.totalBayar, 0),
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 13,
                            color: PdfColor.fromInt(0xff000000),
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "Odometer",
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 13,
                            color: PdfColor.fromInt(0xff000000),
                          ),
                        ),
                        pw.Text(
                          "${transaksi.odometer} KM",
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 13,
                            color: PdfColor.fromInt(0xff000000),
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "Catatan",
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 13,
                            color: PdfColor.fromInt(0xff000000),
                          ),
                        ),
                        pw.Text(
                          transaksi.catatan,
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 13,
                            color: PdfColor.fromInt(0xff000000),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                mainAxisSize: pw.MainAxisSize.max,
                children: pdfImagesWidget,
              )
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
