import 'package:treemov/api/core/api_constants.dart';
import 'package:treemov/api/core/dio_client.dart';
import 'package:treemov/api/models/students/get_students_response.dart';

class StudentsService {
  final DioClient _dioClient;

  StudentsService(this._dioClient);

  Future<GetStudentsResponse> getAllStudents() async {
    final response = await _dioClient.get(ApiConstants.students);

    return GetStudentsResponse.fromJson(response.data);
  }
}
