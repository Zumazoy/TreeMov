import 'package:treemov/core/constants/api_constants.dart';
import 'package:treemov/core/network/dio_client.dart';
import 'package:treemov/features/teacher_calendar/data/models/attendance_request_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/attendance_response_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/period_lesson_request_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/period_lesson_response_model.dart';
import 'package:treemov/shared/data/models/lesson_request_model.dart';
import 'package:treemov/shared/data/models/lesson_response_model.dart';

class ScheduleRemoteDataSource {
  final DioClient _dioClient;

  ScheduleRemoteDataSource(this._dioClient);

  Future<LessonResponseModel> getLessonById(int scheduleId) async {
    try {
      final response = await _dioClient.get(
        '${ApiConstants.scheduleP + ApiConstants.lessons}$scheduleId/',
      );

      if (response.statusCode == 200) {
        return LessonResponseModel.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch schedule: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка получения занятия: $e');
    }
  }

  Future<LessonResponseModel> createLesson(LessonRequestModel request) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.scheduleP + ApiConstants.lessons,
        data: request.toJson(),
      );

      if (response.statusCode == 201) {
        return LessonResponseModel.fromJson(response.data);
      } else {
        throw Exception('Ошибка создания занятия: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка создания занятия: $e');
    }
  }

  Future<PeriodLessonResponseModel> createPeriodLesson(
    PeriodLessonRequestModel request,
  ) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.scheduleP + ApiConstants.periodLessons,
        data: request.toJson(),
      );

      if (response.statusCode == 201) {
        return PeriodLessonResponseModel.fromJson(response.data);
      } else {
        throw Exception(
          'Ошибка создания периодического занятия: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Ошибка создания периодического занятия: $e');
    }
  }

  Future<AttendanceResponseModel> createAttendance(
    AttendanceRequestModel request,
  ) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.scheduleP + ApiConstants.attendances,
        data: request.toJson(),
      );

      if (response.statusCode == 201) {
        return AttendanceResponseModel.fromJson(response.data);
      } else {
        throw Exception('Ошибка создания посещаемости: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка создания посещаемости: $e');
    }
  }

  // Future<ScheduleResponseModel> updateSchedule({
  //   required int scheduleId,
  //   required ScheduleUpdateModel updateData,
  // }) async {
  //   try {
  //     final response = await _dioClient.patch(
  //       '${ApiConstants.schedule + ApiConstants.lessons}$scheduleId/',
  //       data: updateData.toJson(),
  //     );

  //     if (response.statusCode == 200) {
  //       return ScheduleResponseModel.fromJson(response.data);
  //     } else {
  //       throw Exception('Failed to update schedule: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Ошибка обновления занятия: $e');
  //   }
  // }
}
