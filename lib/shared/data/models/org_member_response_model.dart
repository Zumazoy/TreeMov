import 'package:treemov/shared/data/models/org_response_model.dart';
import 'package:treemov/shared/data/models/profile_response_model.dart';
import 'package:treemov/shared/data/models/role_response_model.dart';
import 'package:treemov/shared/domain/models/base_response_model.dart';

class OrgMemberResponseModel extends BaseResponseModel {
  final ProfileResponseModel? profile;
  final RoleResponseModel? role;
  final OrgResponseModel? org;

  OrgMemberResponseModel({
    required super.baseData,
    required this.profile,
    required this.role,
    required this.org,
  });

  factory OrgMemberResponseModel.fromJson(Map<String, dynamic> json) {
    return OrgMemberResponseModel(
      baseData: json.baseData,
      profile: ProfileResponseModel.fromJson(json['profile']),
      role: RoleResponseModel.fromJson(json['role']),
      org: OrgResponseModel.fromJson(json['org']),
    );
  }
}
