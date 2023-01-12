part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginAuthEvent extends AuthEvent {
  final String email;
  final String password;

  LoginAuthEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LoginAuthPelamarEvent extends AuthEvent {
  final String email;
  final String password;

  LoginAuthPelamarEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
} 
