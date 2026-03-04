import 'package:treemov/shared/data/models/student_response_model.dart';
import 'package:treemov/shared/data/models/teacher_response_model.dart';
import 'package:treemov/shared/domain/models/base_response_model.dart';

class AccrualResponseModel extends BaseResponseModel {
  final int? amount;
  final String? comment;
  final String? category;
  final TeacherResponseModel? teacher;
  final StudentResponseModel? student;

  AccrualResponseModel({
    required super.baseData,
    required this.amount,
    required this.comment,
    required this.category,
    required this.teacher,
    required this.student,
  });

  factory AccrualResponseModel.fromJson(Map<String, dynamic> json) {
    return AccrualResponseModel(
      baseData: json.baseData,
      amount: json['amount'],
      comment: json['comment'],
      category: json['category'],
      teacher: json['teacher'] != null
          ? TeacherResponseModel.fromJson(json['teacher'])
          : null,
      student: json['student'] != null
          ? StudentResponseModel.fromJson(json['student'])
          : null,
    );
  }
}
