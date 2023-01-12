import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/hrd_list_notifikasi_model.dart';
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
        emit(NotifikasiLoaded(notifikasi: notifikasi));
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
  }
}
