// import 'package:injectable/injectable.dart';
// import 'package:treemov/features/teacher_calendar/data/datasources/schedule_remote_data_source.dart';
// import 'package:treemov/features/teacher_calendar/data/models/create_schedule_request.dart';
// import 'package:treemov/features/teacher_calendar/domain/entities/schedule_entity.dart';
// import 'package:treemov/features/teacher_calendar/domain/repositories/schedule_repository.dart';

// @injectable
// class ScheduleRepositoryImpl implements ScheduleRepository {
//   final ScheduleRemoteDataSource _remoteDataSource;

//   ScheduleRepositoryImpl(this._remoteDataSource);

//   @override
//   Future<List<ScheduleEntity>> getSchedules({String? token}) async {
//     final models = await _remoteDataSource.fetchSchedules(token: token);
//     return models.map((model) => model.toEntity()).toList();
//   }

//   @override
//   Future<void> createSchedule(ScheduleEntity schedule) async {
//     final request = CreateScheduleRequest.fromEntity(schedule);
//     await _remoteDataSource.createSchedule(request);
//   }
// }
