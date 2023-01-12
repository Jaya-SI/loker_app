import 'package:loker/model/loker_model.dart';

abstract class BaseLokerRepository {
  Future<DataLoker> addLoker({
    required String idCategory,
    required String idHrd,
    required String nama,
    required String imgLoker,
    required String alamat,
    required String tanggal,
    required String deskripsi1,
    required String deskripsi2,
    required String deskripsi3,
    required String gaji,
    required String status,
  });
}
