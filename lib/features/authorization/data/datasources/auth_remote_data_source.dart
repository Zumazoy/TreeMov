import 'package:treemov/core/network/dio_client.dart';
import 'package:treemov/features/authorization/data/models/login_request_model.dart';
import 'package:treemov/features/authorization/data/models/login_response_model.dart';

class AuthRemoteDataSource {
  final DioClient _dioClient;

  AuthRemoteDataSource(this._dioClient);

  Future<LoginResponseModel> login(LoginRequestModel request) async {
    try {
      final response = await _dioClient.post(
        'http://10.0.2.2:8000/api/v1/auth/login',
        data: request.toJson(),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return LoginResponseModel.fromJson(response.data);
      } else {
        throw Exception('Код: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка авторизации: $e');
    }
  }
}
