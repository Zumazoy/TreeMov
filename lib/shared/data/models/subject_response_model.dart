import 'package:treemov/shared/domain/entities/color_entity.dart';
import 'package:treemov/shared/domain/models/base_response_model.dart';

class SubjectResponseModel extends BaseResponseModel {
  final String? name;
  final ColorEntity? color;
  final List<dynamic> teacher;

  SubjectResponseModel({
    required super.baseData,
    required this.name,
    required this.color,
    required this.teacher,
  });

  factory SubjectResponseModel.fromJson(Map<String, dynamic> json) {
    return SubjectResponseModel(
      baseData: json.baseData,
      name: json['name'],
      color: json['color'] != null && json['color'] is Map<String, dynamic>
          ? ColorEntity.fromJson(json['color'])
          : null,
      teacher: json['teacher'] is List ? List<int>.from(json['teacher']) : [],
    );
  }
}
