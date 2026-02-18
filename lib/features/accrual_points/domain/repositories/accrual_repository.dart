import 'package:treemov/features/accrual_points/data/models/accrual_request_model.dart';
import 'package:treemov/shared/data/models/accrual_response_model.dart';

abstract class AccrualRepository {
  Future<AccrualResponseModel> createAccrual(AccrualRequestModel request);
  Future<List<AccrualResponseModel>> getAccruals();
}
