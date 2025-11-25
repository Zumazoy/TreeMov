class ApiConstants {
  static const String baseUrl = 'http://10.0.2.2:8000/api/';
  static const String tokenKey = 'jwt_token';
  static const String refreshTokenKey = 'refresh_token';
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);

  // Prefixes
  static const String schedule = 'schedule/';

  // Endpoints
  static const String token = 'token/';
  static const String lessons = 'lessons/';
  static const String subjects = 'subjects/';
  static const String classrooms = 'classrooms/';
  static const String periodLessons = 'period_lessons/';
  static const String attendances = 'attendances/';
  static const String students = 'students/students/';
  static const String studentGroups = 'students/student_groups/';
  static const String teachers = 'employers/teachers/';
  static const String teacherNotes = 'employers/teacher_notes/';
}
