import 'package:treemov/shared/data/models/classroom_response_model.dart';
import 'package:treemov/shared/data/models/student_group_response_model.dart';
import 'package:treemov/shared/data/models/subject_response_model.dart';
import 'package:treemov/shared/data/models/teacher_response_model.dart';

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
  final TeacherResponseModel? teacher;
  final SubjectResponseModel? subject;
  final StudentGroupResponseModel? group;
  final ClassroomResponseModel? classroom;

  ScheduleResponseModel({
    required this.id,
    required this.title,
    required this.date,
    required this.weekDay,
    required this.isCanceled,
    required this.isCompleted,
    required this.startTime,
    required this.endTime,
    required this.lesson,
    required this.duration,
    required this.org,
    required this.createdBy,
    required this.periodSchedule,
    required this.createdAt,
    required this.teacher,
    required this.subject,
    required this.group,
    required this.classroom,
  });

  factory ScheduleResponseModel.fromJson(Map<String, dynamic> json) {
    final teacherJson = json['teacher'];
    final subjectJson = json['subject'];
    final groupJson = json['group'];
    final classroomJson = json['classroom'];

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
      teacher: teacherJson != null && teacherJson is Map<String, dynamic>
          ? TeacherResponseModel.fromJson(teacherJson)
          : null,
      subject: subjectJson != null && subjectJson is Map<String, dynamic>
          ? SubjectResponseModel.fromJson(subjectJson)
          : null,
      group: groupJson != null && groupJson is Map<String, dynamic>
          ? StudentGroupResponseModel.fromJson(groupJson)
          : null,
      classroom: classroomJson != null && classroomJson is Map<String, dynamic>
          ? ClassroomResponseModel.fromJson(classroomJson)
          : null,
    );
  }

  // Helper method to get formatted teacher (employer) name for display
  String get formattedEmployer {
    return [
      teacher?.employer.surname,
      teacher?.employer.name,
      teacher?.employer.patronymic,
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
}
