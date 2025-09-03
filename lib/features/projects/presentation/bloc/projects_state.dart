import '../../domain/entities/project.dart';

abstract class ProjectsState {}

class ProjectsInitial extends ProjectsState {}

class ProjectsLoading extends ProjectsState {}

class ProjectsLoaded extends ProjectsState {
  final List<ProjectEntity> projects;
  ProjectsLoaded(this.projects);
}

class ProjectsError extends ProjectsState {
  final String message;
  ProjectsError(this.message);
}
