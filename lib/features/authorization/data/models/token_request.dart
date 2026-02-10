class TokenRequest {
  final String email;
  final String password;

  TokenRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
