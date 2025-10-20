abstract class AuthRepository {
  Future<void> getToken(String username, String password);
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
}
