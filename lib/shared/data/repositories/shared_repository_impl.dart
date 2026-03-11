import 'package:treemov/shared/data/datasources/shared_remote_data_source.dart';
import 'package:treemov/shared/data/models/lesson_response_model.dart';
import 'package:treemov/shared/data/models/org_member_response_model.dart';
import 'package:treemov/shared/data/models/student_group_member_response_model.dart';
import 'package:treemov/shared/data/models/student_group_response_model.dart';
import 'package:treemov/shared/domain/repositories/shared_repository.dart';

class SharedRepositoryImpl implements SharedRepository {
  final SharedRemoteDataSource _remoteDataSource;

  SharedRepositoryImpl(this._remoteDataSource);

  @override
  Future<OrgMemberResponseModel> getMyOrgMember() async {
    return await _remoteDataSource.getMyOrgMember();
  }

  @override
  Future<List<LessonResponseModel>> getLessons(
    DateTime dateMin,
    DateTime dateMax,
  ) async {
    return await _remoteDataSource.getLessons(dateMin, dateMax);
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
}
