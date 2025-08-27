import 'package:dio/dio.dart';
import 'package:inventory_management/core/constants.dart';

abstract class ProjectsRepository {
  Future<List<Map<String, dynamic>>> fetchProjects();
}

class ProjectsRepositoryImpl implements ProjectsRepository {
  final String token;
  final Dio _dio;

  ProjectsRepositoryImpl({required this.token})
      : _dio = Dio(BaseOptions(
    baseUrl: AppConstants.baseUrl,
    headers: {'Authorization': 'Bearer $token'},
  ));

  @override
  Future<List<Map<String, dynamic>>> fetchProjects() async {
    final res = await _dio.get('/projects');
    final data = res.data as List;
    return data.map((e) => Map<String, dynamic>.from(e)).toList();
  }
}
