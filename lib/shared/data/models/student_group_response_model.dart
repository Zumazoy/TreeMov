import 'package:treemov/shared/domain/entities/student_entity.dart';
import 'package:treemov/shared/domain/models/base_response_model.dart';

class StudentGroupResponseModel extends BaseResponseModel {
  final String? name;
  final List<StudentEntity> students;

  StudentGroupResponseModel({
    required super.baseData,
    required this.name,
    required this.students,
  });

  factory StudentGroupResponseModel.fromJson(Map<String, dynamic> json) {
    List<StudentEntity> studentsList = [];
    if (json['students'] != null && json['students'] is List) {
      studentsList = (json['students'] as List)
          .map((studentJson) => StudentEntity.fromJson(studentJson))
          .toList();
    }

    return StudentGroupResponseModel(
      baseData: json.baseData,
      name: json['name'],
      students: studentsList,
    );
  }
}
