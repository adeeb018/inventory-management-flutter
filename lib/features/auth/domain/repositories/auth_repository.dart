import '../entities/user_token.dart';

abstract class AuthRepository {
  Future<UserToken> login(String username, String password);
  Future<UserToken> refreshToken(String refreshToken);
  Future<void> logout();
}
