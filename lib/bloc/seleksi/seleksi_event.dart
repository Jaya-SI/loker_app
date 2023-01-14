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
  final String id;

  UpadateSeleksiEvent({
    required this.idPelamar,
    required this.idLoker,
    required this.suratLamaran,
    required this.status,
    required this.keterangan,
    required this.id,
  });

  @override
  List<Object> get props =>
      [idPelamar, idLoker, suratLamaran, status, keterangan];
}
