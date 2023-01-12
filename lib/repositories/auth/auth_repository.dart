import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loker/common/shared_code.dart';
import 'package:loker/model/pelamar_model.dart';
import 'package:loker/repositories/auth/base_auth_repository.dart';
import 'package:http/http.dart' as http;

import '../../model/auth_model.dart';

class Authrepository implements BaseAuthRepository {
  @override
  Future<AuthModel> login(
      {required String email, required String password}) async {
    Map<String, dynamic> data = {'email': email, 'password': password};

    final res = await http
        .post(Uri.parse("${SharedCode.baseUrl}/api/hrd/login"), body: data);

    final auth = authModelFromJson(res.body);

    if (res.statusCode == 200) {
      return auth;
    } else if (res.statusCode == 401) {
      throw Exception('User atau Password Salah');
    } else {
      throw Exception('Gagal Login');
    }
  }

  Future<AuthPelamarModel> loginPelamar(
      {required String email, required String password}) async {
    Map<String, dynamic> data = {'email': email, 'password': password};

    final res = await http
        .post(Uri.parse("${SharedCode.baseUrl}/api/pelamar/login"), body: data);

    final auth = authPelamarModelFromJson(res.body);

    if (res.statusCode == 200) {
      return auth!;
    } else if (res.statusCode == 401) {
      throw Exception('User atau Password Salah');
    } else {
      throw Exception('Gagal Login');
    }
  }

  Future<RegisterPelamarModel> registerPelamar({
    required File cv,
    required String fotoPelamar,
    required String namaPelamar,
    required String emailPelamar,
    required String passwordPelamar,
    required String noHpPelamar,
    required String alamatPelamar,
    required String jenisKelaminPelamar,
  }) async {
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse("${SharedCode.baseUrl}/api/pelamar/register"))
      ..fields.addAll({
        'nama': namaPelamar,
        'img_pelamar': fotoPelamar,
        'email': emailPelamar,
        'password': passwordPelamar,
        'no_hp': noHpPelamar,
        'alamat': alamatPelamar,
        'jenis_kelamin': jenisKelaminPelamar,
      })
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath('cv', cv.path));

    var response = await request.send();
    debugPrint('response ${response.statusCode}');
    debugPrint('fields ${request.fields}');
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);

    RegisterPelamarModel registerPelamar =
        registerPelamarModelFromJson(responseString)!;

    if (response.statusCode == 200) {
      return registerPelamar;
    } else if (response.statusCode == 401) {
      throw Exception('User atau Password Salah');
    } else {
      throw Exception('Gagal Login');
    }
  }
}
