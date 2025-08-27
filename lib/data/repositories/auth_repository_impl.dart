import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../api_client.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient apiClient = ApiClient();

  @override
  Future<User?> login(String username, String password) async {
    try {
      final response = await apiClient.dio.post('/auth/login', data: {
        'username': username,
        'password': password,
      });
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    }
    return null;
  }
}
