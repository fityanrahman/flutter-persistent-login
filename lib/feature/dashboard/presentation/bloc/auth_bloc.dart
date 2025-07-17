import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_login/core/errors/custom_exception.dart';
import 'package:persistent_login/feature/auth/domain/usecases/auth_usecase.dart';
import 'package:persistent_login/feature/dashboard/presentation/bloc/auth_event.dart';
import 'package:persistent_login/feature/dashboard/presentation/bloc/auth_state.dart';

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
    final isLoggedIn = await authUseCase.isLoggedIn();

    if (isLoggedIn) {
      // Retrieve username and token if logged in
      final username = await authUseCase.getUsername();
      final token = await authUseCase.getToken();

      // Emit success state with user data
      emit(AuthSuccess(username: username, token: token));
    } else {
      // Emit initial state if not logged in
      emit(AuthInitial());
    }
  }

  // Handles AuthLogin event: attempt login and emit corresponding states
  Future<void> _onLogIn(AuthLogIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      // Call login method with provided credentials
      await authUseCase.login(
        username: event.username,
        password: event.password,
      );

      // Get username and token after successful login
      final username = await authUseCase.getUsername();
      final token = await authUseCase.getToken();

      // Emit success state with user data
      emit(AuthSuccess(username: username, token: token));
    } on SocketException {
      // Emit failure for no internet connection
      emit(AuthFailure(message: 'No Internet Connection'));
    } on TimeoutException {
      // Emit failure state for timeout
      emit(AuthFailure(message: 'Login request time out'));
    } on CustomException catch (e) {
      // Emit failure state for known custom error
      emit(AuthFailure(message: e.message));
    } catch (e) {
      // Emit failure state for any other unknown error
      emit(AuthFailure(message: e.toString()));
    }
  }

  // Handles AuthLogOut event: logout and reset to initial state
  Future<void> _onLogOut(AuthLogOut event, Emitter<AuthState> emit) async{
    // Perform logout logic
    await authUseCase.logout();
    // Emit initial state after logout
    emit(AuthInitial());
  }
}

