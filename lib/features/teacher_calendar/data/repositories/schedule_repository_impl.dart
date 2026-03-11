import 'package:treemov/features/teacher_calendar/data/datasources/schedule_remote_data_source.dart';
import 'package:treemov/features/teacher_calendar/data/models/attendance_request_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/attendance_response_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/lesson_request_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/period_lesson_request_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/period_lesson_response_model.dart';
import 'package:treemov/features/teacher_calendar/domain/repositories/schedule_repository.dart';
import 'package:treemov/shared/data/models/classroom_response_model.dart';
import 'package:treemov/shared/data/models/lesson_response_model.dart';
import 'package:treemov/shared/data/models/subject_response_model.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleRemoteDataSource _remoteDataSource;

  ScheduleRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<AttendanceResponseModel>> getAttendance(int lessonId) async {
    return await _remoteDataSource.getAttendance(lessonId);
  }

  @override
  Future<List<ClassroomResponseModel>> getClassrooms() async {
    return await _remoteDataSource.getClassrooms();
  }

  @override
  Future<List<SubjectResponseModel>> getSubjects() async {
    return await _remoteDataSource.getSubjects();
  }

  @override
  Future<int?> getTeacherId() async {
    return await _remoteDataSource.getTeacherId();
  }

  @override
  Future<LessonResponseModel> createLesson(LessonRequestModel request) async {
    return await _remoteDataSource.createLesson(request);
  }

  @override
  Future<PeriodLessonResponseModel> createPeriodLesson(
    PeriodLessonRequestModel request,
  ) async {
    return await _remoteDataSource.createPeriodLesson(request);
  }

  @override
  Future<AttendanceResponseModel> createMassAttendance(
    List<AttendanceRequestModel> request,
  ) async {
    return await _remoteDataSource.createMassAttendance(request);
  }

  @override
  Future<AttendanceResponseModel> patchMassAttendance(
    int id,
    AttendanceRequestModel request,
  ) async {
    return await _remoteDataSource.patchMassAttendance(id, request);
  }
}
