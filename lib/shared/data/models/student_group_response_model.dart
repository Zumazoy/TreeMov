import 'package:treemov/shared/data/models/student_response_model.dart';
import 'package:treemov/shared/domain/models/base_response_model.dart';

class StudentGroupResponseModel extends BaseResponseModel {
  final String? name;
  final List<StudentResponseModel> students;

  StudentGroupResponseModel({
    required super.baseData,
    required this.name,
    required this.students,
  });

  factory StudentGroupResponseModel.fromJson(Map<String, dynamic> json) {
    List<StudentResponseModel> studentsList = [];
    if (json['students'] != null && json['students'] is List) {
      studentsList = (json['students'] as List)
          .map((studentJson) => StudentResponseModel.fromJson(studentJson))
          .toList();
    }

    return StudentGroupResponseModel(
      baseData: json.baseData,
      name: json['name'],
      students: studentsList,
    );
  }
}
