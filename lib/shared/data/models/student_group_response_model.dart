import 'package:treemov/shared/data/models/student_response_model.dart';
import 'package:treemov/shared/domain/models/base_response_model.dart';

class StudentGroupResponseModel extends BaseResponseModel {
  final String? title;
  final List<StudentResponseModel>? students; // Добавляем список студентов

  StudentGroupResponseModel({
    required super.baseData,
    required this.title,
    required this.students,
  });

  factory StudentGroupResponseModel.fromJson(Map<String, dynamic> json) {
    // Обрабатываем students, если они есть в JSON
    List<StudentResponseModel>? studentsList;
    if (json['students'] != null) {
      studentsList = (json['students'] as List)
          .map((studentJson) => StudentResponseModel.fromJson(studentJson))
          .toList();
    }

    return StudentGroupResponseModel(
      baseData: json.baseData,
      title: json['title'],
      students: studentsList,
    );
  }
}
