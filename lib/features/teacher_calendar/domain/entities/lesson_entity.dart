import 'package:treemov/shared/data/models/classroom_response_model.dart';
import 'package:treemov/shared/data/models/student_group_response_model.dart';
import 'package:treemov/shared/data/models/subject_response_model.dart';
import 'package:treemov/shared/data/models/teacher_response_model.dart';

class LessonEntity {
  final int? id;
  final String? title;
  final String? startTime;
  final String? endTime;
  final String? date;
  final int? weekDay;
  final bool? isCanceled;
  final bool? isCompleted;
  final String? duration;
  final String? comment;
  final TeacherResponseModel? teacher;
  final ClassroomResponseModel? classroom;
  final StudentGroupResponseModel? group;
  final SubjectResponseModel? subject;

  LessonEntity({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.weekDay,
    required this.isCanceled,
    required this.isCompleted,
    required this.duration,
    required this.comment,
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

  String formatLessonTitle(String? title, String? subject, String? group) {
    if (title != null && title.isNotEmpty) return title;
    return '${subject ?? 'Предмет не найден'} (Группа "${group ?? 'не найдена'}")';
  }

  String formatTitle(String? title, {String message = '(Без названия)'}) {
    if (title != null && title.isNotEmpty) return title;
    return message;
  }

  String formatPeriodLesson(int? periodLesson) {
    return switch (periodLesson) {
      1 => 'Ежедневно',
      7 => 'Еженедельно',
      _ => 'Каждые $periodLesson дней',
    };
  }
}
