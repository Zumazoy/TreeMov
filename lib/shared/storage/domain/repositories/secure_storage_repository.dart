abstract class SecureStorageRepository {
  // Tokens
  Future<void> saveAccessToken(String accessToken);
  Future<void> saveRefreshToken(String refreshToken);
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> clearAllTokens();

  // Org_id
  Future<void> saveOrgId(String orgId);
  Future<String?> getOrgId();
}
