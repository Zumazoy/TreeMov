class ApiConstants {
  static const String baseUrl = 'http://10.0.2.2:8000/api/';
  static const String tokenKey = 'jwt_token';
  static const String refreshTokenKey = 'refresh_token';
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);

  // Endpoints
  static const String token = 'token/';
  static const String students = 'students/students/';
  static const String studentGroups = 'students/student_groups/';
  static const String schedules = 'schedules/schedules/';
  static const String subjects = 'schedules/subjects/';
  static const String classrooms = 'schedules/classrooms/';
  static const String periodSchedules = 'schedules/period_schedules/';
  static const String teachers = 'employers/teachers/';
}
