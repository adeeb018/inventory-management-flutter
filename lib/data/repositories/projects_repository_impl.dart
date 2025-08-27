import '../../domain/repositories/projects_repository.dart';
import '../api_client.dart';

class ProjectsRepositoryImpl implements ProjectsRepository {
  final ApiClient apiClient;

  ProjectsRepositoryImpl({required String token})
      : apiClient = ApiClient(token: token);

  @override
  Future<List<Map<String, dynamic>>> getProjects() async {
    final response = await apiClient.dio.get('/projects');
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(response.data);
    }
    return [];
  }
}
