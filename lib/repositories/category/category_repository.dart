import 'package:loker/model/get_data_category_model.dart';

import '../../common/shared_code.dart';
import '../../model/category_model.dart';
import 'base_category_repository.dart';
import 'package:http/http.dart' as http;

class CategoryRepository extends BaseCategoryRepository {
  @override
  Future<DataCategory> addCategory(
      {required String namaCategory, required String image}) async {
    Map<String, dynamic> data = {
      'nama_category': namaCategory,
      'img_category': image
    };

    final res = await http.post(
        Uri.parse("${SharedCode.baseUrl}/api/hrd/add-category"),
        body: data);

    final category = categoryModelFromJson(res.body);

    if (res.statusCode == 200) {
      return category.data!;
    } else if (res.statusCode == 500) {
      throw Exception('Data Category Kosong');
    } else {
      throw Exception('Gagal Menambahkan Category');
    }
  }

  Future<List<GetDateCategoryModel>?> getCategory() async {
    final res =
        await http.get(Uri.parse("${SharedCode.baseUrl}/api/hrd/get-category"));

    List<GetDateCategoryModel> category = getDateCategoryModelFromJson(res.body);

    if (res.statusCode == 200) {
      return category;
    } else {
      throw 'Gagal Mendapatkan Category';
    }
  }
}
