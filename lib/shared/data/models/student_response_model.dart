import 'package:treemov/shared/data/models/org_member_response_model.dart';
import 'package:treemov/shared/domain/entities/student_entity.dart';
import 'package:treemov/shared/domain/models/base_response_model.dart';

class StudentResponseModel extends BaseResponseModel
    with EntityConvertible<StudentEntity> {
  final int? id;
  final String? name;
  final String? surname;
  final String? patronymic;
  final String? progress;
  final String? birthday;
  final int? score;
  final OrgMemberResponseModel? orgMember;

  StudentResponseModel({
    required super.baseData,
    required this.id,
    required this.name,
    required this.surname,
    required this.patronymic,
    required this.progress,
    required this.birthday,
    required this.score,
    required this.orgMember,
  });

  factory StudentResponseModel.fromJson(Map<String, dynamic> json) {
    return StudentResponseModel(
      baseData: json.baseData,
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      patronymic: json['patronymic'],
      progress: json['progress'],
      birthday: json['birthday'],
      score: json['score'],
      orgMember: json['org_member'] != null
          ? OrgMemberResponseModel.fromJson(json['org_member'])
          : null,
    );
  }

  @override
  StudentEntity toEntity() {
    return StudentEntity(
      baseData: baseData.toEntityData(),
      id: id ?? 0,
      name: name,
      surname: surname,
      patronymic: patronymic,
      progress: progress,
      birthday: birthday,
      score: score ?? 0,
      orgMember: orgMember,
    );
  }
}
