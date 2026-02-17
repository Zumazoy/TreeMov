import 'package:dio/dio.dart';
import 'package:treemov/core/constants/api_constants.dart';
import 'package:treemov/shared/storage/domain/repositories/secure_storage_repository.dart';

class OrgIdInterceptor extends Interceptor {
  final SecureStorageRepository secureStorage;

  OrgIdInterceptor({required this.secureStorage});

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_shouldAddOrgId(options.path)) {
      final orgId = await secureStorage.getOrgId();
      if (orgId != null) {
        options.headers['org-id'] = orgId;
      }
    }
    handler.next(options);
  }

  bool _shouldAddOrgId(String path) {
    // Исключаем пути, где org-id не нужен
    for (final excludedPath in ApiConstants.excludedOrgIdPaths) {
      if (path.contains(excludedPath)) {
        return false;
      }
    }

    // Проверяем, нужен ли org-id для этого пути
    for (final endpoint in ApiConstants.endpointsRequiringOrgId) {
      if (path.contains(endpoint)) {
        return true;
      }
    }
    return false;
  }
}
