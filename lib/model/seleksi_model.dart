// To parse this JSON data, do
//
//     final addSeleksiModel = addSeleksiModelFromJson(jsonString);

import 'dart:convert';

AddSeleksiModel? addSeleksiModelFromJson(String str) =>
    AddSeleksiModel.fromJson(json.decode(str));

String addSeleksiModelToJson(AddSeleksiModel? data) =>
    json.encode(data!.toJson());

class AddSeleksiModel {
  AddSeleksiModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory AddSeleksiModel.fromJson(Map<String, dynamic> json) =>
      AddSeleksiModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.idPelamar,
    this.idLoker,
    this.suratLamaran,
    this.status,
    this.keterangan,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String? idPelamar;
  String? idLoker;
  String? suratLamaran;
  String? status;
  dynamic keterangan;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idPelamar: json["id_pelamar"],
        idLoker: json["id_loker"],
        suratLamaran: json["surat_lamaran"],
        status: json["status"],
        keterangan: json["keterangan"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id_pelamar": idPelamar,
        "id_loker": idLoker,
        "surat_lamaran": suratLamaran,
        "status": status,
        "keterangan": keterangan,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}

// To parse this JSON data, do
//
//     final checkRegisteredLokerMode = checkRegisteredLokerModeFromJson(jsonString);

CheckRegisteredLokerMode? checkRegisteredLokerModeFromJson(String str) =>
    CheckRegisteredLokerMode.fromJson(json.decode(str));

String checkRegisteredLokerModeToJson(CheckRegisteredLokerMode? data) =>
    json.encode(data!.toJson());

class CheckRegisteredLokerMode {
  CheckRegisteredLokerMode({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory CheckRegisteredLokerMode.fromJson(Map<String, dynamic> json) =>
      CheckRegisteredLokerMode(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data!.toJson(),
      };
}

class DataCheck {
  DataCheck({
    this.id,
    this.idPelamar,
    this.idLoker,
    this.suratLamaran,
    this.status,
    this.keterangan,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? idPelamar;
  String? idLoker;
  String? suratLamaran;
  String? status;
  dynamic keterangan;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory DataCheck.fromJson(Map<String, dynamic> json) => DataCheck(
        id: json["id"],
        idPelamar: json["id_pelamar"],
        idLoker: json["id_loker"],
        suratLamaran: json["surat_lamaran"],
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
        "status": status,
        "keterangan": keterangan,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
