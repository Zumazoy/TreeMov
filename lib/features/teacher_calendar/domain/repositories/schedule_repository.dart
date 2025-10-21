import 'package:treemov/features/teacher_calendar/data/models/schedule_request_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/schedule_response_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/schedule_update_model.dart';

abstract class ScheduleRepository {
  Future<List<ScheduleResponseModel>> getAllSchedules();
  Future<ScheduleResponseModel> getScheduleById(int scheduleId);
  Future<ScheduleResponseModel> createSchedule(ScheduleRequestModel request);
  Future<ScheduleResponseModel> updateSchedule({
    required int scheduleId,
    required ScheduleUpdateModel updateData,
  });
  // Future<void> deleteSchedule(String id);
}
