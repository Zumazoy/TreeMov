import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:treemov/api/core/api_constants.dart';
import 'package:treemov/api/core/dio_client.dart';
import 'package:treemov/api/models/schedule_model.dart';
import 'package:treemov/api/models/schedules/create_schedule_request.dart';

class ScheduleService {
  final DioClient _dioClient;

  ScheduleService(this._dioClient);

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
