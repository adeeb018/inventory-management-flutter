import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_state.dart';
import 'features/auth/presentation/pages/login_page.dart';

import 'features/home/home_page.dart';
import 'features/part-report/presentation/pages/part_report_page.dart';
import 'features/parts/presentation/pages/parts_page.dart';
import 'features/projects/presentation/pages/projects_page.dart';

class AppRouter {
  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      initialLocation: '/login',
      redirect: (context, state) {
        final authState = context.read<AuthBloc>().state;
        final loggedIn = authState is AuthAuthenticated;
        final loggingIn = state.uri.toString() == '/login';

        if (!loggedIn && !loggingIn) return '/login';
        if (loggedIn && loggingIn) return '/parts';
        return null;
      },
      // routes: [
      //   GoRoute(
      //     path: '/login',
      //     builder: (context, state) => const LoginPage(),
      //   ),
      //   GoRoute(path: '/parts', builder: (context, state) => const PartsPage()),
      //   GoRoute(
      //     path: '/projects',
      //     builder: (context, state) => const ProjectsPage(),
      //     routes: [
      //       GoRoute(
      //         path: ':id/part-report',
      //         builder: (context, state) {
      //           final id = int.parse(state.pathParameters['id']!);
      //           return PartReportPage(projectId: id);
      //         },
      //       ),
      //     ],
      //   ),
      routes: [
        /// Login route
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),

        /// Shell (NavigationRail layout)
        ShellRoute(
          builder: (context, state, child) {
            return HomePage(child: child); // NavigationRail wrapper
          },
          routes: [
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: Text("")),
            ),
            GoRoute(
              path: '/parts',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: PartsPage()),
            ),
            GoRoute(
              path: '/composite-items',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: Text("")),
            ),
            GoRoute(
              path: '/assemblies',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: Text("")),
            ),
          ],
        ),
      ],
    );
  }
}
