import 'package:flutter/material.dart';

class LessonRequestModel {
  final int teacherId;
  final int subjectId;
  final int groupId;
  final int classroomId;
  final String title;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final DateTime date;
  final bool isCanceled;
  final bool isCompleted;
  final String? comment;
  final int? periodScheduleId;

  LessonRequestModel({
    required this.teacherId,
    required this.subjectId,
    required this.groupId,
    required this.classroomId,
    required this.title,
    this.startTime,
    this.endTime,
    required this.date,
    this.isCanceled = false,
    this.isCompleted = false,
    this.comment,
    this.periodScheduleId,
  });

  Map<String, dynamic> toJson() => {
    'teacher': teacherId,
    'subject': subjectId,
    'group': groupId,
    'classroom': classroomId,
    'title': title,
    if (startTime != null) 'start_time': _formatTime(startTime!),
    if (endTime != null) 'end_time': _formatTime(endTime!),
    'date': _formatDate(date),
    'is_canceled': isCanceled,
    'is_completed': isCompleted,
    if (comment != null) 'comment': comment,
    if (periodScheduleId != null) 'period_schedule': periodScheduleId,
  };

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:00';
  }
}
