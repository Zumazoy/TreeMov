import 'package:dio/dio.dart';
import 'package:treemov/core/constants/api_constants.dart';
import 'package:treemov/core/network/dio_client.dart';
import 'package:treemov/shared/data/models/student_response_model.dart';

class RatingRemoteDataSource {
  final DioClient _dioClient;

  RatingRemoteDataSource(this._dioClient);

  Future<List<StudentResponseModel>> getAllStudents() async {
    try {
      final Response response = await _dioClient.get(
        ApiConstants.studentsP + ApiConstants.students,
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is List) {
          return responseData
              .map<StudentResponseModel>(
                (json) => StudentResponseModel.fromJson(json),
              )
              .toList();
        } else if (responseData is Map<String, dynamic>) {
          return [StudentResponseModel.fromJson(responseData)];
        } else {
          throw Exception('Некорректный формат ответа от сервера');
        }
      } else {
        throw Exception('Ошибка сервера: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка загрузки студентов: $e');
    }
  }
}