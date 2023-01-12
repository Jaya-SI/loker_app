// To parse this JSON data, do
//
//     final lokerModel = lokerModelFromJson(jsonString);

import 'dart:convert';

LokerModel lokerModelFromJson(String str) => LokerModel.fromJson(json.decode(str));

String lokerModelToJson(LokerModel data) => json.encode(data.toJson());

class LokerModel {
    LokerModel({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    DataLoker? data;

    factory LokerModel.fromJson(Map<String, dynamic> json) => LokerModel(
        status: json["status"],
        message: json["message"],
        data: DataLoker.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class DataLoker {
    DataLoker({
        this.idCategory,
        this.idHrd,
        this.nama,
        this.imgLoker,
        this.alamat,
        this.tanggal,
        this.deskripsi1,
        this.deskripsi2,
        this.deskripsi3,
        this.gaji,
        this.status,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    String? idCategory;
    String? idHrd;
    String? nama;
    String? imgLoker;
    String? alamat;
    String? tanggal;
    String? deskripsi1;
    String? deskripsi2;
    String? deskripsi3;
    String? gaji;
    String? status;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    factory DataLoker.fromJson(Map<String, dynamic> json) => DataLoker(
        idCategory: json["id_category"],
        idHrd: json["id_hrd"],
        nama: json["nama"],
        imgLoker: json["img_loker"],
        alamat: json["alamat"],
        tanggal: json["tanggal"],
        deskripsi1: json["deskripsi1"],
        deskripsi2: json["deskripsi2"],
        deskripsi3: json["deskripsi3"],
        gaji: json["gaji"],
        status: json["status"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id_category": idCategory,
        "id_hrd": idHrd,
        "nama": nama,
        "img_loker": imgLoker,
        "alamat": alamat,
        "tanggal": tanggal,
        "deskripsi1": deskripsi1,
        "deskripsi2": deskripsi2,
        "deskripsi3": deskripsi3,
        "gaji": gaji,
        "status": status,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}
