import 'package:treemov/features/authorization/data/datasources/auth_remote_data_source.dart';
import 'package:treemov/features/authorization/data/models/login_request_model.dart';
import 'package:treemov/features/authorization/data/models/login_response_model.dart';
import 'package:treemov/features/authorization/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl(this._authRemoteDataSource);

  @override
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    return await _authRemoteDataSource.login(request);
  }
}
