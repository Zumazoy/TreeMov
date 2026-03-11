import 'package:treemov/core/constants/api_constants.dart';
import 'package:treemov/core/network/base/base_remote_data_source.dart';
import 'package:treemov/features/accrual_points/data/models/accrual_request_model.dart';
import 'package:treemov/shared/data/models/accrual_response_model.dart';

class AccrualRemoteDataSource extends BaseRemoteDataSource {
  AccrualRemoteDataSource(super.dioClient);

  Future<AccrualResponseModel> createAccrual(AccrualRequestModel request) {
    return post(
      path: ApiConstants.accruals,
      fromJson: AccrualResponseModel.fromJson,
      data: request.toJson(),
    );
  }
}
