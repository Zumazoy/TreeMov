import 'package:shared_preferences/shared_preferences.dart';
import 'package:treemov/core/constants/api_constants.dart';
import 'package:treemov/core/network/dio_client.dart';
import 'package:treemov/shared/data/models/student_response_model.dart';
import 'package:treemov/shared/domain/entities/student_entity.dart';

import '../../domain/repositories/rating_repository.dart';

class RatingRepositoryImpl implements RatingRepository {
  final DioClient _dioClient;
  final SharedPreferences _prefs;

  RatingRepositoryImpl(this._dioClient, this._prefs);

  @override
  Future<List<StudentEntity>> getStudents() async {
    try {
      final response = await _dioClient.get(ApiConstants.students);

      if (response.statusCode != 200 || response.data is! List) {
        return [];
      }

      final students = <StudentEntity>[];

      for (var json in response.data as List) {
        try {
          final student = StudentResponseModel.fromJson(json);
          final entity = student.toEntity();
          students.add(entity);
        } catch (e) {
          continue;
        }
      }

      students.sort((a, b) => b.score.compareTo(a.score));
      return students;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<StudentEntity?> getCurrentStudent() async {
    final currentStudentId = _prefs.getInt('current_student_id');

    if (currentStudentId == null) return null;

    final students = await getStudents();
    try {
      return students.firstWhere((student) => student.id == currentStudentId);
    } catch (e) {
      return null;
    }
  }

  Future<void> setCurrentStudentId(int studentId) async {
    await _prefs.setInt('current_student_id', studentId);
  }

  Future<void> clearCurrentStudentId() async {
    await _prefs.remove('current_student_id');
  }
}
