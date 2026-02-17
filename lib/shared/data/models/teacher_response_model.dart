import 'package:treemov/shared/data/models/employee_response_model.dart';
import 'package:treemov/shared/domain/models/base_response_model.dart';

class TeacherResponseModel extends BaseResponseModel {
  final EmployeeResponseModel employee;

  TeacherResponseModel({required super.baseData, required this.employee});

  factory TeacherResponseModel.fromJson(Map<String, dynamic> json) {
    return TeacherResponseModel(
      baseData: json.baseData,
      employee: EmployeeResponseModel.fromJson(json['employee']),
    );
  }
}
