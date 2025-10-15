import 'package:flutter/material.dart';

class ScheduleEntity {
  final int id;
  final int? classroomId;
  final int? createdById;
  final int? groupId;
  final int orgId;
  final int? periodScheduleId;
  final int teacherId;
  final int? subjectId;
  final int weekDay;
  final int? lesson;
  final String? title;
  final DateTime date;
  final DateTime createdAt;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final Duration duration;
  final bool isCanceled;
  final bool isCompleted;

  ScheduleEntity({
    required this.id,
    required this.classroomId,
    required this.createdById,
    required this.groupId,
    required this.orgId,
    required this.periodScheduleId,
    required this.teacherId,
    required this.subjectId,
    required this.weekDay,
    required this.lesson,
    required this.title,
    required this.date,
    required this.createdAt,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.isCanceled,
    required this.isCompleted,
  });

  // Методы для парсинга из JSON
  factory ScheduleEntity.fromJson(Map<String, dynamic> json) {
    return ScheduleEntity(
      id: json['id'],
      classroomId: json['classroom']?['id'] ?? 0,
      createdById: json['created_by'] ?? 0,
      groupId: json['group']?['id'] ?? 0,
      orgId: json['org'],
      periodScheduleId: json['period_schedule']?['id'],
      teacherId: json['teacher']?['id'] ?? 0,
      subjectId: json['subject']?['id'] ?? 0,
      weekDay: json['week_day'],
      lesson: json['lesson'],
      title: json['title'] ?? '',
      startTime: _parseTime(json['start_time']),
      endTime: _parseTime(json['end_time']),
      date: DateTime.parse(json['date']),
      createdAt: DateTime.parse(json['created_at']),
      duration: _parseDuration(json['duration']),
      isCanceled: json['is_canceled'] ?? false,
      isCompleted: json['is_completed'] ?? false,
    );
  }

  static TimeOfDay _parseTime(String timeString) {
    final parts = timeString.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  static Duration _parseDuration(String durationString) {
    final parts = durationString.split(':');
    return Duration(
      hours: int.parse(parts[0]),
      minutes: int.parse(parts[1]),
      seconds: int.parse(parts[2]),
    );
  }
}
