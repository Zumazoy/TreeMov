import 'package:treemov/features/accrual_points/data/models/accrual_request_model.dart';

abstract class AccrualRepository {
  Future<Map<String, dynamic>> createAccrual(AccrualRequestModel request);
}
