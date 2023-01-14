part of 'seleksi_bloc.dart';

abstract class SeleksiState extends Equatable {
  const SeleksiState();

  @override
  List<Object> get props => [];
}

class SeleksiInitial extends SeleksiState {}

class SeleksiLoading extends SeleksiState {}

class SeleksiLoaded extends SeleksiState {
  final DataSeleksi updateSeleksi;

  SeleksiLoaded({required this.updateSeleksi});

  @override
  List<Object> get porps => [updateSeleksi];
}

class SeleksiError extends SeleksiState {
  final String message;

  SeleksiError({required this.message});

  @override
  List<Object> get props => [message];
}
