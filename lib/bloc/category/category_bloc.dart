import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loker/model/get_data_category_model.dart';
import 'package:loker/repositories/category/category_repository.dart';

import '../../model/category_model.dart';
import '../../repositories/auth/auth_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _repository;
  CategoryBloc(this._repository) : super(CategoryInitial()) {
    on<CategoryAddEvent>(
      (event, emit) async {
        emit(CategoryLoading());
        try {
          DataCategory category = await _repository.addCategory(
              namaCategory: event.namaCategory.toString(),
              image: event.imgCategory);
          emit(CategorySuccess(category: category));
        } catch (e) {
          emit(CategoryFailed(message: 'Gagal menambahkan kategori'));
        }
      },
    );

    on<CategoryGetEvent>(
      (event, emit) async {
        emit(CategoryLoading());
        try {
          List<GetDateCategoryModel>? getCategory = await _repository.getCategory();
          emit(CategoryGetSuccess(category: getCategory));
        } catch (e) {
          emit(CategoryFailed(message: 'Gagal mendapatkan kategori'));
        }
      },
    );
  }
}
