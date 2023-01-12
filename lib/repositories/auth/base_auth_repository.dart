import '../../model/auth_model.dart';

abstract class BaseAuthRepository {
  Future<AuthModel> login({required String email, required String password});
}
