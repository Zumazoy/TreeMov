import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:treemov/app/di/di.config.dart';
import 'package:treemov/app/routes/app_routes.dart';
import 'package:treemov/core/constants/api_constants.dart';
import 'package:treemov/core/navigation/navigation_service.dart';
import 'package:treemov/core/storage/secure_storage_repository.dart';
import 'package:treemov/shared/domain/services/token_refresh_service.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorageRepository secureStorage;
  final TokenRefreshService refreshService;
  final Dio dio;

  AuthInterceptor({
    required this.secureStorage,
    required this.refreshService,
    required this.dio,
  });

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_shouldNotAddToken(options.path)) {
      try {
        final token = await secureStorage.getAccessToken();

        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
      } catch (e) {
        debugPrint('❌ Error getting token: $e');
      }
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (!_shouldNotAddToken(err.requestOptions.path)) {
      handler.next(err);
      return;
    }
    if (err.response?.statusCode != 401) {
      handler.next(err);
      return;
    }

    debugPrint('🔄 Token expired, refreshing...');

    try {
      final newToken = await refreshService.refreshToken();

      if (newToken != null) {
        final options = err.requestOptions;
        options.headers['Authorization'] = 'Bearer $newToken';

        final response = await dio.fetch(options);
        handler.resolve(response);
        return;
      }

      debugPrint('❌ Refresh failed, redirecting to login');
      await secureStorage.deleteAllTokens();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        getIt<NavigationService>().navigateToReplacement(AppRoutes.entrance);
      });

      handler.next(err);
    } catch (e) {
      debugPrint('❌ Error in auth interceptor: $e');
      handler.next(err);
    }
  }

  bool _shouldNotAddToken(String path) {
    for (final excludedPath in ApiConstants.excludedTokenPaths) {
      if (path.contains(excludedPath)) {
        return false;
      }
    }
    return true;
  }
}
