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
    String? token,
    String? posisi,
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

    sendPushMessage(token, "Status lamaran anda di posisi $posisi, $status");

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
    String? token,
    required String idLoker,
  }) async {
    Map<String, String> data = {
      'id_seleksi': idSeleksi,
      'id_hrd': idHrd,
      'id_pelamar': idPelamar,
      'jadwal': jadwal,
      'status': 'Interview',
      'keterangan': keterangan,
      'token': token!,
      'id_loker': idLoker,
    };

    final response = await http.post(
        Uri.parse("${SharedCode.baseUrl}/api/hrd/add-interview"),
        body: data);

    AddInterviewModel interview = addInterviewModelFromJson(response.body)!;

    sendPushMessage(
        token, "Status lamaran anda sudah di tahap Interview, $keterangan");

    if (response.statusCode == 200) {
      return interview.data!;
    } else {
      throw Exception('Failed to load data');
    }
  }
}

Future<void> sendPushMessage(String? token, String? message) async {
  try {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Authorization':
            'key = AAAAwU-csss:APA91bGRBpMMd5tdR4E0o-LA5Usn0YLuvygPyMI421OG6f3YI_UgM_UKqW3ovgCRTjyGOaBZfCCcCBanresDcFXVZ136eOOK5M0kWnP2Bq91pqhCRBm-mta6pwcZezdHkd5ht-Q_TpV7',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: constructFCMPayload(token, message),
    );
    print('FCM request for device sent!');
  } catch (e) {
    print(e);
  }
}

String constructFCMPayload(String? token, String? message) {
  return jsonEncode({
    "to": token,
    "notification": {"body": message, "title": "Notifikasi"}
  });
}
