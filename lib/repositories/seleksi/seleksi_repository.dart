import 'dart:convert';

import 'package:loker/common/shared_code.dart';
import 'package:loker/model/hrd_list_notifikasi_model.dart';
import 'package:loker/repositories/seleksi/base_seleksi_repository.dart';
import 'package:http/http.dart' as http;

import '../../model/interview_model.dart';
import '../../model/update_seleksi_model.dart';

class SeleksiRepository extends BaseSeleksiRepository {
  @override
  Future<DataSeleksi> updateSeleksi({
    required String idPelamar,
    required String idLoker,
    required String suratLamaran,
    required String status,
    required String keterangan,
    required String id,
  }) async {
    Map<String, String> data = {
      'id_pelamar': idPelamar,
      'id_loker': idLoker,
      'surat_lamaran': suratLamaran,
      'status': status,
      'keterangan': keterangan,
      'id': id,
    };

    final response = await http.post(
        Uri.parse("${SharedCode.baseUrl}/api/hrd/update-seleksi/$id"),
        body: data);

    final seleksi = updateSeleksiModelFromJson(response.body);

    if (response.statusCode == 200) {
      return seleksi!.data!;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<DataAddInterview> addSeleksitoInterview({
    required String idSeleksi,
    required String idHrd,
    required String idPelamar,
    required String jadwal,
    required String keterangan,
  }) async {
    Map<String, String> data = {
      'id_seleksi': idSeleksi,
      'id_hrd': idHrd,
      'id_pelamar': idPelamar,
      'jadwal': jadwal,
      'status': 'Interview',
      'keterangan': keterangan,
    };

    final response = await http.post(
        Uri.parse("${SharedCode.baseUrl}/api/hrd/add-interview"),
        body: data);

    AddInterviewModel interview = addInterviewModelFromJson(response.body)!;

    if (response.statusCode == 200) {
      return interview.data!;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
