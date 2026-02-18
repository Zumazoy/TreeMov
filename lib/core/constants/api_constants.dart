class ApiConstants {
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);

  static const String baseUrl = 'http://10.0.2.2:8001/api/v1/';
  static const String authUrl = 'http://10.0.2.2:8000/api/v1/';
  static const String emailUrl = 'http://10.0.2.2:8002/email/';

  // Auth
  static const String register = 'auth/register';
  static const String login = 'auth/login';
  static const String refresh = 'auth/refresh';
  static const String logout = 'auth/logout';

  // Email
  static const String sendEmail = 'send';
  static const String verifyEmail = 'verify';

  // Main
  static const String lessons = 'lessons';
  static const String subjects = 'subjects/';
  static const String classrooms = 'classrooms/';
  static const String attendances = 'attendances';
  static const String students = 'students/';
  static const String studentGroups = 'student-groups/';
  static const String teachers = 'teachers';
  static const String myOrgs = 'organizations/me/';

  static const String addOrgMember = 'add_org_member/';

  // Endpoints requiring org-id header
  static const List<String> endpointsRequiringOrgId = [
    lessons,
    subjects,
    classrooms,
    attendances,
    students,
    studentGroups,
    teachers,
    myOrgs,
    addOrgMember,
  ];

  // Endpoints not requiring org-id header
  static const List<String> excludedOrgIdPaths = [
    register,
    login,
    refresh,
    logout,
  ];

  // Endpoints not requiring token
  static const List<String> excludedTokenPaths = [
    register,
    login,
    refresh,
    logout,
    sendEmail,
    verifyEmail,
  ];

  // static const String periodLessons = 'period_lessons/'; Отсутcвует соответствующий роут в документации
  // static const String accruals = 'accruals/'; Отсутствет соответствующий роут в документации
  // static const String teacherNotes = 'teacher_notes/'; Отсутcвует соответствующий роут в документации
}
