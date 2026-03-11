import 'package:treemov/shared/data/models/lesson_response_model.dart';
import 'package:treemov/shared/data/models/org_member_response_model.dart';
import 'package:treemov/shared/data/models/student_group_member_response_model.dart';
import 'package:treemov/shared/data/models/student_group_response_model.dart';

abstract class SharedRepository {
  Future<OrgMemberResponseModel> getMyOrgMember();
  Future<List<LessonResponseModel>> getLessons(
    DateTime dateMin,
    DateTime dateMax,
  );
  Future<List<GroupStudentsResponseModel>> getGroupStudents();
  Future<List<StudentInGroupResponseModel>> getStudentsInGroup(int groupId);
}
