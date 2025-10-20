class ApiConstants {
  static const String baseUrl = 'http://10.0.2.2:8000/api/';
  static const String tokenKey = 'jwt_token';
  static const String refreshTokenKey = 'refresh_token';
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);

  // Endpoints
  static const String token = 'token/';
  static const String students = 'students/students/';
  static const String schedules = 'schedules/schedules/';
}
