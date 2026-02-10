import 'package:treemov/features/registration/data/models/register_request_model.dart';
import 'package:treemov/features/registration/data/models/register_response_model.dart';

abstract class RegisterRepository {
  // Future<LessonResponseModel> getLessonById(int lessonId);
  Future<RegisterResponseModel> register(RegisterRequestModel request);
}
