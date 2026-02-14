import 'package:treemov/shared/data/models/org_member_response_model.dart';
import 'package:treemov/shared/domain/entities/student_entity.dart';
import 'package:treemov/shared/domain/models/base_response_model.dart';

class StudentResponseModel extends BaseResponseModel
    with EntityConvertible<StudentEntity> {
  final String? name;
  final String? surname;
  final String? progress;
  final String? birthday;
  final int? score;
  final OrgMemberResponseModel? orgMember;

  StudentResponseModel({
    required super.baseData,
    required this.name,
    required this.surname,
    required this.progress,
    required this.birthday,
    required this.score,
    required this.orgMember,
  });

  factory StudentResponseModel.fromJson(Map<String, dynamic> json) {
    return StudentResponseModel(
      baseData: json.baseData,
      name: json['name'],
      surname: json['surname'],
      progress: json['progress'],
      birthday: json['birthday'],
      score: json['score'],
      orgMember: OrgMemberResponseModel.fromJson(json['org_member']),
    );
  }

  @override
  StudentEntity toEntity() {
    return StudentEntity(
      baseData: baseData.toEntityData(),
      name: name,
      surname: surname,
      progress: progress,
      birthday: birthday,
      score: score,
      orgMember: orgMember,
    );
  }
}
