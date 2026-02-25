import 'package:treemov/shared/data/models/org_response_model.dart';
import 'package:treemov/shared/data/models/role_response_model.dart';
import 'package:treemov/shared/domain/models/base_response_model.dart';

class InviteResponseModel extends BaseResponseModel {
  final String? status;
  final String? email;
  final String? uuid;
  final String? createdAt;
  final RoleResponseModel? role;
  final OrgResponseModel? org;

  InviteResponseModel({
    required super.baseData,
    required this.status,
    required this.email,
    required this.uuid,
    required this.createdAt,
    required this.role,
    required this.org,
  });

  factory InviteResponseModel.fromJson(Map<String, dynamic> json) {
    return InviteResponseModel(
      baseData: json.baseData,
      status: json['status'],
      email: json['email'],
      uuid: json['uuid'],
      createdAt: json['created_at'],
      role: RoleResponseModel.fromJson(json['role']),
      org: OrgResponseModel.fromJson(json['org']),
    );
  }
}
