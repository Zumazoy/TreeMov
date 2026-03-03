import 'package:treemov/shared/data/models/student_response_model.dart';
import 'package:treemov/shared/data/models/teacher_response_model.dart';

class AccrualResponseModel {
  final int id;
  final int amount;
  final String comment;
  final TeacherResponseModel? teacher;
  final StudentResponseModel? student;
  final String category;
  final DateTime createdAt;

  AccrualResponseModel({
    required this.id,
    required this.amount,
    required this.comment,
    this.teacher,
    this.student,
    required this.category,
    required this.createdAt,
  });

  factory AccrualResponseModel.fromJson(Map<String, dynamic> json) {
    return AccrualResponseModel(
      id: json['id'] ?? 0,
      amount: json['amount'] ?? 0,
      comment: json['comment'] ?? '',
      teacher: json['teacher'] != null && json['teacher'] is Map
          ? TeacherResponseModel.fromJson(json['teacher'])
          : null,
      student: json['student'] != null && json['student'] is Map
          ? StudentResponseModel.fromJson(json['student'])
          : null,
      category: json['category'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at']) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}
