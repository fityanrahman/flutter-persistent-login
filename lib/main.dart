import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_login/core/routes/router.dart';
import 'package:persistent_login/feature/auth/data/repository/auth_repository.dart';
import 'package:persistent_login/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:persistent_login/feature/auth/presentation/bloc/auth_event.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final authBloc = AuthBloc(authUseCase: AuthRepository());
            // Trigger app start to check authentication state
            authBloc.add(AppStarted());
            return authBloc;
          },
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            title: 'Flutter Persistent Login',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
            routerConfig: AppRouter.createRouter(),
          );
        },
      ),
    );
  }
}
