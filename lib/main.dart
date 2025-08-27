import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_router.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'data/repositories/auth_repository_impl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _router = AppRouter().router;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(authRepository: AuthRepositoryImpl()),
      child: MaterialApp.router(
        title: 'Inventory Web App',
        routerConfig: _router,
        theme: ThemeData(primarySwatch: Colors.blue),
      ),
    );
  }
}
