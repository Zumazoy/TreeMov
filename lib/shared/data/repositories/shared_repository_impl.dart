import 'package:treemov/shared/data/datasources/shared_remote_data_source.dart';
import 'package:treemov/shared/data/models/classroom_response_model.dart';
import 'package:treemov/shared/data/models/lesson_response_model.dart';
import 'package:treemov/shared/data/models/student_group_response_model.dart';
import 'package:treemov/shared/data/models/subject_response_model.dart';
import 'package:treemov/shared/data/models/teacher_profile_response_model.dart';
import 'package:treemov/shared/domain/repositories/shared_repository.dart';

class SharedRepositoryImpl implements SharedRepository {
  final SharedRemoteDataSource _remoteDataSource;

  SharedRepositoryImpl(this._remoteDataSource);

  @override
  Future<TeacherProfileResponseModel> getMyTeacherProfile() async {
    return await _remoteDataSource.getMyTeacherProfile();
  }

  @override
  Future<List<LessonResponseModel>> getLessons() async {
    return await _remoteDataSource.getLessons();
  }

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
  Future<StudentGroupResponseModel> getStudentGroupById(int groupId) async {
    return await _remoteDataSource.getStudentGroupById(groupId);
  }

  @override
  Future<List<ClassroomResponseModel>> getClassrooms() async {
    return await _remoteDataSource.getClassrooms();
  }
}
