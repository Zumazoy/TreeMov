import 'package:treemov/shared/data/datasources/shared_remote_data_source.dart';
import 'package:treemov/shared/data/models/classroom_response_model.dart';
import 'package:treemov/shared/data/models/period_schedule_response_model.dart';
import 'package:treemov/shared/data/models/student_group_response_model.dart';
import 'package:treemov/shared/data/models/subject_response_model.dart';
import 'package:treemov/shared/domain/repositories/shared_repository.dart';

class SharedRepositoryImpl implements SharedRepository {
  final SharedRemoteDataSource _remoteDataSource;

  SharedRepositoryImpl(this._remoteDataSource);

  @override
  Future<int?> getTeacherId() async {
    return await _remoteDataSource.getTeacherId();
  }

  @override
  Future<List<SubjectResponseModel>> getSubjects() async {
    return await _remoteDataSource.getSubjects();
  }

  @override
  Future<List<StudentGroupResponseModel>> getStudentGroups() async {
    return await _remoteDataSource.getStudentGroups();
  }

  @override
  Future<List<ClassroomResponseModel>> getClassrooms() async {
    return await _remoteDataSource.getClassrooms();
  }

  @override
  Future<List<PeriodScheduleResponseModel>> getPeriodSchedules() async {
    return await _remoteDataSource.getPeriodSchedules();
  }
}
