part of 'loker_bloc.dart';

abstract class LokerEvent extends Equatable {
  const LokerEvent();

  @override
  List<Object> get props => [];
}

class LokerAddEvent extends LokerEvent {
  final String idCategory;
  final String idHrd;
  final String nama;
  final String imgLoker;
  final String alamat;
  final String tanggal;
  final String deskripsi1;
  final String deskripsi2;
  final String deskripsi3;
  final String gaji;
  final String status;

  LokerAddEvent({
    required this.idCategory,
    required this.idHrd,
    required this.nama,
    required this.imgLoker,
    required this.alamat,
    required this.tanggal,
    required this.deskripsi1,
    required this.deskripsi2,
    required this.deskripsi3,
    required this.gaji,
    required this.status,
  });

  @override
  List<Object> get props => [
        idCategory,
        idHrd,
        nama,
        imgLoker,
        alamat,
        tanggal,
        deskripsi1,
        deskripsi2,
        deskripsi3,
        gaji,
        status,
      ];
}

class GetLokerEvent extends LokerEvent {
  @override
  List<Object> get props => [];
}

class LokerDeleteEvent extends LokerEvent {
  final String idLoker;

  LokerDeleteEvent({required this.idLoker});

  @override
  List<Object> get props => [idLoker];
}

class GetLokerDashboardEvent extends LokerEvent {
  @override
  List<Object> get props => [];
}

class GetLokerByIdCategoryEvent extends LokerEvent {
  final String idCategory;

  GetLokerByIdCategoryEvent({required this.idCategory});

  @override
  List<Object> get props => [idCategory];
}

class AddLokertoSeleksiEvent extends LokerEvent {
  final String idLoker;
  final String idPelamar;
  final String suratLamaran;

  AddLokertoSeleksiEvent({
    required this.idLoker,
    required this.idPelamar,
    required this.suratLamaran,
  });

  @override
  List<Object> get props => [
        idLoker,
        idPelamar,
        suratLamaran,
      ];
}

class CheckRegisteredLokerEvent extends LokerEvent {
  final String idLoker;
  final String idPelamar;

  CheckRegisteredLokerEvent({
    required this.idLoker,
    required this.idPelamar,
  });

  @override
  List<Object> get props => [
        idLoker,
        idPelamar,
      ];
}

class LokerUpdateEvent extends LokerEvent {
  final String idLoker;
  final String idCategory;
  final String idHrd;
  final String nama;
  String? imgLoker;
  final String alamat;
  final String tanggal;
  final String deskripsi1;
  final String deskripsi2;
  final String deskripsi3;
  final String gaji;
  final String status;

  LokerUpdateEvent({
    required this.idLoker,
    required this.idCategory,
    required this.idHrd,
    required this.nama,
    this.imgLoker,
    required this.alamat,
    required this.tanggal,
    required this.deskripsi1,
    required this.deskripsi2,
    required this.deskripsi3,
    required this.gaji,
    required this.status,
  });

  @override
  List<Object> get props => [
        idLoker,
        idCategory,
        idHrd,
        nama,
        alamat,
        tanggal,
        deskripsi1,
        deskripsi2,
        deskripsi3,
        gaji,
        status,
      ];
}
