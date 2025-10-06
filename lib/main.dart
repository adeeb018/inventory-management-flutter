import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventory_management/core/constants.dart';
import 'package:inventory_management/core/network/api_client.dart';
import 'package:inventory_management/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:inventory_management/features/auth/domain/usecases/login_user.dart';
import 'package:inventory_management/features/auth/domain/usecases/logout_user.dart';
import 'package:inventory_management/features/auth/domain/usecases/refresh_token.dart';
import 'package:inventory_management/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:inventory_management/features/auth/presentation/bloc/auth_event.dart';
import 'app_router.dart';
import 'injection.dart';
import 'shared/presentation/bloc/bloc_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();

    // Single Dio + ApiClient instance
    final dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));
    const secureStorage = FlutterSecureStorage();
    final apiClient = ApiClient(dio, secureStorage);

    // Auth Repository uses apiClient
    final authRepository = AuthRepositoryImpl(apiClient: apiClient);

    return RepositoryProvider.value(
      value: apiClient,
      child: BlocProvider(
        create: (ctx) => AuthBloc(
          loginUser: LoginUser(authRepository),
          logoutUser: LogoutUser(authRepository),
          refreshTokenUseCase: RefreshToken(authRepository),
          secureStorage: secureStorage,
        )..add(AppStarted()),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Projects',
          routerConfig: appRouter.router,
          // theme: ThemeData(
          //   colorSchemeSeed: Colors.blue,
          //   useMaterial3: true,
          // ),
          theme: ThemeData(
            textTheme: GoogleFonts.interTextTheme(
              Theme.of(context).textTheme,
            ),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
        ),
      ),
    );
  }
}
