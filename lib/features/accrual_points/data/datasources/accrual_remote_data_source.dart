import 'package:treemov/core/constants/api_constants.dart';
import 'package:treemov/core/network/dio_client.dart';
import 'package:treemov/features/accrual_points/data/models/accrual_request_model.dart';

class AccrualRemoteDataSource {
  final DioClient _dioClient;

  AccrualRemoteDataSource(this._dioClient);

  Future<Map<String, dynamic>> createAccrual(
    AccrualRequestModel request,
  ) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.authUrl, // не работает
        data: request.toJson(),
      );

      if (response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception('Ошибка создания начисления: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка создания начисления: $e');
    }
  }
}
