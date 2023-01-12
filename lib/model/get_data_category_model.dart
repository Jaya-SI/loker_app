// To parse this JSON data, do
//
//     final getDateCategoryModel = getDateCategoryModelFromJson(jsonString);

import 'dart:convert';

List<GetDateCategoryModel> getDateCategoryModelFromJson(String str) => List<GetDateCategoryModel>.from(json.decode(str).map((x) => GetDateCategoryModel.fromJson(x)));

String getDateCategoryModelToJson(List<GetDateCategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetDateCategoryModel {
    GetDateCategoryModel({
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

    factory GetDateCategoryModel.fromJson(Map<String, dynamic> json) => GetDateCategoryModel(
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
