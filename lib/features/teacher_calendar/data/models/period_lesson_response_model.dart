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
  final SubjectResponseModel? subject;
  final StudentGroupResponseModel? group;
  final ClassroomResponseModel? classroom;

  PeriodLessonResponseModel({
    required super.baseData,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.period,
    required this.repeatLessonsUntilDate,
    required this.startDate,
    required this.teacher,
    required this.subject,
    required this.group,
    required this.classroom,
  });

  factory PeriodLessonResponseModel.fromJson(Map<String, dynamic> json) {
    final teacherJson = json['teacher'];
    final subjectJson = json['subject'];
    final groupJson = json['group'];
    final classroomJson = json['classroom'];

    return PeriodLessonResponseModel(
      baseData: json.baseData,
      title: json['title'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      period: json['period'],
      repeatLessonsUntilDate: json['repeat_lessons_until_date'],
      startDate: json['start_date'],
      teacher: teacherJson != null && teacherJson is Map<String, dynamic>
          ? TeacherResponseModel.fromJson(teacherJson)
          : null,
      subject: subjectJson != null && subjectJson is Map<String, dynamic>
          ? SubjectResponseModel.fromJson(subjectJson)
          : null,
      group: groupJson != null && groupJson is Map<String, dynamic>
          ? StudentGroupResponseModel.fromJson(groupJson)
          : null,
      classroom: classroomJson != null && classroomJson is Map<String, dynamic>
          ? ClassroomResponseModel.fromJson(classroomJson)
          : null,
    );
  }
}
