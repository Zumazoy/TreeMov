import 'package:treemov/shared/data/models/accrual_response_model.dart';
import 'package:treemov/shared/data/models/student_response_model.dart';

abstract class StudentProfileRepository {
  Future<StudentResponseModel> getStudentProfile();
  Future<List<AccrualResponseModel>> getStudentAccruals({
    required int? studentId,
    required int page,
  });
}
