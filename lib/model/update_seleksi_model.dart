// To parse this JSON data, do
//
//     final updateSeleksiModel = updateSeleksiModelFromJson(jsonString);

import 'dart:convert';

UpdateSeleksiModel? updateSeleksiModelFromJson(String str) =>
    UpdateSeleksiModel.fromJson(json.decode(str));

String updateSeleksiModelToJson(UpdateSeleksiModel? data) =>
    json.encode(data!.toJson());

class UpdateSeleksiModel {
  UpdateSeleksiModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  DataSeleksi? data;

  factory UpdateSeleksiModel.fromJson(Map<String, dynamic> json) =>
      UpdateSeleksiModel(
        success: json["success"],
        message: json["message"],
        data: DataSeleksi.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data!.toJson(),
      };
}

class DataSeleksi {
  DataSeleksi({
    this.id,
    this.idPelamar,
    this.idLoker,
    this.suratLamaran,
    this.token,
    this.status,
    this.keterangan,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? idPelamar;
  String? idLoker;
  dynamic suratLamaran;
  String? token;
  String? status;
  dynamic keterangan;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory DataSeleksi.fromJson(Map<String, dynamic> json) => DataSeleksi(
        id: json["id"],
        idPelamar: json["id_pelamar"],
        idLoker: json["id_loker"],
        suratLamaran: json["surat_lamaran"],
        token: json["token"],
        status: json["status"],
        keterangan: json["keterangan"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_pelamar": idPelamar,
        "id_loker": idLoker,
        "surat_lamaran": suratLamaran,
        "token": token,
        "status": status,
        "keterangan": keterangan,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
