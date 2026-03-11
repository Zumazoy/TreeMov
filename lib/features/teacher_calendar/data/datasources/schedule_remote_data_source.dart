import 'package:dio/dio.dart';
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

  Future<List<AttendanceResponseModel>> getAttendance(int lessonId) async {
    try {
      final Response response = await _dioClient.get(
        ApiConstants.attendances,
        queryParameters: {'lesson_id': lessonId},
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is List) {
          return responseData
              .map<AttendanceResponseModel>(
                (json) => AttendanceResponseModel.fromJson(json),
              )
              .toList();
        } else if (responseData is Map<String, dynamic>) {
          return [AttendanceResponseModel.fromJson(responseData)];
        } else {
          throw Exception('Некорректный формат ответа от сервера');
        }
      } else {
        throw Exception('Ошибка сервера: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка загрузки посещаемости: $e');
    }
  }

  Future<LessonResponseModel> createLesson(LessonRequestModel request) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.lessons,
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
        ApiConstants.periodLessons,
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

  Future<AttendanceResponseModel> createMassAttendance(
    List<AttendanceRequestModel> request,
  ) async {
    try {
      final response = await _dioClient.post(
        '${ApiConstants.attendances}/batch',
        data: request.map((r) => r.toJson()).toList(),
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

  Future<AttendanceResponseModel> patchMassAttendance(
    int id,
    AttendanceRequestModel request,
  ) async {
    try {
      final response = await _dioClient.patch(
        '${ApiConstants.attendances}/$id',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return AttendanceResponseModel.fromJson(response.data);
      } else {
        throw Exception(
          'Ошибка обновления посещаемости: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Ошибка обновления посещаемости: $e');
    }
  }
}
