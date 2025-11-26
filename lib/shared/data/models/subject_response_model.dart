import 'package:treemov/shared/data/models/color_response_model.dart';
import 'package:treemov/shared/domain/models/base_response_model.dart';

class SubjectResponseModel extends BaseResponseModel {
  final String? name;
  final ColorResponseModel? color;
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
          ? ColorResponseModel.fromJson(json['color'])
          : null,
      teacher: json['teacher'] is List ? List<int>.from(json['teacher']) : [],
    );
  }
}
