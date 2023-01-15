// To parse this JSON data, do
//
//     final addInterviewModel = addInterviewModelFromJson(jsonString);

import 'dart:convert';

AddInterviewModel? addInterviewModelFromJson(String str) =>
    AddInterviewModel.fromJson(json.decode(str));

String addInterviewModelToJson(AddInterviewModel? data) =>
    json.encode(data!.toJson());

class AddInterviewModel {
  AddInterviewModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  DataAddInterview? data;

  factory AddInterviewModel.fromJson(Map<String, dynamic> json) =>
      AddInterviewModel(
        success: json["success"],
        message: json["message"],
        data: DataAddInterview.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data!.toJson(),
      };
}

class DataAddInterview {
  DataAddInterview({
    this.idSeleksi,
    this.idHrd,
    this.jadwal,
    this.token,
    this.keterangan,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String? idSeleksi;
  String? idHrd;
  String? jadwal;
  dynamic token;
  dynamic keterangan;
  String? status;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  factory DataAddInterview.fromJson(Map<String, dynamic> json) =>
      DataAddInterview(
        idSeleksi: json["id_seleksi"],
        idHrd: json["id_hrd"],
        jadwal: json["jadwal"],
        token: json["token"],
        keterangan: json["keterangan"],
        status: json["status"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id_seleksi": idSeleksi,
        "id_hrd": idHrd,
        "jadwal": jadwal,
        "token": token,
        "keterangan": keterangan,
        "status": status,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
