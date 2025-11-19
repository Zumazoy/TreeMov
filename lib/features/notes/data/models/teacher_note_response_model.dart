import 'package:flutter/material.dart';
import 'package:treemov/shared/data/models/teacher_response_model.dart';
import 'package:treemov/shared/domain/models/base_response_model.dart';

class TeacherNoteResponseModel extends BaseResponseModel {
  final String? title;
  final String? text;
  final String? category;
  final int? org;
  final int? createdBy;
  final int? teacherProfile;
  final TeacherResponseModel? teacher;
  TeacherNoteResponseModel({
    required super.baseData,
    required this.title,
    required this.text,
    required this.category,
    required this.org,
    required this.createdBy,
    required this.teacherProfile,
    required this.teacher,
  });

  factory TeacherNoteResponseModel.fromJson(Map<String, dynamic> json) {
    final teacherJson = json['teacher_profile'];

    int? teacherProfileId;
    TeacherResponseModel? teacherObj;

    if (teacherJson != null) {
      if (teacherJson is int) {
        teacherProfileId = teacherJson;
      } else if (teacherJson is Map<String, dynamic>) {
        try {
          teacherObj = TeacherResponseModel.fromJson(teacherJson);
        } catch (e) {
          debugPrint('===ERROR=== parsing teacher_profile object: $e');
        }
        if (teacherJson.containsKey('id')) {
          teacherProfileId = teacherJson['id'];
        }
      }
    }

    return TeacherNoteResponseModel(
      baseData: json.baseData,
      title: json['title'] ?? '',
      text: json['text'] ?? '',
      category: json['category'] ?? '',
      org: json['org'] ?? json.baseData.org,
      createdBy: json['created_by'] ?? json.baseData.createdBy,
      teacherProfile:
          teacherProfileId ??
          (json['teacher_profile'] is int ? json['teacher_profile'] : null),
      teacher: teacherObj,
    );
  }

  String get formattedCreatedDate {
    try {
      final createdAt = baseData.createdAt;
      if (createdAt == null || createdAt.isEmpty) return '';
      final datePart = createdAt.split('T').first;
      final parts = datePart.split('-');
      if (parts.length == 3) {
        return '${parts[2]}.${parts[1]}.${parts[0]}';
      }
      return datePart;
    } catch (e) {
      debugPrint(
        "===ERROR=== on get formattedCreatedDate: ${baseData.createdAt} — $e",
      );
      return baseData.createdAt ?? '';
    }
  }

  String get shortSummary {
    final t = title ?? '';
    final d = formattedCreatedDate;
    return [t, d].where((s) => s.isNotEmpty).join(' — ');
  }

  String get teacherFullName {
    if (teacher == null) return '';
    final surname = teacher?.employer?.surname;
    final name = teacher?.employer?.name;
    final patronymic = teacher?.employer?.patronymic;
    return [
      surname,
      name,
      patronymic,
    ].where((s) => s != null && s.isNotEmpty).join(' ');
  }
}
