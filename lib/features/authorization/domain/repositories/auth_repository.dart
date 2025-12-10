import 'package:treemov/features/authorization/data/models/login_request_model.dart';
import 'package:treemov/features/authorization/data/models/login_response_model.dart';

abstract class AuthRepository {
  Future<void> token(String username, String password);
  Future<LoginResponseModel> login(LoginRequestModel request);
}
