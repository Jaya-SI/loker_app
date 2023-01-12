import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:loker/model/get_loker_model.dart';
import 'package:loker/repositories/loker/loker_repository.dart';

import '../../model/loker_model.dart';
import '../../model/seleksi_model.dart';

part 'loker_event.dart';
part 'loker_state.dart';

class LokerBloc extends Bloc<LokerEvent, LokerState> {
  final LokerRepository _repository;
  LokerBloc(this._repository) : super(LokerInitial()) {
    on<LokerAddEvent>((event, emit) async {
      emit(LokerLoading());
      try {
        DataLoker loker = await _repository.addLoker(
          idCategory: event.idCategory,
          idHrd: event.idHrd,
          nama: event.nama,
          imgLoker: event.imgLoker,
          alamat: event.alamat,
          tanggal: event.tanggal,
          deskripsi1: event.deskripsi1,
          deskripsi2: event.deskripsi2,
          deskripsi3: event.deskripsi3,
          gaji: event.gaji,
          status: event.status,
        );
        emit(LokerLoaded(lokerModel: loker));
      } catch (e) {
        emit(LokerError(message: 'Gagal menambahkan loker'));
      }
    });

    //pelamar
    on<AddLokertoSeleksiEvent>((event, emit) async {
      emit(LokerLoading());
      try {
        AddSeleksiModel loker = await _repository.addSeleksi(
          suratLamaran: event.suratLamaran,
          idLoker: event.idLoker,
          idPelamar: event.idPelamar,
          status: 'seleksi',
        );
        emit(SeleksiLoaded(seleksiModel: loker));
      } catch (e) {
        emit(LokerError(message: 'Gagal menambahkan loker'));
      }
    });

    //pelamar check loker
    on<CheckRegisteredLokerEvent>((event, emit) async {
      emit(LokerLoading());
      try {
        CheckRegisteredLokerMode loker = await _repository.checkRegisteredLoker(
          idLoker: event.idLoker,
          idPelamar: event.idPelamar,
        );
        emit(CheckLokerLoaded(checkLokerModel: loker));
      } catch (e) {
        emit(LokerError(message: 'Loker Belum di daftar'));
      }
    });

    on<GetLokerEvent>((event, emit) async {
      emit(LokerLoading());
      try {
        GetLokerModel getLoker = await _repository.getLoker();
        emit(LokerGetLoaded(getLokerModel: getLoker));
      } catch (e) {
        emit(LokerError(message: 'Gagal mendapatkan loker'));
      }
    });

    on<GetLokerDashboardEvent>((event, emit) async {
      emit(LokerLoading());
      try {
        GetLokerModel getLoker = await _repository.getLokerOpen();
        emit(LokerGetLoaded(getLokerModel: getLoker));
      } catch (e) {
        emit(LokerError(message: 'Gagal mendapatkan loker'));
      }
    });

    on<GetLokerByIdCategoryEvent>((event, emit) async {
      emit(LokerLoading());
      try {
        GetLokerModel getLoker =
            await _repository.getLokeridCategory(event.idCategory);
        emit(LokerGetLoaded(getLokerModel: getLoker));
      } catch (e) {
        emit(LokerError(message: 'Gagal mendapatkan loker'));
      }
    });

    on<LokerDeleteEvent>((event, emit) async {
      emit(LokerLoading());
      try {
        DataLoker loker = await _repository.deleteLoker(idLoker: event.idLoker);
        emit(LokerLoaded(lokerModel: loker));
      } catch (e) {
        emit(LokerError(message: 'Gagal menghapus loker'));
      }
    });

    on<LokerUpdateEvent>((event, emit) async {
      emit(LokerLoading());
      try {
        DataLoker loker = await _repository.updateLoker(
          idLoker: event.idLoker,
          idCategory: event.idCategory,
          idHrd: event.idHrd,
          nama: event.nama,
          imgLoker: event.imgLoker,
          alamat: event.alamat,
          tanggal: event.tanggal,
          deskripsi1: event.deskripsi1,
          deskripsi2: event.deskripsi2,
          deskripsi3: event.deskripsi3,
          gaji: event.gaji,
          status: event.status,
        );
        emit(LokerLoaded(lokerModel: loker));
      } catch (e) {
        emit(LokerError(message: 'Gagal mengupdate loker'));
      }
    });
  }
}
