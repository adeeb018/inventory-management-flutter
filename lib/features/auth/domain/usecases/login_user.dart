import '../entities/user_token.dart';
import '../repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<UserToken> call(String username, String password) {
    return repository.login(username, password);
  }
}
