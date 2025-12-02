import 'package:treemov/shared/data/models/teacher_response_model.dart';
import 'package:treemov/shared/domain/models/base_response_model.dart';

class TeacherProfileResponseModel extends BaseResponseModel {
  final int? user;
  final TeacherResponseModel? teacher;

  TeacherProfileResponseModel({
    required super.baseData,
    required this.user,
    required this.teacher,
  });

  factory TeacherProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return TeacherProfileResponseModel(
      baseData: json.baseData,
      user: json['user'],
      teacher: TeacherResponseModel.fromJson(json['teacher']),
    );
  }
}
