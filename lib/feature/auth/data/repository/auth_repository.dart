import 'package:persistent_login/feature/auth/domain/entities/auth_entity.dart';
import 'package:persistent_login/feature/auth/domain/usecases/auth_usecase.dart';

class AuthRepository implements AuthUseCase{
  @override
  Future<String> getToken() {
    // TODO: implement getToken
    throw UnimplementedError();
  }

  @override
  Future<String> getUsername() {
    // TODO: implement getUsername
    throw UnimplementedError();
  }

  @override
  Future<bool> isLoggedIn() {
    // TODO: implement isLoggedIn
    throw UnimplementedError();
  }

  @override
  Future<AuthEntities> login({required String username, required String password}) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}