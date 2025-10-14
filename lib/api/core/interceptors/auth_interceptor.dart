import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:treemov/data/local/storage_repository.dart';

class AuthInterceptor extends Interceptor {
  final StorageRepository storageRepository;

  AuthInterceptor({required this.storageRepository});

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Пропускаем запросы на аутентификацию
    if (!_isAuthEndpoint(options.path)) {
      try {
        final token = await storageRepository.getAccessToken();

        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
          debugPrint('✅ Token added to request: ${options.path}');
        } else {
          debugPrint('⚠️ No token available for request: ${options.path}');
        }
      } catch (e) {
        debugPrint('❌ Error getting token: $e');
      }
    }

    return handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    debugPrint(
      '✅ Response ${response.statusCode}: ${response.requestOptions.path}',
    );
    return handler.next(response);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    debugPrint('❌ Dio Error: ${err.type} - ${err.message}');
    debugPrint('❌ Path: ${err.requestOptions.path}');

    // Обработка ошибки 401 (Unauthorized)
    if (err.response?.statusCode == 401) {
      debugPrint('🔄 Token expired');

      // Здесь можно добавить логику обновления токена
      // await _refreshTokenAndRetry(err, handler);
      // return;
    }

    return handler.next(err);
  }

  bool _isAuthEndpoint(String path) {
    return path.contains('/token') ||
        path.contains('/auth/sign_up') ||
        path.contains('/auth/confirm_sign_up');
  }
}
