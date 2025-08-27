  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'auth_event.dart';
  import 'auth_state.dart';
  import '../../../domain/repositories/auth_repository.dart';

  class AuthBloc extends Bloc<AuthEvent, AuthState> {
    final AuthRepository authRepository;
    String? token;

    AuthBloc({required this.authRepository}) : super(AuthInitial()) {
      on<LoginRequested>((event, emit) async {
        emit(AuthLoading());
        try {
          final result = await authRepository.login(event.username, event.password);
          if (result != null) {
            token = result.token;
            emit(AuthAuthenticated(token!));
          } else {
            emit(AuthError("Invalid credentials"));
          }
        } catch (e) {
          emit(AuthError(e.toString()));
        }
      });

      on<LogoutRequested>((event, emit) {
        token = null;
        emit(AuthUnauthenticated());
      });
    }
  }
