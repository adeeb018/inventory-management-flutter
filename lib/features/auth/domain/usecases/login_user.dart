import '../../data/repositories/auth_repository_impl.dart';
import '../entities/user_token.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<UserToken> call(String username, String password) async {
    final tokenStr = await repository.login(username, password);
    if (tokenStr != null) {
      return UserToken(tokenStr);
    } else {
      throw Exception('Invalid credentials');
    }
  }
}
