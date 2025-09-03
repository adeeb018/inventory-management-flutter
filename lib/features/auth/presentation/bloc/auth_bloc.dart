import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:inventory_management/features/auth/domain/entities/user_token.dart';
import 'package:inventory_management/features/auth/domain/usecases/refresh_token.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../../../core/auth/auth_service.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/logout_user.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;
  final LogoutUser logoutUser;
  final RefreshToken refreshTokenUseCase;
  String? accessToken;
  String? refreshToken;
  final FlutterSecureStorage secureStorage;
  final AuthService authService = GetIt.I<AuthService>();
  late final StreamSubscription _authSub;

  AuthBloc(
      {required this.loginUser,
      required this.logoutUser,
      required this.secureStorage,
      required this.refreshTokenUseCase})
      : super(AuthInitial()) {
    // 🔹 Listen to AuthService
    _authSub = authService.stream.listen((event) {
      if (event == AuthEventType.logout) {
        add(LogoutRequested());
      } else if (event == AuthEventType.tokenExpired) {
        add(RefreshTokenRequested());
      } else if (event == AuthEventType.invalidCredentials) {
        add(InvalidCredentials("Invalid Credentials"));
      }
    });

    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final userToken = await loginUser(event.username, event.password);
        accessToken = userToken.accessToken;
        refreshToken = userToken.refreshToken;
        // save securely
        // await secureStorage.write(key: 'auth_token', value: token);
        await secureStorage.write(key: 'accessToken', value: accessToken);
        await secureStorage.write(key: 'refreshToken', value: refreshToken);
        emit(AuthAuthenticated(accessToken!));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<LogoutRequested>((event, emit) async {
      await logoutUser();
      accessToken = null;
      refreshToken = null;

      // clear secure storage
      await secureStorage.delete(key: 'accessToken');
      await secureStorage.delete(key: 'refreshToken');
      emit(AuthUnauthenticated());
    });

    // Handle App Start (Check if token exists in secure storage)
    on<AppStarted>((event, emit) async {
      emit(AuthLoading());
      final accessToken = await secureStorage.read(key: 'accessToken');
      final refreshToken = await secureStorage.read(key: 'refreshToken');

      if (accessToken != null && !JwtDecoder.isExpired(accessToken)) {
        emit(AuthAuthenticated(accessToken));
      } else if (refreshToken != null) {
        add(RefreshTokenRequested());
      } else {
        emit(AuthUnauthenticated());
      }
    });

    on<RefreshTokenRequested>((event, emit) async {
      // on refresh token request we don't need old access token so delete it.
      await secureStorage.delete(key: 'accessToken');
      final refreshToken = await secureStorage.read(key: 'refreshToken');
      if (refreshToken == null) {
        authService.notifyRefreshFailure();
        emit(AuthUnauthenticated());
        return;
      }

      try {
        final newTokens = await refreshTokenUseCase(refreshToken);
        await secureStorage.write(
            key: 'accessToken', value: newTokens.accessToken);
        await secureStorage.write(
            key: 'refreshToken', value: newTokens.refreshToken);

        authService.notifyRefreshSuccess(); // 👈 tell ApiClient refresh is done

        emit(AuthAuthenticated(newTokens.accessToken));
      } catch (_) {
        authService.notifyRefreshFailure(); // 👈 fail waiting requests
        emit(AuthUnauthenticated());
      }
    });

    on<InvalidCredentials>((event, emit) {
      emit(AuthError(event.error));
    });
  }

  @override
  Future<void> close() {
    _authSub.cancel();
    return super.close();
  }
}
