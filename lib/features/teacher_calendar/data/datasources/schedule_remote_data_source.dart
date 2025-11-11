import 'package:dio/dio.dart';
import 'package:treemov/core/constants/api_constants.dart';
import 'package:treemov/core/network/dio_client.dart';
import 'package:treemov/features/teacher_calendar/data/models/period_schedule_request_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/period_schedule_response_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/schedule_request_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/schedule_response_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/schedule_update_model.dart';

class ScheduleRemoteDataSource {
  final DioClient _dioClient;

  ScheduleRemoteDataSource(this._dioClient);

  Future<List<ScheduleResponseModel>> getAllSchedules() async {
    try {
      final Response response = await _dioClient.get(ApiConstants.schedules);

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is List) {
          // Если ответ - массив занятий
          return responseData
              .map<ScheduleResponseModel>(
                (json) => ScheduleResponseModel.fromJson(json),
              )
              .toList();
        } else if (responseData is Map<String, dynamic>) {
          // Если ответ - одиночное занятие (оборачиваем в список)
          return [ScheduleResponseModel.fromJson(responseData)];
        } else {
          throw Exception('Некорректный формат ответа от сервера');
        }
      } else {
        throw Exception('Ошибка сервера: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка загрузки расписания: $e');
    }
  }

  Future<ScheduleResponseModel> getScheduleById(int scheduleId) async {
    try {
      final response = await _dioClient.get(
        '${ApiConstants.schedules}$scheduleId/',
      );

      if (response.statusCode == 200) {
        return ScheduleResponseModel.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch schedule: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка получения занятия: $e');
    }
  }

  Future<ScheduleResponseModel> createSchedule(
    ScheduleRequestModel request,
  ) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.schedules,
        data: request.toJson(),
      );

      if (response.statusCode == 201) {
        return ScheduleResponseModel.fromJson(response.data);
      } else {
        throw Exception('Ошибка создания занятия: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка создания занятия: $e');
    }
  }

  Future<PeriodScheduleResponseModel> createPeriodSchedule(
    PeriodScheduleRequestModel request,
  ) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.periodSchedules,
        data: request.toJson(),
      );

      if (response.statusCode == 201) {
        return PeriodScheduleResponseModel.fromJson(response.data);
      } else {
        throw Exception('Ошибка создания занятия: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка создания занятия: $e');
    }
  }

  Future<ScheduleResponseModel> updateSchedule({
    required int scheduleId,
    required ScheduleUpdateModel updateData,
  }) async {
    try {
      final response = await _dioClient.patch(
        '${ApiConstants.schedules}$scheduleId/',
        data: updateData.toJson(),
      );

      if (response.statusCode == 200) {
        return ScheduleResponseModel.fromJson(response.data);
      } else {
        throw Exception('Failed to update schedule: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка обновления занятия: $e');
    }
  }
}
