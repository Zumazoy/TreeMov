import 'package:treemov/features/organizations/data/models/invite_response_model.dart';
import 'package:treemov/shared/data/models/org_member_response_model.dart';

abstract class OrgsRepository {
  Future<List<OrgMemberResponseModel>> getMyOrgs();
  Future<List<InviteResponseModel>> getMyInvites();
  Future<bool> acceptInvite(String uuid);
}
