import 'package:treemov/features/teacher_calendar/data/datasources/schedule_remote_data_source.dart';
import 'package:treemov/features/teacher_calendar/data/models/schedule_request_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/schedule_response_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/schedule_update_model.dart';
import 'package:treemov/features/teacher_calendar/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleRemoteDataSource _remoteDataSource;

  ScheduleRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<ScheduleResponseModel>> getAllSchedules() async {
    return await _remoteDataSource.getAllSchedules();
  }

  @override
  Future<ScheduleResponseModel> getScheduleById(int scheduleId) async {
    return await _remoteDataSource.getScheduleById(scheduleId);
  }

  @override
  Future<ScheduleResponseModel> createSchedule(
    ScheduleRequestModel request,
  ) async {
    return await _remoteDataSource.createSchedule(request);
  }

  @override
  Future<ScheduleResponseModel> updateSchedule({
    required int scheduleId,
    required ScheduleUpdateModel updateData,
  }) async {
    return await _remoteDataSource.updateSchedule(
      scheduleId: scheduleId,
      updateData: updateData,
    );
  }
}
