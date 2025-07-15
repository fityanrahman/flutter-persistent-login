import 'package:go_router/go_router.dart';
import 'package:persistent_login/feature/auth/presentation/screen/login_screen.dart';
import 'package:persistent_login/feature/dashboard/presentation/screen/dashboard_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => DashboardScreen(),
      ),
    ],
  );
}
