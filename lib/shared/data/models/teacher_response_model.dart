import 'package:treemov/shared/domain/entities/employer_entity.dart';
import 'package:treemov/shared/domain/models/base_response_model.dart';

class TeacherResponseModel extends BaseResponseModel {
  final EmployerEntity employer;

  TeacherResponseModel({required super.baseData, required this.employer});

  factory TeacherResponseModel.fromJson(Map<String, dynamic> json) {
    return TeacherResponseModel(
      baseData: json.baseData,
      employer: EmployerEntity.fromJson(json['employer']),
    );
  }
}
