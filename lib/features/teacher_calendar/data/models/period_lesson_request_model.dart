import 'package:flutter/material.dart';

class PeriodLessonRequestModel {
  final int teacherId;
  final int classroomId;
  final int groupId;
  final int subjectId;
  final String title;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final int period;
  final DateTime repeatUntilDate;
  final DateTime startDate;

  PeriodLessonRequestModel({
    required this.teacherId,
    required this.classroomId,
    required this.groupId,
    required this.subjectId,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.period,
    required this.repeatUntilDate,
    required this.startDate,
  });

  Map<String, dynamic> toJson() => {
    'teacher_id': teacherId,
    'classroom_id': classroomId,
    'student_group_id': groupId,
    'subject_id': subjectId,
    'title': title,
    'start_time': _formatTime(startTime),
    'end_time': _formatTime(endTime),
    'period': period,
    'repeat_lessons_until_date': _formatDate(repeatUntilDate),
    'start_date': _formatDate(startDate),
  };

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
