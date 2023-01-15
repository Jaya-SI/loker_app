part of 'notifikasi_bloc.dart';

abstract class NotifikasiEvent extends Equatable {
  const NotifikasiEvent();

  @override
  List<Object> get props => [];
}

class GetNotifikasiEvent extends NotifikasiEvent {
  String? id;

  GetNotifikasiEvent({this.id});
  @override
  List<Object> get props => [];
}

class GetNotifikasiAllEvent extends NotifikasiEvent {
  String? id;

  GetNotifikasiAllEvent({this.id});
  @override
  List<Object> get props => [];
}

class HrdGetListNotifikasiEvent extends NotifikasiEvent {
  HrdGetListNotifikasiEvent();
  @override
  List<Object> get props => [];
}

class HrdGetListNotifikasiInterviewEvent extends NotifikasiEvent {
  HrdGetListNotifikasiInterviewEvent();
  @override
  List<Object> get props => [];
}