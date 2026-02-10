import 'package:treemov/features/teacher_calendar/data/models/attendance_request_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/attendance_response_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/period_lesson_request_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/period_lesson_response_model.dart';
import 'package:treemov/shared/data/models/lesson_request_model.dart';
import 'package:treemov/shared/data/models/lesson_response_model.dart';

abstract class ScheduleRepository {
  Future<LessonResponseModel> getLessonById(int lessonId);
  Future<LessonResponseModel> createLesson(LessonRequestModel request);
  Future<PeriodLessonResponseModel> createPeriodLesson(
    PeriodLessonRequestModel request,
  );
  Future<AttendanceResponseModel> createAttendance(
    AttendanceRequestModel request,
  );
  // Future<ScheduleResponseModel> updateSchedule({
  //   required int scheduleId,
  //   required ScheduleUpdateModel updateData,
  // });
}
