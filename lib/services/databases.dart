import 'package:bbm_tracking/model/bensin_m.dart';
import 'package:bbm_tracking/model/kendaraan_m.dart';
import 'package:bbm_tracking/model/photo_m.dart';
import 'package:bbm_tracking/model/transaksiPerMonth_m.dart';
import 'package:bbm_tracking/model/transaksi_m.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class DatabasesMain {
  Future<void> createTablesBensin(sql.Database database) async {
    await database.execute("""CREATE TABLE bensin(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        value TEXT,
        text TEXT,
        perusahaan TEXT,
        harga INTEGER
      )
      """);
  }

  Future<void> createTablesTransaksi(sql.Database database) async {
    await database.execute("""CREATE TABLE transaksi(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        kendaraanId TEXT,
        bensinId TEXT,
        kodeTransaksi TEXT,
        tanggalTransaksi DATETIME,
        waktuTransaksi DATETIME,
        lokasiPertamina TEXT,
        totalLiter TEXT,
        hargaPerLiter INTEGER,
        totalBayar INTEGER,
        odometer TEXT,
        catatan TEXT,
        latitude TEXT,
        longitude TEXT,
        status INTEGER
      )
      """);
  }

  Future<void> createTablesKendaraan(sql.Database database) async {
    await database.execute("""CREATE TABLE kendaraan(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        bahanBakar TEXT,
        jenisKendaraan TEXT,
        namaKendaraan TEXT,
        nomorPlat TEXT,
        cc INTEGER,
        odometer TEXT,
        kepemilikan TEXT,
        status INTEGER
      )
      """);
  }

  Future<void> createTableMapPhotoTransaction(sql.Database database) async {
    await database.execute("""CREATE TABLE photo(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      transaksi_id TEXT,
      linkPhoto TEXT,
      namePhoto TEXT
    )""");
  }

  Future<sql.Database> dbs() async {
    return sql.openDatabase(
      join(await sql.getDatabasesPath(), 'bbmtracking.db'),
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTablesBensin(database);
        await createTablesTransaksi(database);
        await createTablesKendaraan(database);
        await createTableMapPhotoTransaction(database);
      },
    );
  }

  //bensin
  Future<List<BensinModel>> getAllBensin() async {
    final db = await dbs();

    final List<Map<String, dynamic>> maps = await db.query('bensin');
    return List.generate(maps.length, (index) {
      return BensinModel(
        id: maps[index]['id'],
        value: maps[index]['value'],
        text: maps[index]['text'],
        perusahaan: maps[index]['perusahaan'],
        harga: maps[index]['harga'],
      );
    });
  }

  //kendaraan
  Future<List<KendaraanModel>> getAllKendaraan() async {
    final db = await dbs();

    final List<Map<String, dynamic>> maps = await db.query('kendaraan');
    return List.generate(maps.length, (index) {
      return KendaraanModel(
        id: maps[index]['id'],
        jenisKendaraan: maps[index]['jenisKendaraan'],
        namaKendaraan: maps[index]['namaKendaraan'],
        nomorPlat: maps[index]['nomorPlat'],
        bahanBakar: maps[index]['bahanBakar'],
        cc: maps[index]['cc'],
        odometer: maps[index]['odometer'],
        kepemilikan: maps[index]['kepemilikan'],
        status: maps[index]['status'],
      );
    });
  }

  Future<void> insertDataKendaraan(KendaraanModel kendaraan) async {
    final db = await dbs();
    await db.rawInsert(
        "INSERT INTO kendaraan(bahanBakar,jenisKendaraan,namaKendaraan,nomorPlat,cc,odometer,kepemilikan,status) VALUES('${kendaraan.bahanBakar}','${kendaraan.jenisKendaraan}','${kendaraan.namaKendaraan}','${kendaraan.nomorPlat}','${kendaraan.cc}','${kendaraan.odometer}','${kendaraan.kepemilikan}','${kendaraan.status}')");
  }

  Future<void> updateStatusAktifKendaraan(int id, int status) async {
    final db = await dbs();
    await db.rawUpdate("UPDATE kendaraan SET status = 0");
    await db
        .rawUpdate("UPDATE kendaraan SET status = ${status} WHERE id = ${id}");
  }

  // transaksi
  Future<List<TransaksiModel>> getAllTransaksiStatusSuccessfull() async {
    final db = await dbs();

    final List<Map<String, dynamic>> maps =
        await db.query('transaksi', where: "status = 1");

    return List.generate(maps.length, (index) {
      return TransaksiModel(
        id: maps[index]['id'],
        kendaraanId: maps[index]['kendaraanId'],
        bensinId: maps[index]['bensinId'],
        kodeTransaksi: maps[index]['kodeTransaksi'],
        tanggalTransaksi: maps[index]['tanggalTransaksi'] != null ? DateTime.parse(maps[index]['tanggalTransaksi']) : DateTime.now(),
        waktuTransaksi: maps[index]['waktuTransaksi'] != null ? DateTime.parse(maps[index]['waktuTransaksi']) : DateTime.now(),
        lokasiPertamina: maps[index]['lokasiPertamina'] != null ? maps[index]['lokasiPertamina'] : "-",
        totalLiter: maps[index]['totalLiter'] != null ? maps[index]['totalLiter'] : "0",
        hargaPerLiter: maps[index]['hargaPerLiter'] != null ? maps[index]['hargaPerLiter'] : 0,
        totalBayar: maps[index]['totalBayar'] != null ? maps[index]['totalBayar'] : 0,
        odometer: maps[index]['odometer'] != null ? maps[index]['odometer'] : "0",
        catatan: maps[index]['catatan'] != null ? maps[index]['catatan'] : "-",
        lat: maps[index]['latitude'] != null ? maps[index]['latitude'] : "0",
        lang: maps[index]['longitude'] != null ? maps[index]['longitude'] : "0",
        status: maps[index]['status'],
      );
    });
  }

  Future<List<TransaksiPerMonthModel>>
      getAllTransaksiStatusSuccessfullThisMonth(String datetime) async {
    final db = await dbs();

    final List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT kendaraanId, SUM(totalLiter), SUM(totalBayar), tanggalTransaksi FROM transaksi WHERE (strftime('%m', tanggalTransaksi) = strftime('%m', 'now')) AND status = 1 GROUP BY tanggalTransaksi ORDER BY tanggalTransaksi ASC");

    return List.generate(maps.length, (index) {
      return TransaksiPerMonthModel(
        kendaraanId: maps[index]['kendaraanId'],
        totalLiter: maps[index]['totalLiter'] != null ? maps[index]['totalLiter'] : 0,
        totalBayar: maps[index]['totalBayar'] != null ? maps[index]['totalBayar'] : 0,
        tanggalTransaksi: maps[index]['tanggalTransaksi'] != null ? DateTime.parse(maps[index]['tanggalTransaksi']) : DateTime.now(),
      );
    });
  }

  Future<List<TransaksiModel>> getAllTransaksiStatusDraft() async {
    final db = await dbs();

    final List<Map<String, dynamic>> maps =
        await db.query('transaksi', where: "status = 0");

    return List.generate(maps.length, (index) {
      return TransaksiModel(
        id: maps[index]['id'],
        kendaraanId: maps[index]['kendaraanId'],
        bensinId: maps[index]['bensinId'],
        kodeTransaksi: maps[index]['kodeTransaksi'],
        tanggalTransaksi: maps[index]['tanggalTransaksi'] != null ? DateTime.parse(maps[index]['tanggalTransaksi']) : DateTime.now(),
        waktuTransaksi: maps[index]['waktuTransaksi'] != null ? DateTime.parse(maps[index]['waktuTransaksi']) : DateTime.now(),
        lokasiPertamina: maps[index]['lokasiPertamina'] != null ? maps[index]['lokasiPertamina'] : "-",
        totalLiter: maps[index]['totalLiter'] != null ? maps[index]['totalLiter'] : "0",
        hargaPerLiter: maps[index]['hargaPerLiter'] != null ? maps[index]['hargaPerLiter'] : 0,
        totalBayar: maps[index]['totalBayar'] != null ? maps[index]['totalBayar'] : 0,
        odometer: maps[index]['odometer'] != null ? maps[index]['odometer'] : "0",
        catatan: maps[index]['catatan'] != null ? maps[index]['catatan'] : "-",
        lat: maps[index]['latitude'] != null ? maps[index]['latitude'] : "0",
        lang: maps[index]['longitude'] != null ? maps[index]['longitude'] : "0",
        status: maps[index]['status'],
      );
    });
  }

  Future<void> insertDataTransaksi(TransaksiModel model) async {
    final db = await dbs();

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(model.tanggalTransaksi);
    final qry = "INSERT INTO transaksi(kendaraanId,bensinId,kodeTransaksi,tanggalTransaksi,waktuTransaksi,lokasiPertamina,totalLiter,HargaPerliter,totalBayar,odometer,catatan,latitude,longitude,status) " +
            "VALUES('${model.kendaraanId}','${model.bensinId}','${model.kodeTransaksi}','${model.tanggalTransaksi.toString()}','${model.waktuTransaksi.toString()}','${model.lokasiPertamina}','${model.totalLiter}','${model.hargaPerLiter}','${model.totalBayar}','${model.odometer}','${model.catatan}','${model.lat}','${model.lang}','${model.status}')";
    await db.rawInsert(qry);
    // print(qry);
  }

  // photo
  Future<void> insertDataPhoto(PhotoModel model) async {
    final db = await dbs();
    await db.rawInsert(
        "INSERT INTO photo(transaksi_id,linkPhoto,namePhoto) VALUES('${model.transaksi_id}','${model.linkPhoto}','${model.namePhoto}')");
  }
}
