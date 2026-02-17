import 'package:treemov/features/teacher_calendar/data/datasources/schedule_remote_data_source.dart';
import 'package:treemov/features/teacher_calendar/data/models/attendance_request_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/attendance_response_model.dart';
import 'package:treemov/features/teacher_calendar/domain/repositories/schedule_repository.dart';
import 'package:treemov/shared/data/models/lesson_request_model.dart';
import 'package:treemov/shared/data/models/lesson_response_model.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleRemoteDataSource _remoteDataSource;

  ScheduleRepositoryImpl(this._remoteDataSource);

  @override
  Future<LessonResponseModel> getLessonById(int scheduleId) async {
    return await _remoteDataSource.getLessonById(scheduleId);
  }

  @override
  Future<LessonResponseModel> createLesson(LessonRequestModel request) async {
    return await _remoteDataSource.createLesson(request);
  }

  // @override
  // Future<PeriodLessonResponseModel> createPeriodLesson(
  //   PeriodLessonRequestModel request,
  // ) async {
  //   return await _remoteDataSource.createPeriodLesson(request);
  // }

  @override
  Future<AttendanceResponseModel> createAttendance(
    AttendanceRequestModel request,
  ) async {
    return await _remoteDataSource.createAttendance(request);
  }

  // @override
  // Future<ScheduleResponseModel> updateSchedule({
  //   required int scheduleId,
  //   required ScheduleUpdateModel updateData,
  // }) async {
  //   return await _remoteDataSource.updateSchedule(
  //     scheduleId: scheduleId,
  //     updateData: updateData,
  //   );
  // }
}
