import 'package:treemov/features/kid_profile/data/datasources/student_profile_remote_data_source.dart';
import 'package:treemov/features/kid_profile/domain/repositories/student_profile_repository.dart';
import 'package:treemov/shared/data/models/accrual_response_model.dart';
import 'package:treemov/shared/data/models/student_response_model.dart';

class StudentProfileRepositoryImpl implements StudentProfileRepository {
  final StudentProfileRemoteDataSource _remoteDataSource;

  StudentProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<StudentResponseModel> getStudentProfile() async {
    return await _remoteDataSource.getStudentProfile();
  }

  @override
  Future<List<AccrualResponseModel>> getStudentAccruals({
    required int? studentId,
    required int page,
  }) async {
    return await _remoteDataSource.getStudentAccruals(
      studentId: studentId,
      page: page,
    );
  }
}
