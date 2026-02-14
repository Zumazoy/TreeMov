import 'package:treemov/shared/domain/models/base_response_model.dart';

class ClassroomResponseModel extends BaseResponseModel {
  final String? title;
  final int? floor;
  final String? building;

  ClassroomResponseModel({
    required super.baseData,
    required this.title,
    required this.floor,
    required this.building,
  });

  factory ClassroomResponseModel.fromJson(Map<String, dynamic> json) {
    return ClassroomResponseModel(
      baseData: json.baseData,
      title: json['title'],
      floor: json['floor'],
      building: json['building'],
    );
  }
}
