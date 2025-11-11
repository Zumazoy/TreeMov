import 'package:treemov/shared/domain/models/base_response_model.dart';

class ClassroomResponseModel extends BaseResponseModel {
  final String? title;
  final String? building;
  final int? floor;

  ClassroomResponseModel({
    required super.baseData,
    required this.title,
    required this.building,
    required this.floor,
  });

  factory ClassroomResponseModel.fromJson(Map<String, dynamic> json) {
    return ClassroomResponseModel(
      baseData: json.baseData,
      title: json['title'],
      building: json['building'],
      floor: json['floor'],
    );
  }
}
