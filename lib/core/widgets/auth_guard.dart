import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:persistent_login/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:persistent_login/feature/auth/presentation/bloc/auth_state.dart';

class AuthGuard extends StatelessWidget {
  final Widget child;
  final String redirectTo;
  
  const AuthGuard({
    super.key,
    required this.child,
    this.redirectTo = '/login',
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial || state is AuthUnauthenticated) {
          context.go(redirectTo);
        }
      },
      child: child,
    );
  }
}

class LoginGuard extends StatelessWidget {
  final Widget child;
  final String redirectTo;
  
  const LoginGuard({
    super.key,
    required this.child,
    this.redirectTo = '/dashboard',
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.go(redirectTo);
        }
      },
      child: child,
    );
  }
}
