class AuthEntity {
  final String username;
  final String token;

  AuthEntity({required this.username, required this.token});

  factory AuthEntity.fromJson(Map<String, dynamic> json) {
    return AuthEntity(
      username: json['username'],
      token: json['token'],
    );
  }
}
