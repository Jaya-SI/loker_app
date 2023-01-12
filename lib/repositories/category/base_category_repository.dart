import '../../model/category_model.dart';

abstract class BaseCategoryRepository {
  Future<DataCategory> addCategory(
      {required String namaCategory, required String image});
}
