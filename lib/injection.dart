import 'package:get_it/get_it.dart';
import 'core/auth/auth_service.dart';

final sl = GetIt.instance;

void setupDependencies() {
  sl.registerLazySingleton<AuthService>(() => AuthService());

  // You can also register Dio, ApiClient, repositories here
}
