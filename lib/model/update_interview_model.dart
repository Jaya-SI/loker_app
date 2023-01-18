// To parse this JSON data, do
//
//     final upadateInterviewModel = upadateInterviewModelFromJson(jsonString);

import 'dart:convert';

UpadateInterviewModel? upadateInterviewModelFromJson(String str) => UpadateInterviewModel.fromJson(json.decode(str));

String upadateInterviewModelToJson(UpadateInterviewModel? data) => json.encode(data!.toJson());

class UpadateInterviewModel {
    UpadateInterviewModel({
        this.success,
        this.message,
        this.data,
    });

    bool? success;
    String? message;
    DataInterviewModel? data;

    factory UpadateInterviewModel.fromJson(Map<String, dynamic> json) => UpadateInterviewModel(
        success: json["success"],
        message: json["message"],
        data: DataInterviewModel.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data!.toJson(),
    };
}

class DataInterviewModel {
    DataInterviewModel({
        this.id,
        this.idSeleksi,
        this.idHrd,
        this.idPelamar,
        this.jadwal,
        this.token,
        this.keterangan,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? idSeleksi;
    String? idHrd;
    String? idPelamar;
    String? jadwal;
    dynamic token;
    dynamic keterangan;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory DataInterviewModel.fromJson(Map<String, dynamic> json) => DataInterviewModel(
        id: json["id"],
        idSeleksi: json["id_seleksi"],
        idHrd: json["id_hrd"],
        idPelamar: json["id_pelamar"],
        jadwal: json["jadwal"],
        token: json["token"],
        keterangan: json["keterangan"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_seleksi": idSeleksi,
        "id_hrd": idHrd,
        "id_pelamar": idPelamar,
        "jadwal": jadwal,
        "token": token,
        "keterangan": keterangan,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
