import 'package:flutter/material.dart';
import 'package:treemov/api/models/token/token_request.dart';
import 'package:treemov/api/services/token_service.dart';
import 'package:treemov/data/local/storage_repository.dart';

class TokenRepository {
  final TokenService _tokenService;
  final StorageRepository _storageRepository;

  TokenRepository({
    required TokenService tokenService,
    required StorageRepository storageRepository,
  }) : _tokenService = tokenService,
       _storageRepository = storageRepository;

  Future<void> getToken(String username, String password) async {
    try {
      final request = TokenRequest(username: username, password: password);
      final response = await _tokenService.getToken(request);

      await _storageRepository.saveAccessToken(response.accessToken);
      await _storageRepository.saveRefreshToken(response.refreshToken);
    } catch (e) {
      debugPrint('Ошибка получения токена: $e');
      rethrow;
    }
  }

  Future<String?> getAccessToken() async {
    return await _storageRepository.getAccessToken();
  }

  Future<String?> getRefreshToken() async {
    return await _storageRepository.getRefreshToken();
  }
}
