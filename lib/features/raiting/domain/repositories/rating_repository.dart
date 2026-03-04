import 'package:treemov/shared/data/models/student_group_response_model.dart';
import 'package:treemov/shared/domain/entities/student_entity.dart';

abstract class RatingRepository {
  Future<List<StudentEntity>> getStudents();
  Future<List<StudentEntity>> getStudentsByGroup(int groupId);
  Future<StudentEntity?> getCurrentStudent();
  Future<List<GroupStudentsResponseModel>> getStudentGroups();
}
