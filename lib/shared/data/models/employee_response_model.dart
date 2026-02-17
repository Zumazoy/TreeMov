import 'package:treemov/shared/data/models/org_member_response_model.dart';
import 'package:treemov/shared/domain/models/base_response_model.dart';

class EmployeeResponseModel extends BaseResponseModel {
  final String? name;
  final String? surname;
  final String? patronymic;
  final String? email;
  final OrgMemberResponseModel? orgMember;

  EmployeeResponseModel({
    required super.baseData,
    required this.name,
    required this.surname,
    required this.patronymic,
    required this.email,
    required this.orgMember,
  });

  factory EmployeeResponseModel.fromJson(Map<String, dynamic> json) {
    return EmployeeResponseModel(
      baseData: json.baseData,
      name: json['name'],
      surname: json['surname'],
      patronymic: json['patronymic'],
      email: json['email'],
      orgMember: OrgMemberResponseModel.fromJson(json['org_member']),
    );
  }
}
