import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_login/core/errors/custom_exception.dart';
import 'package:persistent_login/feature/auth/domain/usecases/auth_usecase.dart';
import 'package:persistent_login/feature/auth/presentation/bloc/auth_event.dart';
import 'package:persistent_login/feature/auth/presentation/bloc/auth_state.dart';

// AuthBloc handles authentication state changes based on incoming AuthEvents
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // Dependency on AuthUseCase which contains business logic for auth
  final AuthUseCase authUseCase;

  // Initialize AuthBloc with the given use case and set initial data
  AuthBloc({required this.authUseCase}) : super(AuthInitial()) {
    // Register event handler for app start event
    on<AppStarted>(_onAppStarted);
    // Register event handler for login event
    on<AuthLogIn>(_onLogIn);
    // Register event handle for logout event
    on<AuthLogOut>(_onLogOut);
  }

  // Handles AppStarted event: check if user is already logged in
  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    try {
      final session = await authUseCase.restoreSession();
      log('Session: $session');

      if (session != null) {
        emit(AuthAuthenticated(session: session));
      } else {
        emit(AuthInitial());
      }
    } catch (e) {
      log('Error: $e');
      emit(
        AuthError(message: 'Failed to restore session', detail: e.toString()),
      );
    }
  }

  // Handles AuthLogin event: attempt login and emit corresponding states
  Future<void> _onLogIn(AuthLogIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      // Call login method with provided credentials
      final session = await authUseCase.login(
        username: event.username,
        password: event.password,
      );

      // Emit success state with user data
      emit(AuthAuthenticated(session: session));
    } on SocketException catch (e) {
      // Emit failure for no internet connection
      emit(AuthError(message: 'No Internet Connection', detail: e.toString()));
    } on TimeoutException catch (e) {
      // Emit failure state for timeout
      emit(AuthError(message: 'Login request time out', detail: e.toString()));
    } on CustomException catch (e) {
      // Emit failure state for known custom error
      emit(AuthError(message: e.message, detail: e.toString()));
    } catch (e) {
      // Emit failure state for any other unknown error
      emit(AuthError(message: e.toString(), detail: e.toString()));
    }
  }

  // Handles AuthLogOut event: logout and reset to initial state
  Future<void> _onLogOut(AuthLogOut event, Emitter<AuthState> emit) async {
    // Perform logout logic
    await authUseCase.logout();
    // Emit initial state after logout
    emit(AuthInitial());
  }
}
