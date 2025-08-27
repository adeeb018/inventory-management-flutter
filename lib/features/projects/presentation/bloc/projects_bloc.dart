import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_projects.dart';
import 'projects_event.dart';
import 'projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  final GetProjects getProjects;

  ProjectsBloc({required this.getProjects}) : super(ProjectsInitial()) {
    on<FetchProjects>((event, emit) async {
      emit(ProjectsLoading());
      try {
        final projects = await getProjects();
        emit(ProjectsLoaded(projects));
      } catch (e) {
        emit(ProjectsError(e.toString()));
      }
    });
  }
}
