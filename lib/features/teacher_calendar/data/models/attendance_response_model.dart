import 'package:treemov/shared/data/models/lesson_response_model.dart';
import 'package:treemov/shared/data/models/student_response_model.dart';
import 'package:treemov/shared/domain/models/base_response_model.dart';

class AttendanceResponseModel extends BaseResponseModel {
  final bool? wasPresent;
  final String? comment;
  final StudentResponseModel? student;
  final LessonResponseModel? lesson;

  AttendanceResponseModel({
    required super.baseData,
    required this.wasPresent,
    required this.comment,
    required this.student,
    required this.lesson,
  });

  factory AttendanceResponseModel.fromJson(Map<String, dynamic> json) {
    return AttendanceResponseModel(
      baseData: json.baseData,
      wasPresent: json['was_present'],
      comment: json['comment'],
      student: json['student'] != null
          ? StudentResponseModel.fromJson(json['student'])
          : null,
      lesson: json['lesson'] != null
          ? LessonResponseModel.fromJson(json['lesson'])
          : null,
    );
  }
}
