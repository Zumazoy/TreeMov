import 'package:treemov/core/constants/api_constants.dart';
import 'package:treemov/core/network/dio_client.dart';
import 'package:treemov/features/authorization/data/models/token_request.dart';
import 'package:treemov/features/authorization/data/models/token_response.dart';

class AuthRemoteDataSource {
  final DioClient _dioClient;

  AuthRemoteDataSource(this._dioClient);

  Future<TokenResponse> login(TokenRequest request) async {
    final response = await _dioClient.post(
      ApiConstants.token,
      data: request.toJson(),
    );

    return TokenResponse.fromJson(response.data);
  }
}
