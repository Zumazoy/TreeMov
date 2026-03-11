import 'package:dio/dio.dart';
import 'package:treemov/core/constants/api_constants.dart';
import 'package:treemov/core/storage/secure_storage_repository.dart';

class OrgIdInterceptor extends Interceptor {
  final SecureStorageRepository secureStorage;

  OrgIdInterceptor({required this.secureStorage});

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_shouldAddOrgId(options.path)) {
      final orgMemberId = await secureStorage.getOrgMemberId();
      if (orgMemberId != null) {
        options.headers['X_ORG_MEMBER_ID'] = orgMemberId;
      }
    }
    handler.next(options);
  }

  bool _shouldAddOrgId(String path) {
    // Исключаем пути, где orgMemberId не нужен
    for (final excludedPath in ApiConstants.excludedOrgMemberIdPaths) {
      if (path.contains(excludedPath)) {
        return false;
      }
    }

    // Проверяем, нужен ли orgMemberId для этого пути
    for (final endpoint in ApiConstants.endpointsRequiringOrgMemberId) {
      if (path.contains(endpoint)) {
        return true;
      }
    }
    return false;
  }
}
