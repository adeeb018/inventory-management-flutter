import 'package:inventory_management/features/auth/domain/entities/user_token.dart';

import '../repositories/auth_repository.dart';

class RefreshToken {
  final AuthRepository repository;

  RefreshToken(this.repository);

  Future<UserToken> call(String refreshToken) {
    return repository.refreshToken(refreshToken);
  }
}
