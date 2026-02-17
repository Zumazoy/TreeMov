import 'package:flutter/material.dart';
import 'package:treemov/core/constants/api_constants.dart';
import 'package:treemov/core/network/dio_client.dart';
import 'package:treemov/shared/data/models/refresh_request_model.dart';
import 'package:treemov/shared/domain/services/token_refresh_service.dart';
import 'package:treemov/shared/storage/domain/repositories/secure_storage_repository.dart';

class TokenRefreshServiceImpl implements TokenRefreshService {
  final DioClient _dioClient;
  final SecureStorageRepository _secureStorage;
  static Future<String?>? _pendingRefresh;

  TokenRefreshServiceImpl(this._dioClient, this._secureStorage);

  @override
  Future<String?> refreshToken() async {
    // Если уже идет обновление, возвращаем существующий Future
    if (_pendingRefresh != null) {
      return _pendingRefresh;
    }
    _pendingRefresh = _performRefresh();

    try {
      final token = await _pendingRefresh;
      return token;
    } finally {
      _pendingRefresh = null;
    }
  }

  Future<String?> _performRefresh() async {
    try {
      final refreshToken = await _secureStorage.getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        debugPrint('❌ No refresh token available');
        return null;
      }

      debugPrint('🔄 Refreshing token...');

      final response = await _dioClient.post(
        ApiConstants.authUrl + ApiConstants.refresh,
        data: RefreshRequestModel(refreshToken: refreshToken),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final newAccessToken = response.data['access_token'];

        if (newAccessToken != null) {
          await _secureStorage.saveAccessToken(newAccessToken);
          debugPrint('✅ Token refreshed successfully');
          return newAccessToken;
        }
      }

      debugPrint('❌ Token refresh failed');
      return null;
    } catch (e) {
      debugPrint('❌ Token refresh error: $e');
      return null;
    }
  }
}
