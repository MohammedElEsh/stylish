import 'package:dio/dio.dart';

import '../services/logger/logger_service.dart';
import '../services/storage/secure_storage_service.dart';

class ApiInterceptors extends Interceptor {
  final SecureStorageService? secureStorage;

  ApiInterceptors({this.secureStorage});

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (secureStorage != null) {
      final token = await secureStorage!.read('access_token');
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
        LoggerService.d('Token injected for: ${options.path}', tag: 'ApiInterceptor');
      }
    }
    LoggerService.d('${options.method} ${options.baseUrl}${options.path}', tag: 'ApiInterceptor');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    LoggerService.d(
      'Response: ${response.statusCode} ${response.requestOptions.path}',
      tag: 'ApiInterceptor',
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    LoggerService.e(
      'Error: ${err.type} — ${err.message}',
      err,
      err.stackTrace,
      'ApiInterceptor',
    );
    super.onError(err, handler);
  }
}
