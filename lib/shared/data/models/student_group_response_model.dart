import 'package:treemov/shared/domain/entities/student_entity.dart';

class StudentGroupResponseModel {
  final int id;
  final int? org;
  final int? createdBy;
  final String? createdAt;
  final String? name;
  final List<StudentEntity> students;

  StudentGroupResponseModel({
    required this.id,
    required this.org,
    required this.createdBy,
    required this.createdAt,
    required this.name,
    required this.students,
  });

  factory StudentGroupResponseModel.fromJson(Map<String, dynamic> json) {
    List<StudentEntity> studentsList = [];
    if (json['students'] != null && json['students'] is List) {
      studentsList = (json['students'] as List)
          .map((studentJson) => StudentEntity.fromJson(studentJson))
          .toList();
    }

    return StudentGroupResponseModel(
      id: json['id'] ?? 0,
      org: json['org'] ?? 0,
      createdBy: json['created_by'] ?? 0,
      createdAt: json['created_at'],
      name: json['name'],
      students: studentsList,
    );
  }
}
