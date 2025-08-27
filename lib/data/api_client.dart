import 'package:dio/dio.dart';
import '../core/constants.dart'; 

class ApiClient {
  final Dio dio;

  ApiClient({String? token})
      : dio = Dio(
          BaseOptions(
            baseUrl: AppConstants.baseUrl,
            headers: token != null ? {'Authorization': 'Bearer $token'} : {},
          ),
        );
}
