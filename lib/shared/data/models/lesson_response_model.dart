import 'package:treemov/shared/data/models/classroom_response_model.dart';
import 'package:treemov/shared/data/models/student_group_response_model.dart';
import 'package:treemov/shared/data/models/subject_response_model.dart';
import 'package:treemov/shared/data/models/teacher_response_model.dart';
import 'package:treemov/shared/domain/models/base_response_model.dart';

class LessonResponseModel extends BaseResponseModel {
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
  final GroupStudentsResponseModel? group;
  final SubjectResponseModel? subject;

  LessonResponseModel({
    required super.baseData,
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
    required this.classroom,
    required this.group,
    required this.subject,
  });

  factory LessonResponseModel.fromJson(Map<String, dynamic> json) {
    return LessonResponseModel(
      baseData: json.baseData,
      title: json['title'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      date: json['date'],
      weekDay: json['week_day'],
      isCanceled: json['is_canceled'],
      isCompleted: json['is_completed'],
      duration: json['duration'],
      comment: json['comment'],
      teacher: json['teacher'] != null
          ? TeacherResponseModel.fromJson(json['teacher'])
          : null,
      classroom: json['classroom'] != null
          ? ClassroomResponseModel.fromJson(json['classroom'])
          : null,
      group: json['student_group'] != null
          ? GroupStudentsResponseModel.fromJson(json['student_group'])
          : null,
      subject: json['subject'] != null
          ? SubjectResponseModel.fromJson(json['subject'])
          : null,
    );
  }

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
}
