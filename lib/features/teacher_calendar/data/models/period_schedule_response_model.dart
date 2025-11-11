import 'package:treemov/shared/data/models/classroom_response_model.dart';
import 'package:treemov/shared/data/models/student_group_response_model.dart';
import 'package:treemov/shared/data/models/subject_response_model.dart';
import 'package:treemov/shared/data/models/teacher_response_model.dart';
import 'package:treemov/shared/domain/models/base_response_model.dart';

class PeriodScheduleResponseModel extends BaseResponseModel {
  final String? title;
  final String? startTime;
  final String? endTime;
  final String? repeatLessonsUntilDate;
  final String? startDate;
  final int? period;
  final int? lesson;
  final TeacherResponseModel? teacher;
  final SubjectResponseModel? subject;
  final StudentGroupResponseModel? group;
  final ClassroomResponseModel? classroom;

  PeriodScheduleResponseModel({
    required super.baseData,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.repeatLessonsUntilDate,
    required this.startDate,
    required this.period,
    required this.lesson,
    required this.teacher,
    required this.subject,
    required this.group,
    required this.classroom,
  });

  factory PeriodScheduleResponseModel.fromJson(Map<String, dynamic> json) {
    final teacherJson = json['teacher'];
    final subjectJson = json['subject'];
    final groupJson = json['group'];
    final classroomJson = json['classroom'];

    return PeriodScheduleResponseModel(
      baseData: json.baseData,
      title: json['title'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      repeatLessonsUntilDate: json['repeat_lessons_until_date'],
      startDate: json['start_date'],
      period: json['period'],
      lesson: json['lesson'],
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
