class TokenRequest {
  final String username;
  final String password;

  TokenRequest({required this.username, required this.password});

  Map<String, dynamic> toJson() {
    return {'username': username, 'password': password};
  }
}
