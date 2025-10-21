import 'package:flutter/material.dart';

class ScheduleRequestModel {
  final int classroomId;
  final int groupId;
  final int? periodScheduleId;
  final int teacherId;
  final int subjectId;
  final int? lesson;
  final String title;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final bool isCanceled;
  final bool isCompleted;

  ScheduleRequestModel({
    required this.classroomId,
    required this.groupId,
    required this.periodScheduleId,
    required this.teacherId,
    required this.subjectId,
    required this.lesson,
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.isCanceled = false,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() => {
    'classroom': classroomId,
    'group': groupId,
    if (periodScheduleId != null) 'period_schedule': periodScheduleId,
    'teacher': teacherId,
    'subject': subjectId,
    if (lesson != null) 'lesson': lesson,
    'title': title,
    'date': _formatDate(date),
    'start_time': _formatTime(startTime),
    'end_time': _formatTime(endTime),
    'is_canceled': isCanceled,
    'is_completed': isCompleted,
  };

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:00';
  }
}
