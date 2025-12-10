class RegisterRequestModel {
  final String username;
  final String email;
  final String password;
  final int? orgId;

  RegisterRequestModel({
    required this.username,
    required this.email,
    required this.password,
    this.orgId,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
    'password': password,
    'org_id': orgId,
  };
}
