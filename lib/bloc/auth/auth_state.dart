part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final AuthModel auth;

  AuthSuccess({required this.auth});

  @override
  List<Object> get props => [auth];
}

class AuthSuccessPelamar extends AuthState {
  final AuthPelamarModel authPelamarModel;

  AuthSuccessPelamar({required this.authPelamarModel});

  @override
  List<Object> get props => [authPelamarModel];
}

class AuthSuccessRegister extends AuthState {
  final RegisterPelamarModel registerPelamarModel;

  AuthSuccessRegister({required this.registerPelamarModel});

  @override
  List<Object> get props => [registerPelamarModel];
}

class AuthFailed extends AuthState {
  final String message;

  AuthFailed({required this.message});

  @override
  List<Object> get props => [message];
}
