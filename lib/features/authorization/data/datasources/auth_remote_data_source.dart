import 'package:treemov/core/constants/api_constants.dart';
import 'package:treemov/core/network/base/base_remote_data_source.dart';
import 'package:treemov/features/authorization/data/models/login_request_model.dart';
import 'package:treemov/features/authorization/data/models/login_response_model.dart';

class AuthRemoteDataSource extends BaseRemoteDataSource {
  AuthRemoteDataSource(super.dioClient);

  Future<LoginResponseModel> login(LoginRequestModel request) {
    return post(
      path: ApiConstants.authUrl + ApiConstants.login,
      fromJson: LoginResponseModel.fromJson,
      data: request.toJson(),
      baseUrl: ApiConstants.authUrl,
    );
  }
}
