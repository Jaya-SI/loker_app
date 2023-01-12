// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
    CategoryModel({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    DataCategory? data;

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        status: json["status"],
        message: json["message"],
        data: DataCategory.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class DataCategory {
    DataCategory({
        this.namaCategory,
        this.imgCategory,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    String? namaCategory;
    String? imgCategory;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    factory DataCategory.fromJson(Map<String, dynamic> json) => DataCategory(
        namaCategory: json["nama_category"],
        imgCategory: json["img_category"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "nama_category": namaCategory,
        "img_category": imgCategory,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}
