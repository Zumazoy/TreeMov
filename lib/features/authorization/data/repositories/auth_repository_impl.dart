import 'package:flutter/material.dart';
import 'package:treemov/features/authorization/data/datasources/auth_remote_data_source.dart';
import 'package:treemov/features/authorization/data/models/login_request_model.dart';
import 'package:treemov/features/authorization/data/models/login_response_model.dart';
import 'package:treemov/features/authorization/data/models/token_request.dart';
import 'package:treemov/features/authorization/domain/repositories/auth_repository.dart';
import 'package:treemov/features/authorization/domain/repositories/auth_storage_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthStorageRepository _authStorageRepository;

  AuthRepositoryImpl({
    required AuthRemoteDataSource authRemoteDataSource,
    required AuthStorageRepository authStorageRepository,
  }) : _authRemoteDataSource = authRemoteDataSource,
       _authStorageRepository = authStorageRepository;

  @override
  Future<void> token(String email, String password) async {
    try {
      final request = TokenRequest(email: email, password: password);
      final response = await _authRemoteDataSource.token(request);

      if (response.isSuccess) {
        await _authStorageRepository.saveAccessToken(response.accessToken!);
        await _authStorageRepository.saveRefreshToken(response.refreshToken!);
      } else {
        final errorMessage = response.detail ?? 'Unknown authentication error';
        throw Exception(errorMessage);
      }
    } catch (e) {
      debugPrint('❌ Ошибка получения токена: $e');
      rethrow;
    }
  }

  @override
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    return await _authRemoteDataSource.login(request);
  }
}
