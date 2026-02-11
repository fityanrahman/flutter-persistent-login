import 'package:equatable/equatable.dart';
import 'package:persistent_login/feature/auth/domain/entities/auth_entity.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final AuthEntity session;

  const AuthAuthenticated({required this.session});

  @override
  List<Object?> get props => [session];
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState{
  final String message;
  final String? detail;

  const AuthError({required this.message, this.detail});

  @override
  List<Object?> get props => [message, detail];
}


