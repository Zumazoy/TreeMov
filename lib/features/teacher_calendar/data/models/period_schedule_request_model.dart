import 'package:flutter/material.dart';

class PeriodScheduleRequestModel {
  final int teacherId;
  final int subjectId;
  final int groupId;
  final int classroomId;
  final int? period;
  final String? title;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final int? lesson;
  final DateTime? repeatUntilDate;
  final DateTime startDate;

  PeriodScheduleRequestModel({
    required this.teacherId,
    required this.subjectId,
    required this.groupId,
    required this.classroomId,
    required this.period,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.lesson,
    required this.repeatUntilDate,
    required this.startDate,
  });

  Map<String, dynamic> toJson() => {
    'teacher': teacherId,
    'subject': subjectId,
    'group': groupId,
    'classroom': classroomId,
    'period': period,
    'title': title,
    'start_time': startTime != null ? _formatTime(startTime!) : null,
    'end_time': endTime != null ? _formatTime(endTime!) : null,
    'lesson': lesson,
    'repeat_lessons_until_date': repeatUntilDate != null
        ? _formatDate(repeatUntilDate!)
        : null,
    'start_date': _formatDate(startDate),
  };

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:00';
  }
}
