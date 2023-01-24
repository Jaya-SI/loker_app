import 'package:loker/model/get_loker_model.dart';
import 'package:loker/repositories/loker/base_loker_repository.dart';

import '../../common/shared_code.dart';
import '../../model/loker_model.dart';
import 'package:http/http.dart' as http;

import '../../model/seleksi_model.dart';

class LokerRepository extends BaseLokerRepository {
  @override
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
  }) async {
    Map<String, dynamic> data = {
      'id_category': idCategory,
      'id_hrd': idHrd,
      'nama': nama,
      'img_loker': imgLoker,
      'alamat': alamat,
      'tanggal': tanggal,
      'deskripsi1': deskripsi1,
      'deskripsi2': deskripsi2,
      'deskripsi3': deskripsi3,
      'gaji': gaji,
      'status': status,
    };

    final res = await http
        .post(Uri.parse("${SharedCode.baseUrl}/api/hrd/add-loker"), body: data);

    final loker = lokerModelFromJson(res.body);

    if (res.statusCode == 200) {
      return loker.data!;
    } else if (res.statusCode == 500) {
      throw Exception('Data Loker Kosong');
    } else {
      throw Exception('Gagal Menambahkan Loker');
    }
  }

  Future<GetLokerModel> getLoker() async {
    final res =
        await http.get(Uri.parse("${SharedCode.baseUrl}/api/hrd/get-loker"));

    final loker = getLokerModelFromJson(res.body);

    if (res.statusCode == 200) {
      return loker;
    } else {
      throw loker.message ?? 'Gagal Mendapatkan Loker';
    }
  }

  Future<CheckRegisteredLokerMode> checkRegisteredLoker(
      {String? idPelamar, String? idLoker}) async {
    Map<String, dynamic> data = {
      'id_pelamar': idPelamar,
      'id_loker': idLoker,
    };

    final res = await http.post(
        Uri.parse("${SharedCode.baseUrl}/api/pelamar/check-registered"),
        body: data);

    CheckRegisteredLokerMode check =
        checkRegisteredLokerModeFromJson(res.body)!;

    if (res.statusCode == 200) {
      return check;
    } else {
      throw check.message ?? 'Gagal Mendapatkan Loker';
    }
  }

  Future<String> deleteSeleksi({String? id}) async {
    final res = await http.delete(
        Uri.parse("${SharedCode.baseUrl}/api/pelamar/delete-seleksi/$id"));

    String status = res.statusCode.toString();

    if (res.statusCode == 200) {
      return status;
    } else {
      throw status;
    }
  }

  Future<GetLokerModel> getLokeridCategory(String? id) async {
    final res = await http
        .get(Uri.parse("${SharedCode.baseUrl}/api/hrd/get-loker/category/$id"));

    final loker = getLokerModelFromJson(res.body);

    if (res.statusCode == 200) {
      return loker;
    } else {
      throw loker.message ?? 'Gagal Mendapatkan Loker';
    }
  }

  Future<AddSeleksiModel> addSeleksi({
    String? idPelamar,
    String? idLoker,
    String? suratLamaran,
    String? token,
    String? status,
  }) async {
    Map<String, dynamic> data = {
      'id_pelamar': idPelamar,
      'id_loker': idLoker,
      'token': token,
      'surat_lamaran': suratLamaran != "" ? suratLamaran : "-",
      'status': status,
    };
    

    final res = await http.post(
        Uri.parse("${SharedCode.baseUrl}/api/pelamar/add-seleksi"),
        body: data);

    AddSeleksiModel loker = addSeleksiModelFromJson(res.body)!;

    if (res.statusCode == 200) {
      return loker;
    } else if (res.statusCode == 500) {
      throw Exception('Data Loker Kosong');
    } else {
      throw Exception('Gagal Menambahkan Loker');
    }
  }

  Future<GetLokerModel> getLokerOpen() async {
    final res = await http
        .get(Uri.parse("${SharedCode.baseUrl}/api/hrd/get-loker/status/open"));

    final loker = getLokerModelFromJson(res.body);

    if (res.statusCode == 200) {
      return loker;
    } else {
      throw loker.message ?? 'Gagal Mendapatkan Loker';
    }
  }

  Future<DataLoker> deleteLoker({required String idLoker}) async {
    final res = await http
        .post(Uri.parse("${SharedCode.baseUrl}/api/hrd/delete-loker/$idLoker"));

    final loker = lokerModelFromJson(res.body);

    if (res.statusCode == 200) {
      return loker.data!;
    } else {
      throw Exception('Gagal Menghapus Loker');
    }
  }

  Future<DataLoker> updateLoker({
    String? idLoker,
    String? idCategory,
    String? idHrd,
    String? nama,
    String? imgLoker,
    String? alamat,
    String? tanggal,
    String? deskripsi1,
    String? deskripsi2,
    String? deskripsi3,
    String? gaji,
    String? status,
  }) async {
    if (imgLoker != null) {
      Map<String, dynamic> data = {
        'id_category': idCategory,
        'id_hrd': idHrd,
        'nama': nama,
        'img_loker': imgLoker,
        'alamat': alamat,
        'tanggal': tanggal,
        'deskripsi1': deskripsi1,
        'deskripsi2': deskripsi2,
        'deskripsi3': deskripsi3,
        'gaji': gaji,
        'status': status,
      };
      final res = await http.post(
          Uri.parse("${SharedCode.baseUrl}/api/hrd/update-loker/$idLoker"),
          body: data);

      LokerModel loker = lokerModelFromJson(res.body);

      if (res.statusCode == 200) {
        return loker.data!;
      } else {
        throw Exception('Gagal Mengupdate Loker');
      }
    } else {
      Map<String, dynamic> data = {
        'id_category': idCategory,
        'id_hrd': idHrd,
        'nama': nama,
        'alamat': alamat,
        'tanggal': tanggal,
        'deskripsi1': deskripsi1,
        'deskripsi2': deskripsi2,
        'deskripsi3': deskripsi3,
        'gaji': gaji,
        'status': status,
      };
      final res = await http.post(
          Uri.parse("${SharedCode.baseUrl}/api/hrd/update-loker/$idLoker"),
          body: data);

      LokerModel loker = lokerModelFromJson(res.body);

      if (res.statusCode == 200) {
        return loker.data!;
      } else {
        throw Exception('Gagal Mengupdate Loker');
      }
    }
  }
}
