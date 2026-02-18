import 'package:treemov/shared/data/models/student_response_model.dart';
import 'package:treemov/shared/data/models/teacher_response_model.dart';

class AccrualResponseModel {
  final int id;
  final int amount;
  final String comment;
  final TeacherResponseModel teacher;
  final StudentResponseModel student;
  final String category;

  AccrualResponseModel({
    required this.id,
    required this.amount,
    required this.comment,
    required this.teacher,
    required this.student,
    required this.category,
  });

  factory AccrualResponseModel.fromJson(Map<String, dynamic> json) {
    return AccrualResponseModel(
      id: json['id'] ?? 0,
      amount: json['amount'] ?? 0,
      comment: json['comment'] ?? '',
      teacher: json['teacher'] != null
          ? TeacherResponseModel.fromJson(json['teacher'])
          : TeacherResponseModel.fromJson({}),
      student: json['student'] != null
          ? StudentResponseModel.fromJson(json['student'])
          : StudentResponseModel.fromJson({}),
      category: json['category'] ?? '',
    );
  }
}
