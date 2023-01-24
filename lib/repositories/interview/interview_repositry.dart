import 'dart:convert';

import 'package:loker/repositories/interview/base_interview_repository.dart';

import '../../common/shared_code.dart';
import 'package:http/http.dart' as http;

import '../../model/update_interview_model.dart';

class InterviewRepository extends BaseInterviewRepository {
  @override
  Future<UpadateInterviewModel> updateInterview({
    String? idSeleksi,
    String? idHrd,
    String? jadwal,
    String? token,
    String? idPelamar,
    String? status,
    String? id,
    String? namaLoker,
    String? idLoker,
    String? keterangan,
  }) async {
    Map<String, dynamic> data = {
      'id_seleksi': idSeleksi,
      'id_hrd': idHrd,
      'jadwal': jadwal,
      'token': token,
      'id_pelamar': idPelamar,
      'status': status,
      'keterangan': keterangan ,
      'id_loker': idLoker,
    };

    final res = await http.post(
      Uri.parse("${SharedCode.baseUrl}/api/hrd/update-interview/$id"),
      body: data,
    );

    UpadateInterviewModel interview = UpadateInterviewModel.fromJson(
      jsonDecode(res.body),
    );

    if (status == "Diterima") {
      sendPushMessage(
          token, "Selamat lamaran anda sebagai $namaLoker , telah $status");
    } else {
      sendPushMessage(
          token, "Mohon maaf lamaran anda sebagai $namaLoker , telah $status");
    }

    if (res.statusCode == 200) {
      return interview;
    } else {
      throw Exception('Failed to load data');
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
}
