abstract class AuthEvent{}

class AuthLogIn extends AuthEvent {
  final String username;
  final String password;

  AuthLogIn({required this.username, required this.password});
}

class AppStarted extends AuthEvent{}

class AuthLogOut extends AuthEvent{}