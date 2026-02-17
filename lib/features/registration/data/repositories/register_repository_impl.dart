import 'package:treemov/features/registration/data/datasources/register_remote_data_source.dart';
import 'package:treemov/features/registration/data/models/register_request_model.dart';
import 'package:treemov/features/registration/data/models/register_response_model.dart';
import 'package:treemov/features/registration/domain/repositories/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteDataSource _remoteDataSource;

  RegisterRepositoryImpl(this._remoteDataSource);

  // @override
  // Future<LessonResponseModel> getLessonById(int scheduleId) async {
  //   return await _remoteDataSource.getLessonById(scheduleId);
  // }

  @override
  Future<RegisterResponseModel> register(RegisterRequestModel request) async {
    return await _remoteDataSource.register(request);
  }
}
