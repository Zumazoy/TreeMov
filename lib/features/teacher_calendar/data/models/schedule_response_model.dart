class ScheduleResponseModel {
  final int id;
  final String title;
  final String date;
  final int weekDay;
  final bool isCanceled;
  final bool isCompleted;
  final String? startTime;
  final String? endTime;
  final int? lesson;
  final String? duration;
  final int org;
  final int? createdBy;
  final int? periodSchedule;
  final String createdAt;

  // Teacher information
  final int teacherId;
  final String? teacherCreatedAt;
  final int teacherOrg;
  final int? teacherCreatedBy;

  // Employer information (from teacher.employer)
  final int employerId;
  final String employerName;
  final String employerSurname;
  final String? employerPatronymic;
  final String? employerBirthday;
  final String? employerEmail;
  final String? employerPassportSeries;
  final String? employerPassportNum;
  final String? employerInn;
  final String? employerCreatedAt;
  final int employerOrg;
  final int? employerCreatedBy;
  final int? employerDepartment;

  // Subject information
  final int subjectId;
  final String subjectName;
  final String? subjectColor;
  final String? subjectCreatedAt;
  final int subjectOrg;
  final int? subjectCreatedBy;

  // Group information
  final int groupId;
  final String groupName;
  final String? groupCreatedAt;
  final int groupOrg;
  final int? groupCreatedBy;

  // Classroom information
  final int classroomId;
  final String classroomTitle;
  final String? classroomCreatedAt;
  final int? classroomFloor;
  final String? classroomBuilding;
  final int classroomOrg;
  final int? classroomCreatedBy;

  ScheduleResponseModel({
    required this.id,
    required this.title,
    required this.date,
    required this.weekDay,
    required this.isCanceled,
    required this.isCompleted,
    this.startTime,
    this.endTime,
    this.lesson,
    this.duration,
    required this.org,
    this.createdBy,
    this.periodSchedule,
    required this.createdAt,

    // Teacher
    required this.teacherId,
    this.teacherCreatedAt,
    required this.teacherOrg,
    this.teacherCreatedBy,

    // Employer
    required this.employerId,
    required this.employerName,
    required this.employerSurname,
    this.employerPatronymic,
    this.employerBirthday,
    this.employerEmail,
    this.employerPassportSeries,
    this.employerPassportNum,
    this.employerInn,
    this.employerCreatedAt,
    required this.employerOrg,
    this.employerCreatedBy,
    this.employerDepartment,

    // Subject
    required this.subjectId,
    required this.subjectName,
    this.subjectColor,
    this.subjectCreatedAt,
    required this.subjectOrg,
    this.subjectCreatedBy,

    // Group
    required this.groupId,
    required this.groupName,
    this.groupCreatedAt,
    required this.groupOrg,
    this.groupCreatedBy,

    // Classroom
    required this.classroomId,
    required this.classroomTitle,
    this.classroomCreatedAt,
    this.classroomFloor,
    this.classroomBuilding,
    required this.classroomOrg,
    this.classroomCreatedBy,
  });

  factory ScheduleResponseModel.fromJson(Map<String, dynamic> json) {
    // Parse teacher information
    final teacherData = json['teacher'];
    Map<String, dynamic> teacherMap = {};
    int teacherId = 0;

    if (teacherData is Map<String, dynamic>) {
      teacherMap = teacherData;
      teacherId = teacherData['id'] ?? 0;
    } else if (teacherData is int) {
      teacherId = teacherData;
    }

    final teacherEmployer = (teacherMap['employer'] is Map<String, dynamic>)
        ? teacherMap['employer'] as Map<String, dynamic>
        : <String, dynamic>{};

    // Parse subject information
    final subjectData = json['subject'];
    Map<String, dynamic> subjectMap = {};
    int subjectId = 0;
    String subjectName = '';

    if (subjectData is Map<String, dynamic>) {
      subjectMap = subjectData;
      subjectId = subjectData['id'] ?? 0;
      subjectName = subjectData['name'] ?? '';
    } else if (subjectData is int) {
      subjectId = subjectData;
      subjectName = 'Unknown';
    }

    // Parse group information
    final groupData = json['group'];
    Map<String, dynamic> groupMap = {};
    int groupId = 0;
    String groupName = '';

    if (groupData is Map<String, dynamic>) {
      groupMap = groupData;
      groupId = groupData['id'] ?? 0;
      groupName = groupData['name'] ?? '';
    } else if (groupData is int) {
      groupId = groupData;
      groupName = 'Unknown';
    }

    // Parse classroom information
    final classroomData = json['classroom'];
    Map<String, dynamic> classroomMap = {};
    int classroomId = 0;
    String classroomTitle = '';

    if (classroomData is Map<String, dynamic>) {
      classroomMap = classroomData;
      classroomId = classroomData['id'] ?? 0;
      classroomTitle = classroomData['title'] ?? '';
    } else if (classroomData is int) {
      classroomId = classroomData;
      classroomTitle = 'Unknown';
    }

    return ScheduleResponseModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      date: json['date'] ?? '',
      weekDay: json['week_day'] ?? 0,
      isCanceled: json['is_canceled'] == true,
      isCompleted: json['is_completed'] == true,
      startTime: json['start_time'],
      endTime: json['end_time'],
      lesson: json['lesson'],
      duration: json['duration'],
      org: json['org'] ?? 0,
      createdBy: json['created_by'],
      periodSchedule: json['period_schedule'],
      createdAt: json['created_at'] ?? '',

      // Teacher
      teacherId: teacherId,
      teacherCreatedAt: teacherMap['created_at'],
      teacherOrg: teacherMap['org'] ?? 0,
      teacherCreatedBy: teacherMap['created_by'],

      // Employer
      employerId: teacherEmployer['id'] ?? 0,
      employerName: teacherEmployer['name'] ?? '',
      employerSurname: teacherEmployer['surname'] ?? '',
      employerPatronymic: teacherEmployer['patronymic'],
      employerBirthday: teacherEmployer['birthday'],
      employerEmail: teacherEmployer['email'],
      employerPassportSeries: teacherEmployer['passport_series'],
      employerPassportNum: teacherEmployer['passport_num'],
      employerInn: teacherEmployer['inn'],
      employerCreatedAt: teacherEmployer['created_at'],
      employerOrg: teacherEmployer['org'] ?? 0,
      employerCreatedBy: teacherEmployer['created_by'],
      employerDepartment: teacherEmployer['department'],

      // Subject
      subjectId: subjectId,
      subjectName: subjectName,
      subjectColor: subjectMap['color'],
      subjectCreatedAt: subjectMap['created_at'],
      subjectOrg: subjectMap['org'] ?? 0,
      subjectCreatedBy: subjectMap['created_by'],

      // Group
      groupId: groupId,
      groupName: groupName,
      groupCreatedAt: groupMap['created_at'],
      groupOrg: groupMap['org'] ?? 0,
      groupCreatedBy: groupMap['created_by'],

      // Classroom
      classroomId: classroomId,
      classroomTitle: classroomTitle,
      classroomCreatedAt: classroomMap['created_at'],
      classroomFloor: classroomMap['floor'],
      classroomBuilding: classroomMap['building'],
      classroomOrg: classroomMap['org'] ?? 0,
      classroomCreatedBy: classroomMap['created_by'],
    );
  }

  // Helper method to get formatted teacher (employer) name for display
  String get formattedEmployer {
    return [
      employerSurname,
      employerName,
      employerPatronymic,
    ].where((s) => s != null && s.isNotEmpty).join(' ');
  }

  // Helper method to get formatted time range
  String get formattedTimeRange {
    if (startTime == null && endTime == null) return '';

    final start = startTime != null ? formatTime(startTime!) : '';
    final end = endTime != null ? formatTime(endTime!) : '';

    return [start, end].where((x) => x.isNotEmpty).join(' — ');
  }

  String formatTime(String time) {
    if (time.length >= 5) {
      return time.substring(0, 5);
    }
    return time;
  }

  // Helper method to get week day name
  String get weekDayName {
    const weekDays = [
      'Понедельник',
      'Вторник',
      'Среда',
      'Четверг',
      'Пятница',
      'Суббота',
      'Воскресенье',
    ];
    return weekDay >= 1 && weekDay <= 7 ? weekDays[weekDay - 1] : 'Неизвестно';
  }

  // Helper method to get formatted date
  String get formattedDate {
    try {
      final parts = date.split('-');
      if (parts.length == 3) {
        return '${parts[2]}.${parts[1]}.${parts[0]}';
      }
      return date;
    } catch (e) {
      return date;
    }
  }

  // Helper method to get formatted creation date
  String get formattedCreatedAt {
    try {
      final dt = DateTime.parse(createdAt);
      return '${dt.day.toString().padLeft(2, '0')}.${dt.month.toString().padLeft(2, '0')}.${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return createdAt;
    }
  }

  // Helper method to get formatted teacher creation date
  String? get formattedTeacherCreatedAt {
    if (teacherCreatedAt == null) return null;
    try {
      final dt = DateTime.parse(teacherCreatedAt!);
      return '${dt.day.toString().padLeft(2, '0')}.${dt.month.toString().padLeft(2, '0')}.${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return teacherCreatedAt;
    }
  }

  // Helper method to get formatted employer creation date
  String? get formattedEmployerCreatedAt {
    if (employerCreatedAt == null) return null;
    try {
      final dt = DateTime.parse(employerCreatedAt!);
      return '${dt.day.toString().padLeft(2, '0')}.${dt.month.toString().padLeft(2, '0')}.${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return employerCreatedAt;
    }
  }
}
