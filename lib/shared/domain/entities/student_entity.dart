import 'package:treemov/shared/data/models/org_member_response_model.dart';
import 'package:treemov/shared/domain/models/base_entity.dart';

class StudentEntity extends BaseEntity {
  final String? name;
  final String? surname;
  final String? progress;
  final String? birthday;
  final int? score;
  final OrgMemberResponseModel? orgMember;

  StudentEntity({
    required super.baseData,
    required this.name,
    required this.surname,
    required this.progress,
    required this.birthday,
    required this.score,
    required this.orgMember,
  });
}
