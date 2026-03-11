import 'package:dio/dio.dart';
import 'package:treemov/core/network/dio_client.dart';

/// Базовый класс для всех Remote Data Source
abstract class BaseRemoteDataSource {
  final DioClient _dioClient;

  BaseRemoteDataSource(this._dioClient);

  Dio get _dio => _dioClient.dio;

  /// GET запрос с возвратом списка объектов
  Future<List<T>> getList<T>({
    required String path,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? queryParameters,
    String? baseUrl,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: baseUrl != null ? Options(extra: {'baseUrl': baseUrl}) : null,
      );
      return _parseListResponse(response, fromJson);
    } catch (e) {
      throw _handleError(e, 'Ошибка загрузки $path');
    }
  }

  /// GET запрос с возвратом одного объекта
  Future<T> getOne<T>({
    required String path,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? queryParameters,
    String? baseUrl,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: baseUrl != null ? Options(extra: {'baseUrl': baseUrl}) : null,
      );
      return _parseSingleResponse(response, fromJson);
    } catch (e) {
      throw _handleError(e, 'Ошибка загрузки $path');
    }
  }

  /// POST запрос с возвратом объекта
  Future<T> post<T>({
    required String path,
    required T Function(Map<String, dynamic>) fromJson,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String? baseUrl,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: baseUrl != null ? Options(extra: {'baseUrl': baseUrl}) : null,
      );
      return _parseSingleResponse(response, fromJson);
    } catch (e) {
      throw _handleError(e, 'Ошибка создания $path');
    }
  }

  /// POST запрос без возврата данных
  Future<void> postVoid({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String? baseUrl,
  }) async {
    try {
      await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: baseUrl != null ? Options(extra: {'baseUrl': baseUrl}) : null,
      );
    } catch (e) {
      throw _handleError(e, 'Ошибка выполнения $path');
    }
  }

  /// POST запрос с возвратом bool
  Future<bool> postBool({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String? baseUrl,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: baseUrl != null ? Options(extra: {'baseUrl': baseUrl}) : null,
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      throw _handleError(e, 'Ошибка выполнения $path');
    }
  }

  /// PUT запрос с возвратом объекта
  Future<T> put<T>({
    required String path,
    required T Function(Map<String, dynamic>) fromJson,
    dynamic data,
    String? baseUrl,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        options: baseUrl != null ? Options(extra: {'baseUrl': baseUrl}) : null,
      );
      return _parseSingleResponse(response, fromJson);
    } catch (e) {
      throw _handleError(e, 'Ошибка обновления $path');
    }
  }

  /// PATCH запрос с возвратом объекта
  Future<T> patch<T>({
    required String path,
    required T Function(Map<String, dynamic>) fromJson,
    dynamic data,
    String? baseUrl,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        options: baseUrl != null ? Options(extra: {'baseUrl': baseUrl}) : null,
      );
      return _parseSingleResponse(response, fromJson);
    } catch (e) {
      throw _handleError(e, 'Ошибка частичного обновления $path');
    }
  }

  /// DELETE запрос
  Future<void> delete({
    required String path,
    Map<String, dynamic>? queryParameters,
    String? baseUrl,
  }) async {
    try {
      await _dio.delete(
        path,
        queryParameters: queryParameters,
        options: baseUrl != null ? Options(extra: {'baseUrl': baseUrl}) : null,
      );
    } catch (e) {
      throw _handleError(e, 'Ошибка удаления $path');
    }
  }

  /// Парсинг ответа как списка
  List<T> _parseListResponse<T>(
    Response response,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final data = response.data;
    if (data is List) {
      return data
          .whereType<Map<String, dynamic>>()
          .map((json) => fromJson(json))
          .toList();
    } else if (data is Map<String, dynamic>) {
      // Если сервер вернул один объект вместо списка
      return [fromJson(data)];
    }
    throw Exception('Некорректный формат ответа: ожидается List');
  }

  /// Парсинг ответа как одного объекта
  T _parseSingleResponse<T>(
    Response response,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final data = response.data;
    if (data is Map<String, dynamic>) {
      return fromJson(data);
    } else if (data is List && data.isNotEmpty) {
      // Если сервер вернул список вместо одного объекта
      return fromJson(data.first as Map<String, dynamic>);
    }
    throw Exception('Некорректный формат ответа: ожидается Map');
  }

  /// Обработка ошибок
  Exception _handleError(dynamic error, String defaultMessage) {
    if (error is DioException) {
      final statusCode = error.response?.statusCode;
      final responseData = error.response?.data;

      // Пробуем получить сообщение об ошибке от сервера
      String errorMessage = defaultMessage;
      if (responseData is Map<String, dynamic>) {
        errorMessage = responseData['detail'] ?? defaultMessage;
      } else if (responseData is String) {
        errorMessage = responseData;
      }

      return Exception('[$statusCode] $errorMessage');
    }
    return Exception('$defaultMessage: $error');
  }

  /// Метод для полного контроля когда нужна кастомная логика
  Future<Response> rawGet(
    String path, {
    Map<String, dynamic>? queryParameters,
    String? baseUrl,
  }) async {
    return _dio.get(
      path,
      queryParameters: queryParameters,
      options: baseUrl != null ? Options(extra: {'baseUrl': baseUrl}) : null,
    );
  }

  /// Метод для полного контроля когда нужна кастомная логика
  Future<Response> rawPost(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String? baseUrl,
  }) async {
    return _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: baseUrl != null ? Options(extra: {'baseUrl': baseUrl}) : null,
    );
  }
}
