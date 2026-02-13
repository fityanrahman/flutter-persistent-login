import 'package:flutter/material.dart';
import 'package:persistent_login/feature/auth/presentation/bloc/auth_bloc.dart';

class AuthRefreshListenable extends ChangeNotifier {
  final AuthBloc authBloc;
  
  AuthRefreshListenable(this.authBloc) {
    // Listen to auth state changes and notify router to refresh
    authBloc.stream.listen((_) => notifyListeners());
  }
}
