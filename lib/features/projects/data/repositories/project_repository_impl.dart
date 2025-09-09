import 'package:inventory_management/core/constants.dart';

import '../../../../core/network/api_client.dart';

abstract class ProjectsRepository {
  Future<List<Map<String, dynamic>>> fetchProjects();
}

class ProjectsRepositoryImpl implements ProjectsRepository {
  final ApiClient apiClient;

  ProjectsRepositoryImpl({required this.apiClient});

  @override
  Future<List<Map<String, dynamic>>> fetchProjects() async {
    final res = await apiClient.dio.get(AppConstants.getProjectsUrl);
    final data = res.data as List;
    return data.map((e) => Map<String, dynamic>.from(e)).toList();
  }
}
