class RegisterResponseModel {
  final int? id;
  final String? username;
  final String? email;
  final int? orgId;

  final String? detail;

  RegisterResponseModel({
    required this.id,
    required this.username,
    required this.email,
    required this.orgId,
    this.detail,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      orgId: json['org_id'],
      detail: json['detail'],
    );
  }
}
