import 'package:treemov/shared/domain/models/base_response_model.dart';

class SubjectResponseModel extends BaseResponseModel {
  final String? title;
  final String? color;

  SubjectResponseModel({
    required super.baseData,
    required this.title,
    required this.color,
  });

  factory SubjectResponseModel.fromJson(Map<String, dynamic> json) {
    return SubjectResponseModel(
      baseData: json.baseData,
      title: json['title'],
      color: json['color'],
    );
  }
}
