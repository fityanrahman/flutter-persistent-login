// Mock class
import 'dart:async';
import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:persistent_login/core/const/api_const.dart';
import 'package:persistent_login/core/errors/custom_exception.dart';
import 'package:persistent_login/feature/auth/domain/entities/auth_entity.dart';
import 'package:persistent_login/feature/auth/domain/usecases/auth_usecase.dart';
import 'package:persistent_login/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:persistent_login/feature/auth/presentation/bloc/auth_event.dart';
import 'package:persistent_login/feature/auth/presentation/bloc/auth_state.dart';

class MockAuthUseCase extends Mock implements AuthUseCase {}

class FakeAuthEntities extends Fake implements AuthEntities {}

void main() {
  late AuthBloc authBloc;
  late MockAuthUseCase mockAuthUseCase;
  late FakeAuthEntities fakeAuthEntities;

  setUp(() {
    mockAuthUseCase = MockAuthUseCase();
    authBloc = AuthBloc(authUseCase: mockAuthUseCase);
    fakeAuthEntities = FakeAuthEntities();
  });

  tearDown(() => authBloc.close());

  group('AuthBloc', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthInitial] when AppStarted and user is not logged in',
      build: () {
        when(() => mockAuthUseCase.isLoggedIn()).thenAnswer((_) async => false);
        return authBloc;
      },
      act: (bloc) => bloc.add(AppStarted()),
      expect: () => [AuthInitial()],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSuccess on successful login',
      build: () {
        when(
          () => mockAuthUseCase.login(username: 'admin', password: 'admin'),
        ).thenAnswer((_) async => fakeAuthEntities);
        when(
          () => mockAuthUseCase.getUsername(),
        ).thenAnswer((_) async => 'test_user');
        when(
          () => mockAuthUseCase.getToken(),
        ).thenAnswer((_) async => 'token_123');
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthLogIn(username: 'admin', password: 'admin')),
      expect: () => [
        AuthLoading(),
        AuthSuccess(username: 'test_user', token: 'token_123'),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailure] on SocketException',
      build: () {
        when(
          () => mockAuthUseCase.login(username: 'admin', password: 'admin'),
        ).thenThrow(SocketException('No Internet'));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthLogIn(username: 'admin', password: 'admin')),
      expect: () => [
        AuthLoading(),
        AuthFailure(message: 'No Internet Connection'),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailure] on TimeoutException',
      build: () {
        when(
          () => mockAuthUseCase.login(username: 'admin', password: 'admin'),
        ).thenThrow(TimeoutException('Login request time out'));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthLogIn(username: 'admin', password: 'admin')),
      expect: () => [AuthLoading(), AuthFailure(message: 'Login request time out')],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailure] on CustomException',
      build: () {
        when(
          () => mockAuthUseCase.login(username: 'admin', password: 'admin'),
        ).thenThrow(
          CustomException(
            state: ResultState.error,
            message: 'Invalid Credential',
          ),
        );
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthLogIn(username: 'admin', password: 'admin')),
      expect: () => [AuthLoading(), AuthFailure(message: 'Invalid Credential')],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthInitial] on logout',
      build: () {
        when(() => mockAuthUseCase.logout()).thenAnswer((_) async {});
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthLogOut()),
      expect: () => [AuthInitial()],
    );
  });
}
