import 'package:treemov/shared/data/datasources/shared_remote_data_source.dart';
import 'package:treemov/shared/data/models/classroom_response_model.dart';
import 'package:treemov/shared/data/models/lesson_response_model.dart';
import 'package:treemov/shared/data/models/org_member_response_model.dart';
import 'package:treemov/shared/data/models/student_group_response_model.dart';
import 'package:treemov/shared/data/models/student_in_group_response_model.dart';
import 'package:treemov/shared/data/models/subject_response_model.dart';
import 'package:treemov/shared/domain/repositories/shared_repository.dart';

class SharedRepositoryImpl implements SharedRepository {
  final SharedRemoteDataSource _remoteDataSource;

  SharedRepositoryImpl(this._remoteDataSource);

  @override
  Future<OrgMemberResponseModel> getMyOrgProfile() async {
    return await _remoteDataSource.getMyOrgProfile();
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
  Future<List<GroupStudentsResponseModel>> getGroupStudents() async {
    return await _remoteDataSource.getGroupStudents();
  }

  @override
  Future<List<StudentInGroupResponseModel>> getStudentsInGroup(
    int groupId,
  ) async {
    return await _remoteDataSource.getStudentsInGroup(groupId);
  }

  @override
  Future<List<ClassroomResponseModel>> getClassrooms() async {
    return await _remoteDataSource.getClassrooms();
  }
}
