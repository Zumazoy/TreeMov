import 'package:treemov/shared/data/models/employer_response_model.dart';
import 'package:treemov/shared/domain/models/base_response_model.dart';

class TeacherResponseModel extends BaseResponseModel {
  final EmployerResponseModel employer;

  TeacherResponseModel({required super.baseData, required this.employer});

  factory TeacherResponseModel.fromJson(Map<String, dynamic> json) {
    return TeacherResponseModel(
      baseData: json.baseData,
      employer: EmployerResponseModel.fromJson(json['employer']),
    );
  }
}
