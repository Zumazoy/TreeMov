import 'package:dio/dio.dart';
import 'package:treemov/core/constants/api_constants.dart';
import 'package:treemov/core/network/auth_interceptor.dart';
import 'package:treemov/core/network/logging_interceptor.dart';
import 'package:treemov/core/storage/storage_repository.dart';

class DioClient {
  late final Dio _dio;
  final StorageRepository storageRepository;

  DioClient({required this.storageRepository}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        validateStatus: (status) =>
            status! < 500, // Разрешаем все статусы кроме 5xx
      ),
    );

    _addInterceptors();
  }

  void _addInterceptors() {
    _dio.interceptors.addAll([
      LoggingInterceptor(),
      AuthInterceptor(storageRepository: storageRepository),
    ]);
  }

  Dio get dio => _dio;

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) {
    return _dio.post(path, data: data);
  }

  Future<Response> put(String path, {dynamic data}) {
    return _dio.put(path, data: data);
  }

  Future<Response> patch(String path, {dynamic data}) {
    return _dio.patch(path, data: data);
  }

  Future<Response> delete(String path, {dynamic data}) {
    return _dio.delete(path, data: data);
  }
}
