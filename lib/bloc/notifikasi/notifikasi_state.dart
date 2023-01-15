part of 'notifikasi_bloc.dart';

abstract class NotifikasiState extends Equatable {
  const NotifikasiState();

  @override
  List<Object> get props => [];
}

class NotifikasiInitial extends NotifikasiState {}

class NotifikasiLoading extends NotifikasiState {}

class NotifikasiLoadAll extends NotifikasiState {
  final GetNotifikasiModel notifikasi;
  final HrdGetListNotifikasiModel notifikasiHrd;
  final ListInterviewModel notifikasiInterview;

  NotifikasiLoadAll({required this.notifikasi, required this.notifikasiHrd, required this.notifikasiInterview});

  @override
  List<Object> get props => [notifikasi, notifikasiHrd, notifikasiInterview];
}

class NotifikasiLoaded extends NotifikasiState {
  final GetNotifikasiModel notifikasi;

  NotifikasiLoaded({required this.notifikasi});

  @override
  List<Object> get props => [notifikasi];
}

class HrdGetNotifikasiLoaded extends NotifikasiState {
  final HrdGetListNotifikasiModel notifikasi;

  HrdGetNotifikasiLoaded({required this.notifikasi});

  @override
  List<Object> get props => [notifikasi];
}

class HrdGetNotifikasiInterviewLoaded extends NotifikasiState {
  final ListInterviewModel notifikasi;

  HrdGetNotifikasiInterviewLoaded({required this.notifikasi});

  @override
  List<Object> get props => [notifikasi];
}

class NotifikasiError extends NotifikasiState {
  final String message;

  NotifikasiError({required this.message});

  @override
  List<Object> get props => [message];
}
