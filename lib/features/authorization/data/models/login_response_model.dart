class LoginResponseModel {
  final String? accessToken;
  final String? refreshToken;
  final String? detail;

  LoginResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.detail,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      detail: json['detail'],
    );
  }
}
