class ApiConstants {
  static const String baseUrl = 'http://10.0.2.2:8001/api/v1/';
  static const String authUrl = 'http://10.0.2.2:8000/api/v1/';
  static const String emailUrl = 'http://10.0.2.2:8002/api/v1/';

  static const String tokenKey = 'jwt_token';
  static const String refreshTokenKey = 'refresh_token';
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);

  // Prefixes
  static const String scheduleP = 'schedule/';
  static const String studentsP = 'students/';
  static const String employeesP = 'employees/';

  // Endpoints
  static const String token = 'auth/login';

  static const String lessons = 'lessons/';
  static const String subjects = 'subjects/';
  static const String classrooms = 'classrooms/';
  static const String attendances = 'attendances/';
  static const String periodLessons =
      'period_lessons/'; //Отсутcвует соответствующий роут в документации

  static const String students = 'students/';
  static const String studentGroups =
      'student_groups/'; //Отсутствет соответствующий роут в документации
  static const String accruals =
      'accruals/'; //Отсутствет соответствующий роут в документации

  static const String teachers = 'teachers/';
  static const String teacherNotes = 'teacher_notes/';
  static const String myTeacherProfile = 'teacher_profile/me/';

  // v1/
  static const String baseV1EmailUrl = 'http://10.0.2.2:8002/api/v1/';

  static const String register = 'auth/register';
  static const String login = 'auth/login';
  static const String refresh = 'auth/refresh';
  static const String userList = 'users/list';

  static const String myUser = 'users/me';
}
