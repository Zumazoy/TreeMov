import 'package:flutter/material.dart';
import 'package:treemov/core/storage/storage_repository.dart';
import 'package:treemov/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:treemov/features/auth/data/models/token_request.dart';
import 'package:treemov/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _tokenService;
  final StorageRepository _storageRepository;

  AuthRepositoryImpl({
    required AuthRemoteDataSource tokenService,
    required StorageRepository storageRepository,
  }) : _tokenService = tokenService,
       _storageRepository = storageRepository;

  @override
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

  @override
  Future<String?> getAccessToken() async {
    return await _storageRepository.getAccessToken();
  }

  @override
  Future<String?> getRefreshToken() async {
    return await _storageRepository.getRefreshToken();
  }
}
