import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:persistent_login/core/const/local_storage/key_pair_const.dart';
import 'package:persistent_login/feature/auth/data/api/login_api.dart';
import 'package:persistent_login/feature/auth/domain/entities/auth_entity.dart';
import 'package:persistent_login/feature/auth/domain/usecases/auth_usecase.dart';

class AuthRepository implements AuthUseCase {
  AuthEntity? _authEntity;

  @override
  Future<AuthEntity?> restoreSession() async {
    if (_authEntity != null) return _authEntity!;

    final raw = await FlutterSecureStorage().read(key: KeyPairConst.token);
    if (raw == null) return null;

    try {
      final decoded = jsonDecode(raw);
      final auth = AuthEntity.fromJson(decoded);

      _authEntity = AuthEntity(username: auth.username, token: auth.token);

      return _authEntity;
    } catch (e) {
      throw Exception('Failed to restore session: $e');
    }
  }

  @override
  Future<AuthEntity> login({
    required String username,
    required String password,
  }) async {
    final secureStorage = FlutterSecureStorage();

    // Call API to login
    final AuthEntity response = await LoginApi().signIn(
      username: username,
      password: password,
    );

    // Save token and username to secure storage
    await secureStorage.write(key: KeyPairConst.token, value: response.token);
    await secureStorage.write(
      key: KeyPairConst.username,
      value: response.username,
    );

    return response;
  }

  @override
  Future<void> logout() async {
    _authEntity = null;
    
    final secureStorage = FlutterSecureStorage();
    await secureStorage.delete(key: KeyPairConst.token);
    await secureStorage.delete(key: KeyPairConst.username);
  }
}
