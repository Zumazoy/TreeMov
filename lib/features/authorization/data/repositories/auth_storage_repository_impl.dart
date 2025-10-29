import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:treemov/core/constants/api_constants.dart';
import 'package:treemov/features/authorization/domain/repositories/auth_storage_repository.dart';

class AuthStorageRepositoryImpl implements AuthStorageRepository {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  @override
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: ApiConstants.tokenKey, value: token);
  }

  @override
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: ApiConstants.refreshTokenKey, value: token);
  }

  @override
  Future<String?> getAccessToken() async {
    return await _storage.read(key: ApiConstants.tokenKey);
  }

  @override
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: ApiConstants.refreshTokenKey);
  }

  @override
  Future<void> clearAllTokens() async {
    await _storage.delete(key: ApiConstants.tokenKey);
    await _storage.delete(key: ApiConstants.refreshTokenKey);
  }
}
