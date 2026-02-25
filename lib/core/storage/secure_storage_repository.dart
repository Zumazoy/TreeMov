abstract class SecureStorageRepository {
  // Tokens
  Future<void> saveAccessToken(String accessToken);
  Future<void> saveRefreshToken(String refreshToken);
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> deleteAllTokens();

  // OrgMember_id
  Future<void> saveOrgMemberId(String orgMemberId);
  Future<String?> getOrgMemberId();
  Future<void> deleteOrgMemberId();

  // Role
  Future<void> saveRole(String role);
  Future<String?> getRole();
  Future<void> deleteRole();
}
