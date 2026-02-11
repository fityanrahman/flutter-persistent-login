import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:persistent_login/core/const/api/api_const.dart';
import 'package:persistent_login/feature/auth/data/model/auth_model.dart';
import 'package:persistent_login/feature/auth/domain/entities/auth_entity.dart';

class LoginApi {
  Future<AuthEntity> signIn({
    required String username,
    required String password,
  }) async {
    final body = {'username': username, 'password': password};

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$login'),
        body: body,
      );

      final int code = response.statusCode;
      log('Response code: $code');
      log('Response body: ${response.body}');

      // if unauthorized
      if (code == 401) {
        throw Exception('Unauthorized');
      }

      // if status success
      if (code >= 200 && code < 300) {
        final result = jsonDecode(response.body);

        return AuthModel.fromJson(result).toDomain();
      } else {
        throw Exception('Failed to login - Code $code');
      }
    } catch (e, st) {
      throw Exception('Error $e ($st)');
    }
  }
}
