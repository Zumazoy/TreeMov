import 'package:treemov/shared/domain/entities/color_entity.dart';

class SubjectResponseModel {
  final int id;
  final int? org;
  final int? createdBy;
  final String? createdAt;
  final String? name;
  final ColorEntity? color;
  final List<dynamic> teacher;

  SubjectResponseModel({
    required this.id,
    required this.org,
    required this.createdBy,
    required this.createdAt,
    required this.name,
    required this.color,
    required this.teacher,
  });

  factory SubjectResponseModel.fromJson(Map<String, dynamic> json) {
    return SubjectResponseModel(
      id: json['id'] ?? 0,
      org: json['org'] ?? 0,
      createdBy: json['created_by'] ?? 0,
      createdAt: json['created_at'],
      name: json['name'],
      color: json['color'] != null && json['color'] is Map<String, dynamic>
          ? ColorEntity.fromJson(json['color'])
          : null,
      teacher: json['teacher'] is List ? List<int>.from(json['teacher']) : [],
    );
  }
}
