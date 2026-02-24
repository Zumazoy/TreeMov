import 'package:treemov/features/organizations/data/datasources/orgs_remote_data_source.dart';
import 'package:treemov/features/organizations/data/models/invite_response_model.dart';
import 'package:treemov/features/organizations/domain/repositories/orgs_repository.dart';
import 'package:treemov/shared/data/models/org_member_response_model.dart';

class OrgsRepositoryImpl implements OrgsRepository {
  final OrgsRemoteDataSource _remoteDataSource;

  OrgsRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<OrgMemberResponseModel>> getMyOrgs() async {
    return await _remoteDataSource.getMyOrgs();
  }

  @override
  Future<List<InviteResponseModel>> getMyInvites() async {
    return await _remoteDataSource.getMyInvites();
  }

  @override
  Future<bool> acceptInvite(String uuid) async {
    return await _remoteDataSource.acceptInvite(uuid);
  }
}
