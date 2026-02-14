import 'package:treemov/shared/domain/models/base_response_model.dart';

class RoleResponseModel extends BaseResponseModel {
  final String? title;
  final String? code;

  RoleResponseModel({
    required super.baseData,
    required this.title,
    required this.code,
  });

  factory RoleResponseModel.fromJson(Map<String, dynamic> json) {
    return RoleResponseModel(
      baseData: json.baseData,
      title: json['title'],
      code: json['code'],
    );
  }
}
