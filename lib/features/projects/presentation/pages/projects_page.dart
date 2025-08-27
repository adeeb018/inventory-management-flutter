import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';

import '../../data/repositories/project_repository_impl.dart';
import '../../domain/usecases/get_projects.dart';
import '../bloc/projects_bloc.dart';
import '../bloc/projects_event.dart';
import '../bloc/projects_state.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    final token = (authBloc.state is AuthAuthenticated)
        ? (authBloc.state as AuthAuthenticated).token
        : authBloc.token; // fallback if you store it on bloc

    final repository = ProjectsRepositoryImpl(token: token!);
    final getProjects = GetProjects(repository);

    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthUnauthenticated) context.go('/login');
          },
        ),
      ],
      child: BlocProvider(
        create: (_) => ProjectsBloc(getProjects: getProjects) // ✅ pass use-case here
          ..add(FetchProjects()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Projects'),
            actions: [
              IconButton(
                tooltip: 'Logout',
                icon: const Icon(Icons.logout),
                onPressed: () {
                  context.read<AuthBloc>().add(LogoutRequested());
                },
              ),
            ],
          ),
          body: BlocBuilder<ProjectsBloc, ProjectsState>(
            builder: (context, state) {
              if (state is ProjectsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ProjectsError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Error: ${state.message}'),
                  ),
                );
              }
              if (state is ProjectsLoaded) {
                if (state.projects.isEmpty) {
                  return const Center(child: Text('No projects found'));
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: state.projects.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final p = state.projects[index];
                    final id = p.id;
                    final name = p.name;
                    return ListTile(
                      key: ValueKey(id),
                      title: Text(name),
                      subtitle: Text('ID: $id'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.go('/projects/$id/part-report'),
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
