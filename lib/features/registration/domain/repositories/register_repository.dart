abstract class RegisterRepository {
  Future<void> registerUser({
    required String username,
    required String email,
    required String password,
  });

  Future<void> verifyEmailOnly({required String email, required String code});

  Future<void> resendCode(String email);
}
