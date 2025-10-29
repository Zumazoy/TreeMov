class TokenResponse {
  final String? accessToken;
  final String? refreshToken;
  final String? detail;

  TokenResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.detail,
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json) {
    return TokenResponse(
      accessToken: json['access'],
      refreshToken: json['refresh'],
      detail: json['detail'],
    );
  }

  bool get isSuccess => accessToken != null && refreshToken != null;
}
