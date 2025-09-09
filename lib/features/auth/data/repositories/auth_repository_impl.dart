import 'dart:developer';

import 'package:inventory_management/core/constants.dart';
import 'package:inventory_management/core/network/api_client.dart';
import 'package:inventory_management/features/auth/domain/entities/user_token.dart';
import 'package:logger/logger.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient apiClient;

  AuthRepositoryImpl({required this.apiClient});

  @override
  Future<UserToken> login(String username, String password) async {
    try {
      final res = await apiClient.dio.post(AppConstants.loginUrl, data: {
        'username': username,
        'password': password,
      });
      return UserToken(
        accessToken: res.data['accessToken'],
        refreshToken: res.data['refreshToken'],
      );
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    // If backend has logout API, call it here
    // await apiClient.dio.post('/auth/logout');
    return;
  }

  @override
  Future<UserToken> refreshToken(String refreshToken) async {
    try {
      log("INSIDE REFRESH TOKEN IMPL");

      final response =
          await apiClient.dio.post(AppConstants.refreshTokenUrl, data: {
        'refreshToken': refreshToken,
      });

      return UserToken(
        accessToken: response.data['accessToken'],
        refreshToken: refreshToken, // keep the same refresh token
      );
    } catch (e) {
      throw Exception('Refresh token failed: $e');
    }
  }
}
