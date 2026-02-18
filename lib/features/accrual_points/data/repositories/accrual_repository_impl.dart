import 'package:treemov/features/accrual_points/data/datasources/accrual_remote_data_source.dart';
import 'package:treemov/features/accrual_points/data/models/accrual_request_model.dart';
import 'package:treemov/features/accrual_points/domain/repositories/accrual_repository.dart';
import 'package:treemov/shared/data/models/accrual_response_model.dart';

class AccrualRepositoryImpl implements AccrualRepository {
  final AccrualRemoteDataSource _remoteDataSource;

  AccrualRepositoryImpl(this._remoteDataSource);

  @override
  Future<AccrualResponseModel> createAccrual(
    AccrualRequestModel request,
  ) async {
    return await _remoteDataSource.createAccrual(request);
  }

  @override
  Future<List<AccrualResponseModel>> getAccruals() async {
    return await _remoteDataSource.getAccruals();
  }
}
