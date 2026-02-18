import 'package:treemov/shared/domain/entities/student_entity.dart';

abstract class RatingRepository {
  Future<List<StudentEntity>> getStudents();
  Future<StudentEntity?> getCurrentStudent();
}
