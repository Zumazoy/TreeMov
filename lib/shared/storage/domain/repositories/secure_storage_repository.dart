abstract class SecureStorageRepository {
  // Tokens
  Future<void> saveAccessToken(String accessToken);
  Future<void> saveRefreshToken(String refreshToken);
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> deleteAllTokens();

  // Org_id
  Future<void> saveOrgId(String orgId);
  Future<String?> getOrgId();
  Future<void> deleteOrgId();

  // OrgMember_id
  Future<void> saveOrgMemberId(String orgMemberId);
  Future<String?> getOrgMemberId();
  Future<void> deleteOrgMemberId();
}
