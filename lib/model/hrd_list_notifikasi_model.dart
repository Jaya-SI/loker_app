// To parse this JSON data, do
//
//     final hrdGetListNotifikasiModel = hrdGetListNotifikasiModelFromJson(jsonString);

import 'dart:convert';

HrdGetListNotifikasiModel? hrdGetListNotifikasiModelFromJson(String str) => HrdGetListNotifikasiModel.fromJson(json.decode(str));

String hrdGetListNotifikasiModelToJson(HrdGetListNotifikasiModel? data) => json.encode(data!.toJson());

class HrdGetListNotifikasiModel {
    HrdGetListNotifikasiModel({
        this.success,
        this.message,
        this.data,
    });

    bool? success;
    String? message;
    List<Datum?>? data;

    factory HrdGetListNotifikasiModel.fromJson(Map<String, dynamic> json) => HrdGetListNotifikasiModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum?>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
    };
}

class Datum {
    Datum({
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
    IdPelamar? idPelamar;
    IdLoker? idLoker;
    String? suratLamaran;
    String? status;
    dynamic keterangan;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idPelamar: IdPelamar.fromJson(json["id_pelamar"]),
        idLoker: IdLoker.fromJson(json["id_loker"]),
        suratLamaran: json["surat_lamaran"],
        status: json["status"],
        keterangan: json["keterangan"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_pelamar": idPelamar!.toJson(),
        "id_loker": idLoker!.toJson(),
        "surat_lamaran": suratLamaran,
        "status": status,
        "keterangan": keterangan,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class IdLoker {
    IdLoker({
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
    String? idCategory;
    String? idHrd;
    String? nama;
    String? imgLoker;
    String? alamat;
    DateTime? tanggal;
    String? deskripsi1;
    String? deskripsi2;
    String? deskripsi3;
    String? gaji;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory IdLoker.fromJson(Map<String, dynamic> json) => IdLoker(
        id: json["id"],
        idCategory: json["id_category"],
        idHrd: json["id_hrd"],
        nama: json["nama"],
        imgLoker: json["img_loker"],
        alamat: json["alamat"],
        tanggal: DateTime.parse(json["tanggal"]),
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
        "id_category": idCategory,
        "id_hrd": idHrd,
        "nama": nama,
        "img_loker": imgLoker,
        "alamat": alamat,
        "tanggal": tanggal?.toIso8601String(),
        "deskripsi1": deskripsi1,
        "deskripsi2": deskripsi2,
        "deskripsi3": deskripsi3,
        "gaji": gaji,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class IdPelamar {
    IdPelamar({
        this.id,
        this.nama,
        this.imgPelamar,
        this.email,
        this.password,
        this.alamat,
        this.noHp,
        this.jenisKelamin,
        this.role,
        this.token,
        this.cv,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? nama;
    String? imgPelamar;
    String? email;
    String? password;
    String? alamat;
    String? noHp;
    String? jenisKelamin;
    String? role;
    dynamic token;
    String? cv;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory IdPelamar.fromJson(Map<String, dynamic> json) => IdPelamar(
        id: json["id"],
        nama: json["nama"],
        imgPelamar: json["img_pelamar"],
        email: json["email"],
        password: json["password"],
        alamat: json["alamat"],
        noHp: json["no_hp"],
        jenisKelamin: json["jenis_kelamin"],
        role: json["role"],
        token: json["token"],
        cv: json["cv"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "img_pelamar": imgPelamar,
        "email": email,
        "password": password,
        "alamat": alamat,
        "no_hp": noHp,
        "jenis_kelamin": jenisKelamin,
        "role": role,
        "token": token,
        "cv": cv,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
