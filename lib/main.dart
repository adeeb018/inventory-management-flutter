import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_router.dart';
import 'features/auth/domain/usecases/login_user.dart';
import 'features/auth/domain/usecases/logout_user.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    return RepositoryProvider(
      create: (_) => AuthRepositoryImpl(),
      child: BlocProvider(
        create: (ctx) {
          final authRepository = ctx.read<AuthRepositoryImpl>();
          return AuthBloc(
            loginUser: LoginUser(authRepository),
            logoutUser: LogoutUser(),
          );
        },
        child: MaterialApp.router(
          title: 'Projects',
          routerConfig: appRouter.router,
          theme: ThemeData(
            colorSchemeSeed: Colors.blue,
            useMaterial3: true,
          ),
        ),
      ),
    );
  }
}
