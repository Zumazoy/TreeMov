import 'package:treemov/shared/data/models/student_group_response_model.dart';
import 'package:treemov/shared/data/models/student_response_model.dart';
import 'package:treemov/shared/domain/models/base_response_model.dart';

class StudentGroupMemberResponseModel extends BaseResponseModel {
  final StudentResponseModel student;
  final GroupStudentsResponseModel studentGroup;

  StudentGroupMemberResponseModel({
    required super.baseData,
    required this.student,
    required this.studentGroup,
  });

  factory StudentGroupMemberResponseModel.fromJson(Map<String, dynamic> json) {
    return StudentGroupMemberResponseModel(
      baseData: json.baseData,
      student: StudentResponseModel.fromJson(json['student']),
      studentGroup: GroupStudentsResponseModel.fromJson(json['student_group']),
    );
  }
}
