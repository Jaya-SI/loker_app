import 'package:loker/repositories/interview/base_interview_repository.dart';

import '../../common/shared_code.dart';
import 'package:http/http.dart' as http;

import '../../model/update_interview_model.dart';

class InterviewRepository extends BaseInterviewRepository {
  @override
  Future<DataInterviewModel> updateInterview({
    String? idSeleksi,
    String? idHrd,
    String? jadwal,
    String? token,
    String? idPelamar,
    String? status,
  }) async {
    Map<String, dynamic> data = {
      'id_seleksi': idSeleksi,
      'id_hrd': idHrd,
      'jadwal': jadwal,
      'token': token,
      'id_pelamar': idPelamar,
      'status': status,
    };

    final res = await http.post(
      Uri.parse("${SharedCode.baseUrl}/api/hrd/update-interview/$idSeleksi"),
      body: data,
    );

    final interview = upadateInterviewModelFromJson(res.body);

    if (res.statusCode == 200) {
      return interview!.data!;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
