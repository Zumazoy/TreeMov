import 'package:treemov/shared/domain/models/base_response_model.dart';

class StudentGroupResponseModel extends BaseResponseModel {
  final String? title;

  StudentGroupResponseModel({required super.baseData, required this.title});

  factory StudentGroupResponseModel.fromJson(Map<String, dynamic> json) {
    return StudentGroupResponseModel(
      baseData: json.baseData,
      title: json['title'],
    );
  }
}
