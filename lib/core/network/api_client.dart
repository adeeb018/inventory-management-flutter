import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:inventory_management/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:inventory_management/features/auth/presentation/bloc/auth_event.dart';
import 'package:inventory_management/features/auth/presentation/bloc/auth_state.dart';
import 'package:logger/logger.dart';

class ApiClient {
  final logger = Logger();
  final Dio dio;
  final FlutterSecureStorage secureStorage;

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
            final refreshToken = await secureStorage.read(key: 'refreshToken');
            logger.d('[ApiClient] Refresh token: $refreshToken');

            if (refreshToken != null) {
              try {
                logger.d('[ApiClient] Calling /auth/refresh API...');
                final response = await dio.post(
                  '/auth/refresh',
                  data: {'refreshToken': refreshToken},
                  options: Options(
                    extra: {'skipAuth': true}, // custom flag
                  ),
                );

                final newAccessToken = response.data['accessToken'];
                logger.d('[ApiClient] New access token received: $newAccessToken');
                await secureStorage.write(key: 'accessToken', value: newAccessToken);

                // Retry the failed request with new token
                error.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
                logger.d('[ApiClient] Retrying original request: ${error.requestOptions.path}');
                final retryResponse = await dio.fetch(error.requestOptions);
                logger.d('[ApiClient] Retry successful for: ${error.requestOptions.path}');
                return handler.resolve(retryResponse);
              } catch (e) {
                logger.d('[ApiClient] Refresh token failed: $e');
                await secureStorage.deleteAll();
                final authBloc = GetIt.I<AuthBloc>();
                authBloc.add(LogoutRequested());
              }
            } else {
              logger.d('[ApiClient] No refresh token found, logging out...');
              await secureStorage.deleteAll();
              final authBloc = GetIt.I<AuthBloc>();
              authBloc.add(LogoutRequested());
            }
          } else if (errorBody == 'Invalid credentials') {
            final authBloc = GetIt.I<AuthBloc>();
            authBloc.add(InvalidCredentials(errorBody));
          }

        }

        logger.d('[ApiClient] Passing error to next interceptor/handler');
        return handler.next(error);
      },
    ));
  }
}
