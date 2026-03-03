import 'package:treemov/shared/data/models/classroom_response_model.dart';
import 'package:treemov/shared/data/models/student_group_response_model.dart';
import 'package:treemov/shared/data/models/subject_response_model.dart';
import 'package:treemov/shared/data/models/teacher_response_model.dart';
import 'package:treemov/shared/domain/models/base_response_model.dart';

class PeriodLessonResponseModel extends BaseResponseModel {
  final String? title;
  final String? startTime;
  final String? endTime;
  final int? period;
  final String? repeatLessonsUntilDate;
  final String? startDate;
  final TeacherResponseModel? teacher;
  final ClassroomResponseModel? classroom;
  final GroupStudentsResponseModel? group;
  final SubjectResponseModel? subject;

  PeriodLessonResponseModel({
    required super.baseData,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.period,
    required this.repeatLessonsUntilDate,
    required this.startDate,
    required this.teacher,
    required this.classroom,
    required this.group,
    required this.subject,
  });

  factory PeriodLessonResponseModel.fromJson(Map<String, dynamic> json) {
    return PeriodLessonResponseModel(
      baseData: json.baseData,
      title: json['title'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      period: json['period'],
      repeatLessonsUntilDate: json['repeat_lessons_until_date'],
      startDate: json['start_date'],
      teacher: json['teacher'] != null
          ? TeacherResponseModel.fromJson(json['teacher'])
          : null,
      classroom: json['classroom'] != null
          ? ClassroomResponseModel.fromJson(json['classroom'])
          : null,
      group: json['student_group'] != null
          ? GroupStudentsResponseModel.fromJson(json['student_group'])
          : null,
      subject: json['subject'] != null
          ? SubjectResponseModel.fromJson(json['subject'])
          : null,
    );
  }
}
