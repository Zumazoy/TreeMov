import 'package:treemov/shared/domain/models/base_response_model.dart';

class AttendanceResponseModel extends BaseResponseModel {
  final String? lessonDate;
  final bool? wasPresent;
  final int? student;
  final int? lesson;

  AttendanceResponseModel({
    required super.baseData,
    required this.lessonDate,
    required this.wasPresent,
    required this.student,
    required this.lesson,
  });

  factory AttendanceResponseModel.fromJson(Map<String, dynamic> json) {
    return AttendanceResponseModel(
      baseData: json.baseData,
      lessonDate: json['lesson_date'],
      wasPresent: json['was_present'],
      student: json['student'],
      lesson: json['lesson'],
    );
  }
}
