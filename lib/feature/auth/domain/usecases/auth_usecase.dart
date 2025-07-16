import 'package:persistent_login/feature/auth/domain/entities/auth.dart';

abstract class AuthUseCase {

  // Attempt login
  Future<AuthEntities> login({
    required String username,
    required String password,
  });

  // Logout currently logged in user
  Future<void> logout();

  // Checks whether user is currently logged in
  Future<bool> isLoggedIn();

  // Returns the currently logged in user token
  Future<String> getToken();

  // Returns the currently logged in user name
  Future<String> getUsername();
}
