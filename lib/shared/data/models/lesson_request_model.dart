import 'package:flutter/material.dart';

class LessonRequestModel {
  final int teacherId;
  final int classroomId;
  final int groupId;
  final int subjectId;
  final String title;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final DateTime date;
  final String? comment;

  LessonRequestModel({
    required this.teacherId,
    required this.classroomId,
    required this.groupId,
    required this.subjectId,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.date,
    this.comment,
  });

  Map<String, dynamic> toJson() => {
    'teacher_id': teacherId,
    'classroom_id': classroomId,
    'student_group_id': groupId,
    'subject_id': subjectId,
    'title': title,
    'start_time': _formatTime(startTime),
    'end_time': _formatTime(endTime),
    'date': _formatDate(date),
    if (comment != null) 'comment': comment,
  };

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
