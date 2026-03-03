import 'package:treemov/core/constants/api_constants.dart';
import 'package:treemov/core/network/dio_client.dart';
import 'package:treemov/features/accrual_points/data/models/accrual_request_model.dart';
import 'package:treemov/shared/data/models/accrual_response_model.dart';

class AccrualRemoteDataSource {
  final DioClient _dioClient;

  AccrualRemoteDataSource(this._dioClient);

  Future<AccrualResponseModel> createAccrual(
    AccrualRequestModel request,
  ) async {
    try {
      final response = await _dioClient.post(
        '${ApiConstants.baseUrl}${ApiConstants.accruals}',
        data: request.toJson(),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        if (response.data is List) {
          final List data = response.data;
          if (data.isNotEmpty) {
            return AccrualResponseModel.fromJson(
              Map<String, dynamic>.from(data.first),
            );
          } else {
            throw Exception('Пустой ответ от сервера');
          }
        } else {
          return AccrualResponseModel.fromJson(
            Map<String, dynamic>.from(response.data),
          );
        }
      } else {
        throw Exception('Ошибка создания начисления: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка создания начисления: $e');
    }
  }

  Future<List<AccrualResponseModel>> getAccruals() async {
    try {
      final response = await _dioClient.get(
        '${ApiConstants.baseUrl}${ApiConstants.accruals}',
      );

      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((json) {
          return AccrualResponseModel.fromJson(Map<String, dynamic>.from(json));
        }).toList();
      } else {
        throw Exception('Ошибка загрузки начислений: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка загрузки начислений: $e');
    }
  }

  Future<List<AccrualResponseModel>> getStudentAccruals({
    required int? studentId,
    required int page,
    int pageSize = 20,
  }) async {
    try {
      if (studentId == null) {
        throw Exception('Student ID is required');
      }
      final url = '${ApiConstants.baseUrl}${ApiConstants.accruals}/$studentId';
      final response = await _dioClient.get(
        url,
        queryParameters: {'page': page, 'page_size': pageSize},
      );

      if (response.statusCode == 200) {
        List<dynamic> dataList = [];

        if (response.data is List) {
          dataList = response.data;
        } else if (response.data is Map) {
          final map = response.data as Map;
          if (map['results'] != null)
            dataList = map['results'];
          else if (map['data'] != null)
            dataList = map['data'];
        }

        print(
          '📦 Получено начислений для ученика $studentId: ${dataList.length}',
        );

        return dataList.map((json) {
          return AccrualResponseModel.fromJson(Map<String, dynamic>.from(json));
        }).toList();
      } else {
        throw Exception('Ошибка загрузки начислений: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Ошибка: $e');
      throw Exception('Ошибка загрузки начислений: $e');
    }
  }
}
