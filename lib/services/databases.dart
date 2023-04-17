import 'package:bbm_tracking/model/bensin_m.dart';
import 'package:bbm_tracking/model/kendaraan_m.dart';
import 'package:bbm_tracking/model/transaksi_m.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';
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
        tanggalTransaksi TEXT,
        lokasiPertamina TEXT,
        totalLiter INTEGER,
        hargaPerLiter INTEGER,
        totalBayar INTEGER,
        odometer TEXT,
        linkGambar TEXT,
        catatan TEXT,
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

  Future<sql.Database> dbs() async {
    return sql.openDatabase(
      join(await sql.getDatabasesPath(), 'bbmtracking.db'),
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTablesBensin(database);
        await createTablesTransaksi(database);
        await createTablesKendaraan(database);
      },
    );
  }

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
        tanggalTransaksi: maps[index]['tanggalTransaksi'],
        lokasiPertamina: maps[index]['lokasiPertamina'],
        totalLiter: maps[index]['totalLiter'],
        hargaPerLiter: maps[index]['hargaPerLiter'],
        totalBayar: maps[index]['totalBayar'],
        odometer: maps[index]['odometer'],
        linkGambar: maps[index]['linkGambar'],
        catatan: maps[index]['catatan'],
        status: maps[index]['status'],
      );
    });
  }


  Future<List<TransaksiModel>> getAllTransaksiStatusSuccessfullThisMonth() async {
    final db = await dbs();

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM transaksi WHERE (strftime('%M', tanggalTransaksi) = strftime('%W', 'now')) AND status = 1");

    return List.generate(maps.length, (index) {
      return TransaksiModel(
        id: maps[index]['id'],
        kendaraanId: maps[index]['kendaraanId'],
        bensinId: maps[index]['bensinId'],
        kodeTransaksi: maps[index]['kodeTransaksi'],
        tanggalTransaksi: maps[index]['tanggalTransaksi'],
        lokasiPertamina: maps[index]['lokasiPertamina'],
        totalLiter: maps[index]['totalLiter'],
        hargaPerLiter: maps[index]['hargaPerLiter'],
        totalBayar: maps[index]['totalBayar'],
        odometer: maps[index]['odometer'],
        linkGambar: maps[index]['linkGambar'],
        catatan: maps[index]['catatan'],
        status: maps[index]['status'],
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
        tanggalTransaksi: maps[index]['tanggalTransaksi'],
        lokasiPertamina: maps[index]['lokasiPertamina'],
        totalLiter: maps[index]['totalLiter'],
        hargaPerLiter: maps[index]['hargaPerLiter'],
        totalBayar: maps[index]['totalBayar'],
        odometer: maps[index]['odometer'],
        linkGambar: maps[index]['linkGambar'],
        catatan: maps[index]['catatan'],
        status: maps[index]['status'],
      );
    });
  }

  Future<void> insertDataKendaraan(KendaraanModel kendaraan) async {
    final db = await dbs();
    await db.rawInsert(
      "INSERT INTO kendaraan(bahanBakar,jenisKendaraan,namaKendaraan,nomorPlat,cc,odometer,kepemilikan,status) VALUES('${kendaraan.bahanBakar}','${kendaraan.jenisKendaraan}','${kendaraan.namaKendaraan}','${kendaraan.nomorPlat}','${kendaraan.cc}','${kendaraan.odometer}','${kendaraan.kepemilikan}','${kendaraan.status}')"
    );
  }

  Future<void> updateStatusAktifKendaraan(int id, int status) async
  {
    final db = await dbs();
    await db.rawUpdate("UPDATE kendaraan SET status = 0");
    await db.rawUpdate("UPDATE kendaraan SET status = ${status} WHERE id = ${id}");
  }
}
