import 'package:treemov/features/teacher_calendar/data/models/attendance_request_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/attendance_response_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/period_schedule_request_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/period_schedule_response_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/schedule_request_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/schedule_response_model.dart';

abstract class ScheduleRepository {
  Future<List<ScheduleResponseModel>> getAllSchedules();
  Future<ScheduleResponseModel> getScheduleById(int scheduleId);
  Future<ScheduleResponseModel> createSchedule(ScheduleRequestModel request);
  Future<PeriodScheduleResponseModel> createPeriodSchedule(
    PeriodScheduleRequestModel request,
  );
  Future<AttendanceResponseModel> createAttendance(
    AttendanceRequestModel request,
  );
  // Future<ScheduleResponseModel> updateSchedule({
  //   required int scheduleId,
  //   required ScheduleUpdateModel updateData,
  // });
}
