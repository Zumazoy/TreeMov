class RefreshRequestModel {
  final String refreshToken;

  RefreshRequestModel({required this.refreshToken});

  Map<String, dynamic> toJson() => {'refresh_token': refreshToken};
}
