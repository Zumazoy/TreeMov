import 'package:treemov/features/teacher_calendar/data/models/period_schedule_response_model.dart';
import 'package:treemov/shared/data/models/classroom_response_model.dart';
import 'package:treemov/shared/data/models/student_group_response_model.dart';
import 'package:treemov/shared/data/models/subject_response_model.dart';

abstract class SharedRepository {
  Future<int?> getTeacherId();
  Future<List<SubjectResponseModel>> getSubjects();
  Future<List<StudentGroupResponseModel>> getStudentGroups();
  Future<List<ClassroomResponseModel>> getClassrooms();
  Future<List<PeriodScheduleResponseModel>> getPeriodSchedules();
}
