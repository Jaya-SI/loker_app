// To parse this JSON data, do
//
//     final getLokerModel = getLokerModelFromJson(jsonString);

import 'dart:convert';

GetLokerModel getLokerModelFromJson(String str) => GetLokerModel.fromJson(json.decode(str));

String getLokerModelToJson(GetLokerModel data) => json.encode(data.toJson());

class GetLokerModel {
    GetLokerModel({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    List<DataGetLoker>? data;

    factory GetLokerModel.fromJson(Map<String, dynamic> json) => GetLokerModel(
        status: json["status"],
        message: json["message"],
        data: List<DataGetLoker>.from(json["data"].map((x) => DataGetLoker.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class DataGetLoker {
    DataGetLoker({
        this.id,
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
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    IdCategory? idCategory;
    IdHrd? idHrd;
    String? nama;
    String? imgLoker;
    String? alamat;
    String? tanggal;
    String? deskripsi1;
    String? deskripsi2;
    String? deskripsi3;
    String? gaji;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory DataGetLoker.fromJson(Map<String, dynamic> json) => DataGetLoker(
        id: json["id"],
        idCategory: IdCategory.fromJson(json["id_category"]),
        idHrd: IdHrd.fromJson(json["id_hrd"]),
        nama: json["nama"],
        imgLoker: json["img_loker"],
        alamat: json["alamat"],
        tanggal: json["tanggal"],
        deskripsi1: json["deskripsi1"],
        deskripsi2: json["deskripsi2"],
        deskripsi3: json["deskripsi3"],
        gaji: json["gaji"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_category": idCategory?.toJson(),
        "id_hrd": idHrd?.toJson(),
        "nama": nama,
        "img_loker": imgLoker,
        "alamat": alamat,
        "tanggal": tanggal,
        "deskripsi1": deskripsi1,
        "deskripsi2": deskripsi2,
        "deskripsi3": deskripsi3,
        "gaji": gaji,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class IdCategory {
    IdCategory({
        this.id,
        this.namaCategory,
        this.imgCategory,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? namaCategory;
    String? imgCategory;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory IdCategory.fromJson(Map<String, dynamic> json) => IdCategory(
        id: json["id"],
        namaCategory: json["nama_category"],
        imgCategory: json["img_category"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_category": namaCategory,
        "img_category": imgCategory,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class IdHrd {
    IdHrd({
        this.id,
        this.nama,
        this.imgHrd,
        this.email,
        this.role,
        this.password,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? nama;
    dynamic imgHrd;
    String? email;
    String? role;
    String? password;
    dynamic createdAt;
    dynamic updatedAt;

    factory IdHrd.fromJson(Map<String, dynamic> json) => IdHrd(
        id: json["id"],
        nama: json["nama"],
        imgHrd: json["img_hrd"],
        email: json["email"],
        role: json["role"],
        password: json["password"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "img_hrd": imgHrd,
        "email": email,
        "role": role,
        "password": password,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
