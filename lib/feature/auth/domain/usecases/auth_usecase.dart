import 'package:persistent_login/feature/auth/domain/entities/auth_entity.dart';

abstract class AuthUseCase {

  // Attempt login
  Future<AuthEntity> login({
    required String username,
    required String password,
  });

  // Logout currently logged in user
  Future<void> logout();

  // Restore session
  Future<AuthEntity?> restoreSession();
}
