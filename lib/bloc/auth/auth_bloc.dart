import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loker/model/auth_model.dart';
import 'package:loker/model/pelamar_model.dart';
import 'package:loker/repositories/auth/auth_repository.dart';
import 'package:loker/services/shared_preferences_services.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Authrepository _repository;
  AuthBloc(this._repository) : super(AuthInitial()) {
    on<LoginAuthEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        AuthModel auth = await _repository.login(
            email: event.email, password: event.password);
        await SharedPreferencesService.setAuthModel(auth);
        emit(AuthSuccess(auth: auth));
      } catch (e) {
        emit(AuthFailed(message: 'Email atau Password salah'));
      }
    });

    on<LoginAuthPelamarEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        AuthPelamarModel auth = await _repository.loginPelamar(
            email: event.email, password: event.password);
        await SharedPreferencesService.setAuthPelamarModel(auth);
        emit(AuthSuccessPelamar(authPelamarModel: auth));
      } catch (e) {
        emit(AuthFailed(message: 'Email atau Password salah'));
      }
    });
  }
}
