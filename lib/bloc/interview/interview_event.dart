part of 'interview_bloc.dart';

abstract class InterviewEvent extends Equatable {
  const InterviewEvent();

  @override
  List<Object> get props => [];
}

class UpdateInterviewEvent extends InterviewEvent {
  final String? id;
  final String? idSeleksi;
  final String? idHrd;
  final String? jadwal;
  final String? token;
  final String? idPelamar;
  final String? status;
  final String? namaLoker;
  final String? idLoker;
  final String? keterangan;

  UpdateInterviewEvent({
    this.id,
    this.idSeleksi,
    this.idHrd,
    this.jadwal,
    this.token,
    this.idPelamar,
    this.status,
    this.namaLoker,
    this.idLoker,
    this.keterangan,
  });

  @override
  List<Object> get props => [];
}
