import 'package:treemov/shared/data/models/student_response_model.dart';
import 'package:treemov/shared/data/models/teacher_response_model.dart';

class AccrualResponseModel {
  final int id;
  final int amount;
  final String comment;
  final TeacherResponseModel? teacher;
  final StudentResponseModel? student;
  final String category;

  AccrualResponseModel({
    required this.id,
    required this.amount,
    required this.comment,
    this.teacher,
    this.student,
    required this.category,
  });

  factory AccrualResponseModel.fromJson(Map<String, dynamic> json) {
    TeacherResponseModel? parseTeacher() {
      try {
        if (json['teacher'] != null && json['teacher'] is Map) {
          return TeacherResponseModel.fromJson(
            Map<String, dynamic>.from(json['teacher']),
          );
        }
      } catch (e) {
        print('⚠️ Ошибка парсинга teacher: $e');
      }
      return null;
    }

    StudentResponseModel? parseStudent() {
      try {
        if (json['student'] != null && json['student'] is Map) {
          return StudentResponseModel.fromJson(
            Map<String, dynamic>.from(json['student']),
          );
        }
      } catch (e) {
        print('⚠️ Ошибка парсинга student: $e');
      }
      return null;
    }

    return AccrualResponseModel(
      id: json['id'] ?? 0,
      amount: json['amount'] ?? 0,
      comment: json['comment']?.toString() ?? '',
      teacher: parseTeacher(),
      student: parseStudent(),
      category: json['category']?.toString() ?? '',
    );
  }
}
