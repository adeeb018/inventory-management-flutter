abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String username;
  final String password;

  LoginRequested({required this.username, required this.password});
}

class LoggedIn extends AuthEvent {
  final String accessToken;
  final String refreshToken;
  LoggedIn(this.accessToken, this.refreshToken);
}

class LogoutRequested extends AuthEvent {}

class InvalidCredentials extends AuthEvent {
  final String error;

  InvalidCredentials(this.error);
}

class RefreshTokenRequested extends AuthEvent {}

class AppStarted extends AuthEvent {}