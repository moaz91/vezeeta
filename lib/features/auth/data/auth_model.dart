class AuthModel {
  final String token;
  final String username;

  AuthModel({
    required this.token,
    required this.username,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      token: json['data']['token'],
      username: json['data']['username'],
    );
  }
}