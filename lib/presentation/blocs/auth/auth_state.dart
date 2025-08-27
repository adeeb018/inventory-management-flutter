abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {   // ✅ this class must exist
  final String token;
  AuthAuthenticated(this.token);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthUnauthenticated extends AuthState {}
