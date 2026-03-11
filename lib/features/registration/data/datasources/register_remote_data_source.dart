import 'package:treemov/core/constants/api_constants.dart';
import 'package:treemov/core/network/base/base_remote_data_source.dart';
import 'package:treemov/features/registration/data/models/register_request_model.dart';

abstract class RegisterRemoteDataSource {
  Future<void> register(RegisterRequestModel request);
  Future<void> sendEmailCode(String email);
  Future<void> verifyEmailCode(String email, String code);
}

class RegisterRemoteDataSourceImpl extends BaseRemoteDataSource
    implements RegisterRemoteDataSource {
  RegisterRemoteDataSourceImpl(super.dioClient);

  @override
  Future<void> register(RegisterRequestModel request) async {
    await postVoid(
      path: ApiConstants.authUrl + ApiConstants.register,
      data: request.toJson(),
      baseUrl: ApiConstants.authUrl,
    );
  }

  @override
  Future<void> sendEmailCode(String email) async {
    await postVoid(
      path: '${ApiConstants.emailUrl}send',
      data: {"email": email, "purpose": "verify_email"},
      baseUrl: ApiConstants.emailUrl,
    );
  }

  @override
  Future<void> verifyEmailCode(String email, String code) async {
    final response = await rawPost(
      '${ApiConstants.emailUrl}verify',
      data: {"email": email, "code": code, "purpose": "verify_email"},
      baseUrl: ApiConstants.emailUrl,
    );

    final data = response.data;
    if (data['succes'] != true) {
      final errorDetail = data['detail'] ?? 'Не удалось подтвердить почту';
      throw Exception(errorDetail);
    }
  }
}
