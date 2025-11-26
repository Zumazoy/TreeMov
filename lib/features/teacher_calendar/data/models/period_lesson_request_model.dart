import 'package:flutter/material.dart';

class PeriodLessonRequestModel {
  final int teacherId;
  final int subjectId;
  final int groupId;
  final int classroomId;
  final String title;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final int period;
  final DateTime? repeatUntilDate;
  final DateTime startDate;

  PeriodLessonRequestModel({
    required this.teacherId,
    required this.subjectId,
    required this.groupId,
    required this.classroomId,
    required this.title,
    this.startTime,
    this.endTime,
    required this.period,
    this.repeatUntilDate,
    required this.startDate,
  });

  Map<String, dynamic> toJson() => {
    'teacher': teacherId,
    'subject': subjectId,
    'group': groupId,
    'classroom': classroomId,
    'title': title,
    if (startTime != null) 'start_time': _formatTime(startTime!),
    if (endTime != null) 'end_time': _formatTime(endTime!),
    'period': period,
    if (repeatUntilDate != null)
      'repeat_lessons_until_date': _formatDate(repeatUntilDate!),
    'start_date': _formatDate(startDate),
  };

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:00';
  }
}
