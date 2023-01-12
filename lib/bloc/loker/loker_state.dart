part of 'loker_bloc.dart';

abstract class LokerState extends Equatable {
  const LokerState();

  @override
  List<Object> get props => [];
}

class LokerInitial extends LokerState {}

class LokerLoading extends LokerState {}

class LokerLoaded extends LokerState {
  final DataLoker lokerModel;

  LokerLoaded({required this.lokerModel});

  @override
  List<Object> get props => [lokerModel];
}

class SeleksiLoaded extends LokerState {
  final AddSeleksiModel seleksiModel;

  SeleksiLoaded({required this.seleksiModel});

  @override
  List<Object> get props => [seleksiModel];
}

class CheckLokerLoaded extends LokerState {
  final CheckRegisteredLokerMode checkLokerModel;

  CheckLokerLoaded({required this.checkLokerModel});

  @override
  List<Object> get props => [checkLokerModel];
}

class LokerGetLoaded extends LokerState {
  final GetLokerModel getLokerModel;

  LokerGetLoaded({required this.getLokerModel});

  @override
  List<Object> get props => [getLokerModel];
}

class LokerError extends LokerState {
  final String message;

  LokerError({required this.message});

  @override
  List<Object> get props => [message];
}
