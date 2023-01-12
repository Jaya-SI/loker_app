class DropdownCategory {
  int? id;
  String? nama_category;
  String? img_category;

  DropdownCategory({this.id, this.nama_category, this.img_category});

  factory DropdownCategory.fromJson(Map<String, dynamic> json) {
    return DropdownCategory(
      id: json['id'],
      nama_category: json['nama_category'],
      img_category: json['img_category'],
    );
  }
}
