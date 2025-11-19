import 'package:flutter/material.dart';
import 'package:treemov/shared/data/models/classroom_response_model.dart';
import 'package:treemov/shared/data/models/student_group_response_model.dart';
import 'package:treemov/shared/data/models/subject_response_model.dart';
import 'package:treemov/shared/data/models/teacher_response_model.dart';
import 'package:treemov/shared/domain/models/base_response_model.dart';

class ScheduleResponseModel extends BaseResponseModel {
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

  ScheduleResponseModel({
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
    required this.periodSchedule,
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
      baseData: json.baseData,
      title: json['title'] ?? '',
      startTime: json['start_time'],
      endTime: json['end_time'],
      date: json['date'] ?? '',
      weekDay: json['week_day'] ?? 0,
      isCanceled: json['is_canceled'] == true,
      isCompleted: json['is_completed'] == true,
      duration: json['duration'],
      comment: json['comment'],
      periodSchedule: json['period_schedule'],
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

  String get formattedEmployer {
    if (teacher?.employer == null) return '';

    return [
      teacher?.employer.surname,
      teacher?.employer.name,
      teacher?.employer.patronymic,
    ].where((s) => s != null && s.isNotEmpty).join(' ');
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
    if (weekDay != null) {
      return weekDay! >= 1 && weekDay! <= 7
          ? weekDays[weekDay! - 1]
          : 'Неизвестно';
    } else {
      debugPrint("===ERROR=== on get weekDayName");
      return 'Неизвестно';
    }
  }

  String get formattedDate {
    try {
      if (date != null) {
        final parts = date!.split('-');
        if (parts.length == 3) {
          return '${parts[2]}.${parts[1]}.${parts[0]}';
        }
      }
      return date!;
    } catch (e) {
      debugPrint("===ERROR=== on get formattedDate: $date");
      return date!;
    }
  }
}
