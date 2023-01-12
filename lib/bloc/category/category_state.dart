part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategorySuccess extends CategoryState {
  final DataCategory category;

  CategorySuccess({required this.category});

  @override
  List<Object> get props => [category];
}

class CategoryGetSuccess extends CategoryState {
  final List<GetDateCategoryModel>? category;

  CategoryGetSuccess({required this.category});

  @override
  List<Object> get props => [category!];
}

class CategoryFailed extends CategoryState {
  final String message;

  CategoryFailed({required this.message});

  @override
  List<Object> get props => [message];
}
