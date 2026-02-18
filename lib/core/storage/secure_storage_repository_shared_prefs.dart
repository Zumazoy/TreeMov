import 'package:shared_preferences/shared_preferences.dart';
import 'package:treemov/core/constants/constants.dart';
import 'package:treemov/core/storage/secure_storage_repository.dart';

class SecureStorageRepositorySharedPrefs implements SecureStorageRepository {
  // Tokens
  @override
  Future<void> saveAccessToken(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Constants.accessTokenKey, accessToken);
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Constants.refreshTokenKey, refreshToken);
  }

  @override
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.accessTokenKey);
  }

  @override
  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.refreshTokenKey);
  }

  @override
  Future<void> deleteAllTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(Constants.accessTokenKey);
    await prefs.remove(Constants.refreshTokenKey);
  }

  // Org_id
  @override
  Future<void> saveOrgId(String orgId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Constants.orgIdKey, orgId);
  }

  @override
  Future<String?> getOrgId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.orgIdKey);
  }

  @override
  Future<void> deleteOrgId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(Constants.orgIdKey);
  }

  // OrgMember_id
  @override
  Future<void> saveOrgMemberId(String orgMemberId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Constants.orgMemberIdKey, orgMemberId);
  }

  @override
  Future<String?> getOrgMemberId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.orgMemberIdKey);
  }

  @override
  Future<void> deleteOrgMemberId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(Constants.orgMemberIdKey);
  }
}
