import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:persistent_login/core/extensions/go_route_extension.dart';
import 'package:persistent_login/core/widgets/auth_guard.dart';
import 'package:persistent_login/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:persistent_login/feature/auth/presentation/bloc/auth_state.dart';
import 'package:persistent_login/feature/auth/presentation/screen/login_screen.dart';
import 'package:persistent_login/feature/dashboard/presentation/screen/dashboard_screen.dart';

class AppRouter {
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: '/login',
      redirect: (context, state) {
        final authBloc = context.read<AuthBloc>();
        final authState = authBloc.state;
        
        final currentPath = state.uri.toString();
        final isGoingToLogin = currentPath == '/login';
        final isGoingToDashboard = currentPath == '/dashboard';
        
        // If user is authenticated and trying to access login, redirect to dashboard
        if (authState is AuthAuthenticated && isGoingToLogin) {
          return '/dashboard';
        }
        
        // If user is not authenticated and trying to access dashboard, redirect to login
        if ((authState is AuthInitial || authState is AuthUnauthenticated) && isGoingToDashboard) {
          return '/login';
        }
        
        // Allow navigation
        return null;
      },
      routes: [
        // GoRoute(
        //   path: '/login',
        //   builder: (context, state) => BlocListener<AuthBloc, AuthState>(
        //     listener: (context, state) {
        //       if (state is AuthAuthenticated) {
        //         context.go('/dashboard');
        //       }
        //     },
        //     child: const LoginScreen(),
        //   ),
        // ),
        // GoRoute(
        //   path: '/dashboard',
        //   builder: (context, state) => BlocListener<AuthBloc, AuthState>(
        //     listener: (context, state) {
        //       if (state is AuthInitial || state is AuthUnauthenticated) {
        //         context.go('/login');
        //       }
        //     },
        //     child: const DashboardScreen(),
        //   ),
        // ),

        // v2 with authguard
        // GoRoute(
        //   path: '/login',
        //   builder: (context, state) => LoginGuard(
        //     child: const LoginScreen(),
        //   ),
        // ),
        // GoRoute(
        //   path: '/dashboard',
        //   builder: (context, state) => AuthGuard(
        //     child: const DashboardScreen(),
        //   ),
        // ),

        // v3 with extension
        GoRouteAuthExtension.login(path: '/login', child: const LoginScreen()),
        GoRouteAuthExtension.authenticated(path: '/dashboard', child: const DashboardScreen()),
      ],
    );
  }
}
