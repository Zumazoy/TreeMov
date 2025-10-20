import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:treemov/core/constants/api_constants.dart';
import 'package:treemov/core/network/dio_client.dart';
import 'package:treemov/features/teacher_calendar/data/models/create_schedule_request.dart';
import 'package:treemov/features/teacher_calendar/data/models/schedule_model.dart';

class ScheduleRemoteDataSource {
  final DioClient _dioClient;

  ScheduleRemoteDataSource(this._dioClient);

  /// Возвращает список занятий. Ответ явно запрашиваем в виде bytes,
  /// затем декодируем в UTF-8 и парсим JSON.
  Future<List<ScheduleModel>> fetchSchedules({String? token}) async {
    try {
      final Response response = await _dioClient.dio.get(
        ApiConstants.schedules,
        options: Options(
          responseType: ResponseType.bytes,
          headers: token != null ? {'Authorization': 'Bearer $token'} : null,
        ),
      );

      // response.data — bytes (List<int>)
      final List<int> bytes = response.data is List<int>
          ? List<int>.from(response.data as List)
          : (response.data as List).cast<int>();

      final String decoded = utf8.decode(bytes);
      final dynamic jsonData = jsonDecode(decoded);

      if (jsonData is List) {
        return jsonData
            .map((e) => ScheduleModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> createSchedule(CreateScheduleRequest request) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.schedules,
        data: request.toJson(),
      );

      return response;
    } catch (e) {
      throw Exception('Ошибка создания занятия: $e');
    }
  }
}
