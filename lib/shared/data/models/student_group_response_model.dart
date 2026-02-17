import 'package:treemov/shared/domain/models/base_response_model.dart';

class GroupStudentsResponseModel extends BaseResponseModel {
  final String? title;

  GroupStudentsResponseModel({required super.baseData, required this.title});

  factory GroupStudentsResponseModel.fromJson(Map<String, dynamic> json) {
    return GroupStudentsResponseModel(
      baseData: json.baseData,
      title: json['title'],
    );
  }
}
