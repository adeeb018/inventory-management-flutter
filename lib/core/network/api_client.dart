import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:inventory_management/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:inventory_management/features/auth/presentation/bloc/auth_event.dart';
import 'package:inventory_management/features/auth/presentation/bloc/auth_state.dart';
import 'package:logger/logger.dart';

import '../auth/auth_service.dart';

class ApiClient {
  final logger = Logger();
  final Dio dio;
  final FlutterSecureStorage secureStorage;
  final AuthService authService = GetIt.I<AuthService>();

  ApiClient(this.dio, this.secureStorage) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        logger.d('[ApiClient] onRequest called for: ${options.path}');

        if (options.extra['skipAuth'] == true) {
          logger.d('[ApiClient] Skipping auth for request: ${options.path}');
          return handler.next(options); // skip adding Authorization header
        }

        final token = await secureStorage.read(key: 'accessToken');
        logger.d('[ApiClient] Access token: $token');

        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
          logger.d('[ApiClient] Added Authorization header to request: ${options.path}');
        }
        return handler.next(options);
      },
      onError: (DioError error, handler) async {
        logger.d('[ApiClient] onError called for: ${error.requestOptions.path}');
        logger.d('[ApiClient] Status code: ${error.response?.statusCode}');
        logger.d('[ApiClient] Error message: ${error.message}');

        // Token expired
        if (error.response?.statusCode == 401) {
          final errorBody = error.response?.data['error'];
          logger.d(errorBody);
          if (errorBody == 'Invalid or expired token') {
            logger.d('[ApiClient] 401 detected. Attempting to refresh token...');
            authService.notify(AuthEventType.tokenExpired);
            try {
              await authService.waitForRefresh(); // 👈 wait for Bloc refresh
              final newToken = await secureStorage.read(key: 'accessToken');

              // Retry with new token
              if (newToken != null) {
                error.requestOptions.headers['Authorization'] = 'Bearer $newToken';
                final retryResponse = await dio.fetch(error.requestOptions);
                return handler.resolve(retryResponse);
              } else {
                logger.d('[ApiClient] Invalid refresh token...');
                authService.notify(AuthEventType.logout);
                return;
              }

            } catch (_) {
              // Refresh failed
              return handler.next(error);
            }
          } else if (errorBody == 'Invalid credentials') {
            logger.d('[ApiClient] Invalid credentials...');
            authService.notify(AuthEventType.invalidCredentials);
            return;
          } else if (errorBody == 'Invalid refresh token') {
            logger.d('[ApiClient] Invalid refresh token...');
            authService.notify(AuthEventType.logout);
            return;
          }

        }

        logger.d('[ApiClient] Passing error to next interceptor/handler');
        return handler.next(error);
      },
    ));
  }
}
