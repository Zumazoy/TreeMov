class RegisterRequestModel {
  final String username;
  final String email;
  final String password;

  RegisterRequestModel({
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {"username": username, "email": email, "password": password};
  }
}
