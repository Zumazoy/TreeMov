import 'package:treemov/core/constants/api_constants.dart';
import 'package:treemov/core/network/dio_client.dart';
import 'package:treemov/features/authorization/data/models/login_request_model.dart';
import 'package:treemov/features/authorization/data/models/login_response_model.dart';
import 'package:treemov/features/authorization/data/models/token_request.dart';
import 'package:treemov/features/authorization/data/models/token_response.dart';

class AuthRemoteDataSource {
  final DioClient _dioClient;

  AuthRemoteDataSource(this._dioClient);

  Future<TokenResponse> token(TokenRequest request) async {
    final response = await _dioClient.post(
      ApiConstants.token,
      data: request.toJson(),
    );

    return TokenResponse.fromJson(response.data);
  }

  Future<LoginResponseModel> login(LoginRequestModel request) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.baseV1Url + ApiConstants.login,
        data: request.toJson(),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return LoginResponseModel.fromJson(response.data);
      } else if (response.statusCode == 400) {
        throw Exception(
          'Bad Request: ${LoginResponseModel.fromJson(response.data)}',
        );
      } else {
        throw Exception('Ошибка авторизации (код): ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка авторизации: $e');
    }
  }
}
