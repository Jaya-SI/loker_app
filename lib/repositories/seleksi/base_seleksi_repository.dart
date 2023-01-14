import '../../model/update_seleksi_model.dart';

abstract class BaseSeleksiRepository {
  Future<DataSeleksi> updateSeleksi({
    required String idPelamar,
    required String idLoker,
    required String suratLamaran,
    required String status,
    required String keterangan,
    required String id,
  });
}
