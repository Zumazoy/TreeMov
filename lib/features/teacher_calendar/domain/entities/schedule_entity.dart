import 'package:treemov/shared/data/models/classroom_response_model.dart';
import 'package:treemov/shared/data/models/student_group_response_model.dart';
import 'package:treemov/shared/data/models/subject_response_model.dart';
import 'package:treemov/shared/data/models/teacher_response_model.dart';

class ScheduleEntity {
  final int? id;
  final int? org;
  final int? createdBy;
  final String? createdAt;
  final String? title;
  final String? startTime;
  final String? endTime;
  final String? date;
  final int? weekDay;
  final bool? isCanceled;
  final bool? isCompleted;
  final String? duration;
  final String? comment;
  final int? periodSchedule;
  final TeacherResponseModel? teacher;
  final SubjectResponseModel? subject;
  final StudentGroupResponseModel? group;
  final ClassroomResponseModel? classroom;

  ScheduleEntity({
    required this.id,
    required this.org,
    required this.createdBy,
    required this.createdAt,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.weekDay,
    required this.isCanceled,
    required this.isCompleted,
    required this.duration,
    required this.comment,
    required this.periodSchedule,
    required this.teacher,
    required this.subject,
    required this.group,
    required this.classroom,
  });

  String formatTime(String? startTime, String? endTime) {
    if (startTime != null && endTime != null) {
      startTime = startTime.length >= 5 ? startTime.substring(0, 5) : startTime;
      endTime = endTime.length >= 5 ? endTime.substring(0, 5) : endTime;
      return '$startTime\n$endTime';
    }

    return 'Время не указано';
  }

  String formatTitle(String? title) {
    return title!.isNotEmpty ? title : '(Без названия)';
  }
}
