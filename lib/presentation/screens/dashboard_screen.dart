import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart';
import '../blocs/projects/projects_bloc.dart';
import '../blocs/projects/projects_event.dart';
import '../blocs/projects/projects_state.dart';
import '../../data/repositories/projects_repository_impl.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final token = context.read<AuthBloc>().token!;
    final projectsRepository = ProjectsRepositoryImpl(token: token);

    return BlocProvider(
      create: (_) =>
      ProjectsBloc(repository: projectsRepository)..add(FetchProjects()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            context.go('/login');
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Projects Dashboard'),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  context.read<AuthBloc>().add(LogoutRequested());
                },
              ),
            ],
          ),
          body: BlocBuilder<ProjectsBloc, ProjectsState>(
            builder: (context, state) {
              if (state is ProjectsLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is ProjectsError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              if (state is ProjectsLoaded) {
                return ListView.builder(
                  itemCount: state.projects.length,
                  itemBuilder: (context, index) {
                    final project = state.projects[index];
                    return ListTile(
                      title: Text(project['name'] ?? 'No name'),
                      subtitle: Text('ID: ${project['project_id']}'),
                    );
                  },
                );
              }
              return Center(child: Text('No Projects'));
            },
          ),
        ),
      ),
    );
  }
}
