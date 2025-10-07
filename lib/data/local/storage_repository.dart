import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:treemov/api/core/api_constants.dart';

abstract class IStorageRepository {
  Future<void> saveAccessToken(String token);
  Future<String?> getAccessToken();
  Future<void> saveRefreshToken(String token);
  Future<String?> getRefreshToken();
  Future<void> deleteAllTokens();
  Future<bool> hasAccessToken();
}

class StorageRepository implements IStorageRepository {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  @override
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: ApiConstants.tokenKey, value: token);
  }

  @override
  Future<String?> getAccessToken() async {
    return await _storage.read(key: ApiConstants.tokenKey);
  }

  @override
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: ApiConstants.refreshTokenKey, value: token);
  }

  @override
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: ApiConstants.refreshTokenKey);
  }

  @override
  Future<void> deleteAllTokens() async {
    await _storage.delete(key: ApiConstants.tokenKey);
    await _storage.delete(key: ApiConstants.refreshTokenKey);
  }

  @override
  Future<bool> hasAccessToken() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }
}
