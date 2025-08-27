import '../entities/project.dart';
import '../../data/repositories/project_repository_impl.dart';

class GetProjects {
  final ProjectsRepository repository;

  GetProjects(this.repository);

  Future<List<ProjectEntity>> call() async {
    final rawProjects = await repository.fetchProjects();
    return rawProjects
        .map((e) => ProjectEntity(
      id: e['project_id'] ?? e['id'],
      name: e['name'] ?? 'Unnamed',
    ))
        .toList();
  }
}
