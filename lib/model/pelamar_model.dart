// To parse this JSON data, do
//
//     final registerPelamarModel = registerPelamarModelFromJson(jsonString);

import 'dart:convert';

RegisterPelamarModel? registerPelamarModelFromJson(String str) => RegisterPelamarModel.fromJson(json.decode(str));

String registerPelamarModelToJson(RegisterPelamarModel? data) => json.encode(data!.toJson());

class RegisterPelamarModel {
    RegisterPelamarModel({
        this.success,
        this.message,
        this.data,
        this.token,
    });

    bool? success;
    String? message;
    Data? data;
    String? token;

    factory RegisterPelamarModel.fromJson(Map<String, dynamic> json) => RegisterPelamarModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data!.toJson(),
        "token": token,
    };
}

class Data {
    Data({
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
        this.updatedAt,
        this.createdAt,
        this.id,
    });

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
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
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
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}

// To parse this JSON data, do
//
//     final authPelamarModel = authPelamarModelFromJson(jsonString);

AuthPelamarModel? authPelamarModelFromJson(String str) => AuthPelamarModel.fromJson(json.decode(str));

String authPelamarModelToJson(AuthPelamarModel? data) => json.encode(data!.toJson());

class AuthPelamarModel {
    AuthPelamarModel({
        this.success,
        this.pelamar,
        this.token,
    });

    bool? success;
    Pelamar? pelamar;
    String? token;

    factory AuthPelamarModel.fromJson(Map<String, dynamic> json) => AuthPelamarModel(
        success: json["success"],
        pelamar: Pelamar.fromJson(json["pelamar"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "pelamar": pelamar!.toJson(),
        "token": token,
    };
}

class Pelamar {
    Pelamar({
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

    factory Pelamar.fromJson(Map<String, dynamic> json) => Pelamar(
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

