import 'package:treemov/core/constants/api_constants.dart';
import 'package:treemov/core/network/base/base_remote_data_source.dart';
import 'package:treemov/core/storage/secure_storage_repository.dart';
import 'package:treemov/features/teacher_calendar/data/models/attendance_request_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/attendance_response_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/lesson_request_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/period_lesson_request_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/period_lesson_response_model.dart';
import 'package:treemov/shared/data/models/classroom_response_model.dart';
import 'package:treemov/shared/data/models/lesson_response_model.dart';
import 'package:treemov/shared/data/models/subject_response_model.dart';
import 'package:treemov/shared/data/models/teacher_response_model.dart';

class ScheduleRemoteDataSource extends BaseRemoteDataSource {
  final SecureStorageRepository _secureStorageRepository;

  ScheduleRemoteDataSource(super.dioClient, this._secureStorageRepository);

  Future<List<AttendanceResponseModel>> getAttendance(int lessonId) {
    return getList(
      path: ApiConstants.attendances,
      fromJson: AttendanceResponseModel.fromJson,
      queryParameters: {'lesson_id': lessonId},
    );
  }

  Future<List<ClassroomResponseModel>> getClassrooms() {
    return getList(
      path: ApiConstants.classrooms,
      fromJson: ClassroomResponseModel.fromJson,
    );
  }

  Future<List<SubjectResponseModel>> getSubjects() {
    return getList(
      path: ApiConstants.subjects,
      fromJson: SubjectResponseModel.fromJson,
    );
  }

  Future<int?> getTeacherId() async {
    final orgMemberID = await _secureStorageRepository.getOrgMemberId();
    final teachers = await getList(
      path: ApiConstants.teachers,
      fromJson: TeacherResponseModel.fromJson,
      queryParameters: {'employee__org_member_id': orgMemberID},
    );
    return teachers.isNotEmpty ? teachers.first.id : null;
  }

  Future<LessonResponseModel> createLesson(LessonRequestModel request) {
    return post(
      path: ApiConstants.lessons,
      fromJson: LessonResponseModel.fromJson,
      data: request.toJson(),
    );
  }

  Future<PeriodLessonResponseModel> createPeriodLesson(
    PeriodLessonRequestModel request,
  ) {
    return post(
      path: ApiConstants.periodLessons,
      fromJson: PeriodLessonResponseModel.fromJson,
      data: request.toJson(),
    );
  }

  Future<AttendanceResponseModel> createMassAttendance(
    List<AttendanceRequestModel> request,
  ) {
    return post(
      path: '${ApiConstants.attendances}/batch',
      fromJson: AttendanceResponseModel.fromJson,
      data: request.map((r) => r.toJson()).toList(),
    );
  }

  Future<AttendanceResponseModel> patchMassAttendance(
    int id,
    AttendanceRequestModel request,
  ) {
    return patch(
      path: '${ApiConstants.attendances}/$id',
      fromJson: AttendanceResponseModel.fromJson,
      data: request.toJson(),
    );
  }
}
