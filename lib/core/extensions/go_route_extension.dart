import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:persistent_login/core/widgets/auth_guard.dart';

extension GoRouteAuthExtension on GoRoute {
  static GoRoute authenticated({
    required String path,
    required Widget child,
    List<RouteBase> routes = const [],
  }) {
    return GoRoute(
      path: path,
      builder: (context, state) => AuthGuard(child: child),
      routes: routes,
    );
  }

  static GoRoute public({
    required String path,
    required Widget child,
    List<RouteBase> routes = const [],
  }) {
    return GoRoute(
      path: path,
      builder: (context, state) => child,
      routes: routes,
    );
  }

  static GoRoute login({
    required String path,
    required Widget child,
    List<RouteBase> routes = const [],
  }) {
    return GoRoute(
      path: path,
      builder: (context, state) => LoginGuard(child: child),
      routes: routes,
    );
  }
}
