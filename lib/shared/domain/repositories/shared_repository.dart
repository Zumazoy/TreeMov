import 'package:treemov/shared/data/models/classroom_response_model.dart';
import 'package:treemov/shared/data/models/lesson_response_model.dart';
import 'package:treemov/shared/data/models/org_member_response_model.dart';
import 'package:treemov/shared/data/models/student_group_member_response_model.dart';
import 'package:treemov/shared/data/models/student_group_response_model.dart';
import 'package:treemov/shared/data/models/subject_response_model.dart';

abstract class SharedRepository {
  Future<OrgMemberResponseModel> getMyOrgProfile();
  Future<List<LessonResponseModel>> getLessons();
  Future<int?> getTeacherId();
  Future<List<SubjectResponseModel>> getSubjects();
  Future<List<GroupStudentsResponseModel>> getGroupStudents();
  Future<List<StudentGroupMemberResponseModel>> getStudentsInGroup(int groupId);
  Future<List<ClassroomResponseModel>> getClassrooms();
}
