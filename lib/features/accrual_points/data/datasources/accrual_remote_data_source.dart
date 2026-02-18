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
        // Проверяем, является ли ответ списком или одиночным объектом
        if (response.data is List) {
          final List data = response.data;
          if (data.isNotEmpty) {
            return AccrualResponseModel.fromJson(data.first);
          } else {
            throw Exception('Пустой ответ от сервера');
          }
        } else {
          return AccrualResponseModel.fromJson(response.data);
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
        return data.map((json) => AccrualResponseModel.fromJson(json)).toList();
      } else {
        throw Exception('Ошибка загрузки начислений: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка загрузки начислений: $e');
    }
  }
}
