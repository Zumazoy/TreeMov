import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoggingInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final method = options.method.toUpperCase();
    final url = options.uri.toString();

    debugPrint('🌐 [$method] $url');

    if (options.data != null) {
      debugPrint('📦 Request Body: ${options.data}');
    }

    if (options.headers.isNotEmpty) {
      debugPrint('📋 Headers: ${options.headers}');
    }

    return handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    final method = response.requestOptions.method.toUpperCase();
    final url = response.requestOptions.uri.toString();
    final statusCode = response.statusCode;

    debugPrint('✅ [$method] $url - $statusCode');

    if (response.data != null) {
      debugPrint('📦 Response Body: ${response.data}');
    }

    return handler.next(response);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final method = err.requestOptions.method.toUpperCase();
    final url = err.requestOptions.uri.toString();
    final statusCode = err.response?.statusCode;

    debugPrint('❌ [$method] $url - $statusCode');
    debugPrint('❌ Error: ${err.type} - ${err.message}');

    if (err.response?.data != null) {
      debugPrint('❌ Error Response: ${err.response?.data}');
    }

    return handler.next(err);
  }
}
