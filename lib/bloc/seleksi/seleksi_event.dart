part of 'seleksi_bloc.dart';

abstract class SeleksiEvent extends Equatable {
  const SeleksiEvent();

  @override
  List<Object> get props => [];
}

class UpadateSeleksiEvent extends SeleksiEvent {
  final String idPelamar;
  final String idLoker;
  final String suratLamaran;
  final String status;
  final String keterangan;
  final String? token;
  final String? posisi;
  final String id;

  UpadateSeleksiEvent({
    required this.idPelamar,
    required this.idLoker,
    required this.suratLamaran,
    required this.status,
    this.token,
    this.posisi,
    required this.keterangan,
    required this.id,
  });

  @override
  List<Object> get props =>
      [idPelamar, idLoker, suratLamaran, status, keterangan];
}

class AddInterviewEvent extends SeleksiEvent {
  final String idSeleksi;
  final String idHrd;
  final String idPelamar;
  final String jadwal;
  final String keterangan;
  String? token;
  final String idLoker;

  AddInterviewEvent({
    required this.idSeleksi,
    required this.idPelamar,
    required this.idHrd,
    required this.jadwal,
    required this.keterangan,
    this.token,
    required this.idLoker,
  });

  @override
  List<Object> get props => [
        idSeleksi,
        idHrd,
        idPelamar,
        jadwal,
      ];
}
