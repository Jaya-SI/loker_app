part of 'interview_bloc.dart';

abstract class InterviewEvent extends Equatable {
  const InterviewEvent();

  @override
  List<Object> get props => [];
}

class UpdateInterviewEvent extends InterviewEvent {
  final String? idSeleksi;
  final String? idHrd;
  final String? jadwal;
  final String? token;
  final String? idPelamar;
  final String? status;

  UpdateInterviewEvent({
    this.idSeleksi,
    this.idHrd,
    this.jadwal,
    this.token,
    this.idPelamar,
    this.status,
  });

  @override
  List<Object> get props => [];
}
