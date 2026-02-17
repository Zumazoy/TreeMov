import 'package:treemov/shared/data/models/student_group_response_model.dart';
import 'package:treemov/shared/data/models/student_response_model.dart';
import 'package:treemov/shared/domain/models/base_response_model.dart';

class StudentInGroupResponseModel extends BaseResponseModel {
  final StudentResponseModel student;
  final GroupStudentsResponseModel studentGroup;
  final List<StudentResponseModel>? students;

  StudentInGroupResponseModel({
    required super.baseData,
    required this.student,
    required this.studentGroup,
    this.students,
  });

  factory StudentInGroupResponseModel.fromJson(Map<String, dynamic> json) {
    return StudentInGroupResponseModel(
      baseData: json.baseData,
      student: StudentResponseModel.fromJson(json['student']),
      studentGroup: GroupStudentsResponseModel.fromJson(json['student_group']),
    );
  }
}
