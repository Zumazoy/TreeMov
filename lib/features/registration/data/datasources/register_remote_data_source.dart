import 'package:treemov/core/constants/api_constants.dart';
import 'package:treemov/core/network/dio_client.dart';
import 'package:treemov/features/registration/data/models/register_request_model.dart';

// 1. Абстрактный контракт (Интерфейс)
abstract class RegisterRemoteDataSource {
  Future<void> register(RegisterRequestModel request);
  Future<void> sendEmailCode(String email);
  Future<void> verifyEmailCode(String email, String code);
}

// 2. Реализация (Implementation)
class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  final DioClient _dioClient;

  RegisterRemoteDataSourceImpl(this._dioClient);

  @override
  Future<void> register(RegisterRequestModel request) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.authUrl + ApiConstants.register,
        data: request.toJson(),
      );

      // Проверка успешности (200 или 201)
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Ошибка регистрации: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> sendEmailCode(String email) async {
    try {
      await _dioClient.post(
        '${ApiConstants.emailUrl}send',
        data: {"email": email, "purpose": "verify_email"},
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> verifyEmailCode(String email, String code) async {
    try {
      final response = await _dioClient.post(
        '${ApiConstants.emailUrl}verify',
        data: {"email": email, "code": code, "purpose": "verify_email"},
      );

      final data = response.data;

      if (data['succes'] != true) {
        final errorDetail = data['detail'] ?? 'Не удалось подтвердить почту';
        throw Exception(errorDetail);
      }
    } catch (e) {
      rethrow;
    }
  }
}
