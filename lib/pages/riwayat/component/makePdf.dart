import 'dart:typed_data';

import 'package:bbm_tracking/model/kendaraan_m.dart';
import 'package:bbm_tracking/model/photo_m.dart';
import 'package:bbm_tracking/model/transaksi_m.dart';
import 'package:bbm_tracking/repository/transaksi/transaksi_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
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

  Future<List<PhotoModel>> loadPhoto(param) async {
    List<PhotoModel> photo = await TransaksiRepository().getPhoto(param);
    return photo;
  }

  Future<Uint8List> makePdf(
      TransaksiModel transaksi, KendaraanModel kendaraan) async {
    final pdf = pw.Document();
    List<PhotoModel> photo = await loadPhoto(transaksi.kodeTransaksi);
    List<MemoryImage> image = [];

    // photo.forEach((element) {
    //   image.add(pw.MemoryImage(
    //   File('test.webp').readAsBytesSync(),
    // ));
    // });

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
                    "Kode Transaksi",
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
                    "Honda PCX",
                    style: pw.TextStyle(
                      font: ttf,
                      fontSize: 13,
                      color: PdfColor.fromInt(0xff000000),
                    ),
                  ),
                  pw.Text(
                    "B 7783 KKW",
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
                            "12 Januari 2020",
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
                          "10:30 WIB",
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
                          "Pertamax",
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
                          "Nama SPBU",
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 13,
                            color: PdfColor.fromInt(0xff000000),
                          ),
                        ),
                        pw.Text(
                          "SPBU Kalimalang",
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
                          "10 L",
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
                          "Rp. 100.000",
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
                          "Rp. 110.000",
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
                          "111111 KM",
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
                          "Ketemu Client",
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
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
