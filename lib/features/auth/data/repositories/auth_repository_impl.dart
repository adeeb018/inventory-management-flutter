import 'package:dio/dio.dart';
import 'package:inventory_management/core/constants.dart';

abstract class AuthRepository {
  Future<String?> login(String username, String password);
}

class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));

  @override
  Future<String?> login(String username, String password) async {
    try {
      final res = await _dio.post('/auth/login', data: {
        'username': username,
        'password': password,
      });
      return res.data['token'];
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }
}
