import 'package:flutter_bloc/flutter_bloc.dart';
import 'projects_event.dart';
import 'projects_state.dart';
import '../../../domain/repositories/projects_repository.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  final ProjectsRepository repository;

  ProjectsBloc({required this.repository}) : super(ProjectsInitial()) {
    on<FetchProjects>((event, emit) async {
      emit(ProjectsLoading());
      try {
        final projects = await repository.getProjects();
        emit(ProjectsLoaded(projects));
      } catch (e) {
        emit(ProjectsError(e.toString()));
      }
    });
  }
}
