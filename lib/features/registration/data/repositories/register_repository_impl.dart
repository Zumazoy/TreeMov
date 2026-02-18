import '../../domain/repositories/register_repository.dart';
import '../datasources/register_remote_data_source.dart';
import '../models/register_request_model.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteDataSource remoteDataSource;

  RegisterRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> registerUser({
    required String username,
    required String email,
    required String password,
  }) async {
    final requestModel = RegisterRequestModel(
      username: username,
      email: email,
      password: password,
    );
    await remoteDataSource.register(requestModel);
    await remoteDataSource.sendEmailCode(email);
  }

  @override
  Future<void> verifyEmailOnly({
    required String email,
    required String code,
  }) async {
    await remoteDataSource.verifyEmailCode(email, code);
  }

  @override
  Future<void> resendCode(String email) async {
    await remoteDataSource.sendEmailCode(email);
  }
}
