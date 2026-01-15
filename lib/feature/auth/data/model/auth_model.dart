class AuthModel {
  final bool status;
  final String username;
  final String token;
  final String message;

  AuthModel({
    required this.status,
    required this.username,
    required this.token,
    required this.message,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    status: json["status"],
    username: json["username"],
    token: json["token"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "username": username,
    "token": token,
    "message": message,
  };
}
