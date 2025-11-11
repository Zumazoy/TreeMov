import 'package:treemov/shared/domain/entities/employer_entity.dart';

class TeacherResponseModel {
  final int id;
  final int? org;
  final int? createdBy;
  final String? createdAt;
  final EmployerEntity employer;

  TeacherResponseModel({
    required this.id,
    required this.org,
    required this.createdBy,
    required this.createdAt,
    required this.employer,
  });

  factory TeacherResponseModel.fromJson(Map<String, dynamic> json) {
    return TeacherResponseModel(
      id: json['id'] ?? 0,
      org: json['org'] ?? 0,
      createdBy: json['created_by'] ?? 0,
      createdAt: json['created_at'],
      employer: EmployerEntity.fromJson(json['employer']),
    );
  }
}
