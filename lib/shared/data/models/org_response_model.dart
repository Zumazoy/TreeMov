import 'package:treemov/shared/domain/models/base_response_model.dart';

class OrgResponseModel extends BaseResponseModel {
  final String? title;

  OrgResponseModel({required super.baseData, required this.title});

  factory OrgResponseModel.fromJson(Map<String, dynamic> json) {
    return OrgResponseModel(baseData: json.baseData, title: json['title']);
  }
}
