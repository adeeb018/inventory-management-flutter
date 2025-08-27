import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/logout_user.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;
  final LogoutUser logoutUser;
  String? token;

  AuthBloc({required this.loginUser, required this.logoutUser}) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final userToken = await loginUser(event.username, event.password);
        token = userToken.token;
        emit(AuthAuthenticated(token!));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<LogoutRequested>((event, emit) async {
      await logoutUser();
      token = null;
      emit(AuthUnauthenticated());
    });
  }
}
