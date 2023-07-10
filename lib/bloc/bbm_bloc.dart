import 'package:bbm_tracking/model/bensin_m.dart';
import 'package:bbm_tracking/model/kendaraan_m.dart';
import 'package:bbm_tracking/model/photo_m.dart';
import 'package:bbm_tracking/model/transaksiPerMonth_m.dart';
import 'package:bbm_tracking/model/transaksi_m.dart';
import 'package:bbm_tracking/repository/kendaraan/kendaraan_repository.dart';
import 'package:bbm_tracking/repository/transaksi/transaksi_repository.dart';
import 'package:bbm_tracking/resource/data-bensin/data-bensin.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'bbm_event.dart';
part 'bbm_state.dart';

class BbmBloc extends Bloc<BbmEvent, BbmState> {
  final KendaraanRepository kendaraanRepository;
  final TransaksiRepository transaksiRepository;

  BbmBloc(
      {required this.kendaraanRepository, required this.transaksiRepository})
      : super(BbmInitial()) {
    on<BBMStarted>(_onBBMStarted);
    on<BBMDataKendaraanAdded>(_onBBMKendaraanAdded);
    on<BBMChangeStatusKendaraan>(_onBBMChangeStatusKendaraan);
    on<BBMDataKendaraan>(_onBBMGetDataKendaraan);
    on<BBMInsertTransaksion>(_onBBMInsertTransaksi);
    on<BBMAllDataKendaraan>(_onBBMGetAllKendaraan);
    on<BBMChangeDataTransaction>(_onBBMChangeDataTransaction);
  }

  Future<void> _onBBMChangeDataTransaction(
    BBMChangeDataTransaction event,
    Emitter<BbmState> emit,
  ) async {
    try {
      List<KendaraanModel> dataKendaraan =
          await kendaraanRepository.loadKendaraan();
      List<TransaksiModel> dataTransaksi =
          await transaksiRepository.loadTransaksi();
      List<TransaksiPerMonthModel> dataTransaksiThisMonth =
          await transaksiRepository.loadTransaksiThisMonth(event.selectedDate);

      emit(BBMLoaded(dataKendaraan, dataTransaksi, dataTransaksiThisMonth));
    } catch (e) {
      emit(BBMError(message: "Something Error, ${e}, We Will Fix it"));
    }
  }

  Future<void> _onBBMGetDataKendaraan(
    BBMDataKendaraan event,
    Emitter<BbmState> emit,
  ) async {
    final state = this.state;
    try {
      if (state is BBMLoaded) {
        late KendaraanModel dataKendaraan;
        state.kendaraan.forEach((element) {
          if (element.id == event.kendaraanModel.id) {
            dataKendaraan = element;
          }
        });
        emit(BBMSingleData(kendaraan: dataKendaraan));
      }
    } catch (e) {
      emit(BBMError(message: "Something Error, ${e}, We Will Fix it"));
    }
  }

  Future<void> _onBBMGetAllKendaraan(
    BBMAllDataKendaraan event,
    Emitter<BbmState> emit,
  ) async {
    try {
      List<KendaraanModel> dataKendaraan =
          await kendaraanRepository.loadKendaraan();
      emit(BBMKendaraanLoaded(kendaraan: dataKendaraan));
    } catch (e) {
      emit(BBMError(message: "Something Error, ${e}, We Will Fix it"));
    }
  }

  Future<void> _onBBMChangeStatusKendaraan(
    BBMChangeStatusKendaraan event,
    Emitter<BbmState> emit,
  ) async {
    final state = this.state;
    try {
      if (state is BBMLoaded) {
        await kendaraanRepository.changeStatuKendaraan(event.id, event.status);
        state.kendaraan.forEach((element) {
          element.status = 0;
        });
        state.kendaraan
            .elementAt(
                state.kendaraan.indexWhere((element) => element.id == event.id))
            .status = event.status;
        // List<KendaraanModel> dataKendaraan = state.kendaraan;
        // List<TransaksiModel> dataTransaksi = state.transaksi;
        // print("data dari bloc = "+dataKendaraan[0].status.toString());
        // emit(BBMLoaded(dataKendaraan, dataTransaksi, dataTransaksi));
      }
    } catch (e) {
      emit(BBMError(message: "Something Error, ${e}, We Will Fix it"));
    }
  }

  Future<void> _onBBMKendaraanAdded(
    BBMDataKendaraanAdded event,
    Emitter<BbmState> emit,
  ) async {
    final state = this.state;
    try {
      if (state is BBMLoaded) {
        await kendaraanRepository.addedKendaraan(event.kendaraanModel);
        List<KendaraanModel> dataKendaraan = state.kendaraan;
        event.kendaraanModel.id = state.kendaraan.length + 1;
        dataKendaraan.add(event.kendaraanModel);
        List<TransaksiModel> dataTransaksi = state.transaksi;
        List<TransaksiPerMonthModel> dataTransaksiThisMonth =
            await transaksiRepository.loadTransaksiThisMonth(DateFormat("yyyy-MM-dd").parse(DateTime.now().toString()).toString());
        emit(
          BBMLoaded(dataKendaraan, dataTransaksi, dataTransaksiThisMonth),
        );
      }
    } catch (e) {
      emit(BBMError(message: "Something Error, ${e}, We Will Fix it"));
    }
  }

  Future<void> _onBBMStarted(
    BBMStarted event,
    Emitter<BbmState> emit,
  ) async {
    try {
      List<KendaraanModel> dataKendaraan =
          await kendaraanRepository.loadKendaraan();
      List<TransaksiModel> dataTransaksi =
          await transaksiRepository.loadTransaksi();
      List<TransaksiPerMonthModel> dataTransaksiThisMonth =
          await transaksiRepository.loadTransaksiThisMonth(DateFormat("yyyy-MM-dd").parse(DateTime.now().toString()).toString());

      emit(BBMLoaded(dataKendaraan, dataTransaksi, dataTransaksiThisMonth));
    } catch (e) {
      print("hit here = " + e.toString());
      emit(BBMError(message: "Something Error, ${e}, We Will Fix it"));
    }
  }

  Future<void> _onBBMInsertTransaksi(
    BBMInsertTransaksion event,
    Emitter<BbmState> emit,
  ) async {
    try {
      final state = this.state;

      if (state is BBMLoaded) {
        await transaksiRepository.insertTransaksi(event.transaksi);
        for (PhotoModel element in event.photo) {
          await transaksiRepository.insertPhoto(element);
        }

        List<KendaraanModel> dataKendaraan =
            await kendaraanRepository.loadKendaraan();
        List<TransaksiModel> dataTransaksi =
            await transaksiRepository.loadTransaksi();
        List<TransaksiPerMonthModel> dataTransaksiThisMonth =
            await transaksiRepository.loadTransaksiThisMonth(DateFormat("yyyy-MM-dd").parse(DateTime.now().toString()).toString());

        emit(BBMLoaded(dataKendaraan, dataTransaksi, dataTransaksiThisMonth));
      }
    } catch (e) {
      emit(BBMError(message: "Something Error, ${e}, We Will Fix it"));
    }
  }
}
