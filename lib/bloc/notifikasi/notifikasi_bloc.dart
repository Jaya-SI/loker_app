import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/hrd_list_notifikasi_model.dart';
import '../../model/list_interview_model.dart';
import '../../model/notifikasi_model.dart';
import '../../repositories/notifikasi/notifikasi_repository.dart';

part 'notifikasi_event.dart';
part 'notifikasi_state.dart';

class NotifikasiBloc extends Bloc<NotifikasiEvent, NotifikasiState> {
  final NotifikasiRepository _repository;
  NotifikasiBloc(this._repository) : super(NotifikasiInitial()) {
    on<GetNotifikasiEvent>((event, emit) async {
      emit(NotifikasiLoading());
      try {
        GetNotifikasiModel notifikasi =
            await _repository.getNotifikasi(id: event.id);
        ListInterviewModel interviewNotifikiasi =
            await _repository.getListInterveiwPelamar(id: event.id);
        emit(NotifikasiLoadAllPelamar(
            notifikasi: notifikasi, notifikasiInterview: interviewNotifikiasi));
      } catch (e) {
        emit(NotifikasiError(message: e.toString()));
      }
    });
    on<HrdGetListNotifikasiEvent>((event, emit) async {
      emit(NotifikasiLoading());
      try {
        HrdGetListNotifikasiModel notifikasi =
            await _repository.hrdGetListNotifikasi();
        emit(HrdGetNotifikasiLoaded(notifikasi: notifikasi));
      } catch (e) {
        emit(NotifikasiError(message: e.toString()));
      }
    });

    on<HrdGetListNotifikasiInterviewEvent>((event, emit) async {
      emit(NotifikasiLoading());
      try {
        ListInterviewModel notifikasi = await _repository.getListInterview();
        emit(HrdGetNotifikasiInterviewLoaded(notifikasi: notifikasi));
      } catch (e) {
        emit(NotifikasiError(message: e.toString()));
      }
    });

    on<GetNotifikasiAllEvent>((event, emit) async {
      emit(NotifikasiLoading());
      try {
        GetNotifikasiModel notifikasi =
            await _repository.getNotifikasi(id: event.id);
        HrdGetListNotifikasiModel notifikasiHrd =
            await _repository.hrdGetListNotifikasi();
        ListInterviewModel notifikasiInterview =
            await _repository.getListInterview();
        emit(NotifikasiLoadAll(
            notifikasi: notifikasi,
            notifikasiHrd: notifikasiHrd,
            notifikasiInterview: notifikasiInterview));
      } catch (e) {
        emit(NotifikasiError(message: e.toString()));
      }
    });
  }
}
