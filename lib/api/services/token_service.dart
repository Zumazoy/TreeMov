import 'package:treemov/api/core/api_constants.dart';
import 'package:treemov/api/core/dio_client.dart';
import 'package:treemov/api/models/token/token_request.dart';
import 'package:treemov/api/models/token/token_response.dart';

class TokenService {
  final DioClient _dioClient;

  TokenService(this._dioClient);

  Future<TokenResponse> getToken(TokenRequest request) async {
    final response = await _dioClient.post(
      ApiConstants.token,
      data: request.toJson(),
    );

    return TokenResponse.fromJson(response.data);
  }
}
