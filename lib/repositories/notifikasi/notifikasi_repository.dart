import 'package:http/http.dart' as http;

import '../../common/shared_code.dart';
import '../../model/hrd_list_notifikasi_model.dart';
import '../../model/notifikasi_model.dart';
import 'base_notifikasi_repository.dart';

class NotifikasiRepository extends BaseNotifikasiRepository {
  @override
  Future<GetNotifikasiModel> getNotifikasi({String? id}) async {
    final res = await http.get(
        Uri.parse("${SharedCode.baseUrl}/api/pelamar/get-seleksi/pelamar/$id"));

    GetNotifikasiModel notifikasi = getNotifikasiModelFromJson(res.body)!;

    if (res.statusCode == 200) {
      return notifikasi;
    } else {
      throw notifikasi.message ?? 'Gagal Mendapatkan Notifikasi';
    }
  }

  Future<HrdGetListNotifikasiModel> hrdGetListNotifikasi() async {
    final res =
        await http.get(Uri.parse("${SharedCode.baseUrl}/api/hrd/list-seleksi"));

    HrdGetListNotifikasiModel notifikasi =
        hrdGetListNotifikasiModelFromJson(res.body)!;

    if (res.statusCode == 200) {
      return notifikasi;
    } else {
      throw notifikasi.message ?? 'Gagal Mendapatkan Notifikasi';
    }
  }
}
