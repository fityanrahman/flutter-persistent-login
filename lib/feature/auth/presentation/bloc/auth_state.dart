import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String username;
  final String token;

  const AuthSuccess({required this.username, required this.token});

  @override
  List<Object?> get props => [username, token];
}

class AuthFailure extends AuthState{
  final String message;

  const AuthFailure({required this.message});

  List<Object?> get props => [message];
}


