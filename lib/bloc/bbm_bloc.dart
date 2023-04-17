import 'package:bbm_tracking/model/bensin_m.dart';
import 'package:bbm_tracking/model/kendaraan_m.dart';
import 'package:bbm_tracking/model/transaksi_m.dart';
import 'package:bbm_tracking/repository/kendaraan/kendaraan_repository.dart';
import 'package:bbm_tracking/repository/transaksi/transaksi_repository.dart';
import 'package:bbm_tracking/resource/data-bensin/data-bensin.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
  }

  Future<void> _onBBMChangeStatusKendaraan(
      BBMChangeStatusKendaraan event, Emitter<BbmState> emit) async {
    final state = this.state;
    try {
      if (state is BBMLoaded) {
        kendaraanRepository.changeStatuKendaraan(event.id, event.status);
        state.kendaraan.forEach((element) {
          element.status = 0;
        });
        state.kendaraan
            .elementAt(
                state.kendaraan.indexWhere((element) => element.id == event.id))
            .status = event.status;
        List<KendaraanModel> dataKendaraan = state.kendaraan;
        List<TransaksiModel> dataTransaksi = state.transaksi;
      }
    } catch (e) {
      emit(BBMError(message: "Something Error, ${e}, We Will Fix it"));
    }
  }

  Future<void> _onBBMKendaraanAdded(
      BBMDataKendaraanAdded event, Emitter<BbmState> emit) async {
    final state = this.state;
    try {
      if (state is BBMLoaded) {
        kendaraanRepository.addedKendaraan(event.kendaraanModel);
        List<KendaraanModel> dataKendaraan = state.kendaraan;
        dataKendaraan.add(event.kendaraanModel);
        List<TransaksiModel> dataTransaksi = state.transaksi;
        List<TransaksiModel> dataTransaksiThisMonth =
            await transaksiRepository.loadTransaksiThisMonth();
        emit(
          BBMLoaded(dataKendaraan, dataTransaksi, dataTransaksiThisMonth),
        );
      }
    } catch (e) {
      emit(BBMError(message: "Something Error, ${e}, We Will Fix it"));
    }
  }

  Future<void> _onBBMStarted(BBMStarted event, Emitter<BbmState> emit) async {
    try {
      List<KendaraanModel> dataKendaraan =
          await kendaraanRepository.loadKendaraan();
      List<TransaksiModel> dataTransaksi =
          await transaksiRepository.loadTransaksi();
      List<TransaksiModel> dataTransaksiThisMonth =
          await transaksiRepository.loadTransaksiThisMonth();

      emit(BBMLoaded(dataKendaraan, dataTransaksi, dataTransaksiThisMonth));
    } catch (e) {
      emit(BBMError(message: "Something Error, ${e}, We Will Fix it"));
    }
  }
}
