import 'package:persistent_login/core/const/api/api_const.dart';

class CustomException implements Exception {
  final String message;
  final ResultState state;

  // Pass your message in constructor
  CustomException({required this.state, required this.message});
}
