import '../../model/notifikasi_model.dart';

abstract class BaseNotifikasiRepository {
  Future<GetNotifikasiModel> getNotifikasi({String? id});
}