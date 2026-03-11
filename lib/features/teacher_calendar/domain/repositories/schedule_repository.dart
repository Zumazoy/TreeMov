import 'package:treemov/features/teacher_calendar/data/models/attendance_request_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/attendance_response_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/lesson_request_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/period_lesson_request_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/period_lesson_response_model.dart';
import 'package:treemov/shared/data/models/classroom_response_model.dart';
import 'package:treemov/shared/data/models/lesson_response_model.dart';
import 'package:treemov/shared/data/models/subject_response_model.dart';

abstract class ScheduleRepository {
  Future<List<AttendanceResponseModel>> getAttendance(int lessonId);
  Future<List<ClassroomResponseModel>> getClassrooms();
  Future<List<SubjectResponseModel>> getSubjects();
  Future<int?> getTeacherId();
  Future<LessonResponseModel> createLesson(LessonRequestModel request);
  Future<PeriodLessonResponseModel> createPeriodLesson(
    PeriodLessonRequestModel request,
  );
  Future<AttendanceResponseModel> createMassAttendance(
    List<AttendanceRequestModel> request,
  );
  Future<AttendanceResponseModel> patchMassAttendance(
    int id,
    AttendanceRequestModel request,
  );
}
