import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:treemov/core/constants/constants.dart';
import 'package:treemov/core/storage/secure_storage_repository.dart';

class SecureStorageRepositoryImpl implements SecureStorageRepository {
  SecureStorageRepositoryImpl() {
    if (kIsWeb) {
      throw UnsupportedError(
        'SecureStorageRepositoryImpl не поддерживается на вебе. '
        'Используйте SecureStorageRepositoryWeb через SecureStorageFactory',
      );
    }
  }

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // Tokens
  @override
  Future<void> saveAccessToken(String accessToken) async {
    await _storage.write(key: Constants.accessTokenKey, value: accessToken);
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    await _storage.write(key: Constants.refreshTokenKey, value: refreshToken);
  }

  @override
  Future<String?> getAccessToken() async {
    return await _storage.read(key: Constants.accessTokenKey);
  }

  @override
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: Constants.refreshTokenKey);
  }

  @override
  Future<void> deleteAllTokens() async {
    await _storage.delete(key: Constants.accessTokenKey);
    await _storage.delete(key: Constants.refreshTokenKey);
  }

  // Org_id
  @override
  Future<void> saveOrgId(String orgId) async {
    await _storage.write(key: Constants.orgIdKey, value: orgId);
  }

  @override
  Future<String?> getOrgId() async {
    return await _storage.read(key: Constants.orgIdKey);
  }

  @override
  Future<void> deleteOrgId() async {
    await _storage.delete(key: Constants.orgIdKey);
  }

  // OrgMember_id
  @override
  Future<void> saveOrgMemberId(String orgMemberId) async {
    await _storage.write(key: Constants.orgMemberIdKey, value: orgMemberId);
  }

  @override
  Future<String?> getOrgMemberId() async {
    return await _storage.read(key: Constants.orgMemberIdKey);
  }

  @override
  Future<void> deleteOrgMemberId() async {
    await _storage.delete(key: Constants.orgMemberIdKey);
  }
}
