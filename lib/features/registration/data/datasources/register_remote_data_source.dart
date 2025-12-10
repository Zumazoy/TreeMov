import 'package:treemov/core/constants/api_constants.dart';
import 'package:treemov/core/network/dio_client.dart';
import 'package:treemov/features/registration/data/models/register_request_model.dart';
import 'package:treemov/features/registration/data/models/register_response_model.dart';

class RegisterRemoteDataSource {
  final DioClient _dioClient;

  RegisterRemoteDataSource(this._dioClient);

  // Future<LessonResponseModel> getLessonById(int scheduleId) async {
  //   try {
  //     final response = await _dioClient.get(
  //       '${ApiConstants.scheduleP + ApiConstants.lessons}$scheduleId/',
  //     );

  //     if (response.statusCode == 200) {
  //       return LessonResponseModel.fromJson(response.data);
  //     } else {
  //       throw Exception('Failed to fetch schedule: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Ошибка получения занятия: $e');
  //   }
  // }

  Future<RegisterResponseModel> register(RegisterRequestModel request) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.baseV1Url + ApiConstants.register,
        data: request.toJson(),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return RegisterResponseModel.fromJson(response.data);
      } else if (response.statusCode == 400) {
        throw Exception(
          'Bad Request: ${RegisterResponseModel.fromJson(response.data)}',
        );
      } else {
        throw Exception('Ошибка регистрации (код): ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка регистрации: $e');
    }
  }
}
