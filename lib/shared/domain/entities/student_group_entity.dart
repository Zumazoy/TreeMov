import 'package:treemov/shared/domain/entities/student_entity.dart';
import 'package:treemov/shared/domain/models/base_entity.dart';

class StudentGroupEntity extends BaseEntity {
  final String? name;
  final List<StudentEntity> students;

  StudentGroupEntity({
    required super.baseData,
    required this.name,
    required this.students,
  });
}
