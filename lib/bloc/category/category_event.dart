part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class CategoryAddEvent extends CategoryEvent {
  final String namaCategory;
  final String imgCategory;

  CategoryAddEvent({required this.namaCategory, required this.imgCategory});

  @override
  List<Object> get props => [namaCategory, imgCategory];
}

class CategoryGetEvent extends CategoryEvent {
  @override
  List<Object> get props => [];
}
