import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../services/logger/logger_service.dart';
import '../services/storage/secure_storage_service.dart';
import 'api_consumer.dart';
import 'api_endpoints.dart';
import 'api_interceptors.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;
  final SecureStorageService secureStorage;

  DioConsumer({required this.dio, required this.secureStorage}) {
    dio.options.baseUrl = ApiEndpoints.baseUrl.trim();
    dio.interceptors.add(ApiInterceptors(secureStorage: secureStorage));
    dio.interceptors.add(
      PrettyDioLogger(
        request: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
      ),
    );
  }

  @override
  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    bool isFormData = false,
  }) async {
    final response = await dio.post<dynamic>(
      path,
      queryParameters: queryParameters,
      data:
          isFormData ? FormData.fromMap(data as Map<String, dynamic>) : data,
    );

    LoggerService.d('POST ${dio.options.baseUrl}$path → ${response.statusCode}', tag: 'DioConsumer');

    return response.data;
  }

  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    bool isFormData = false,
  }) async {
    final response = await dio.get<dynamic>(
      path,
      queryParameters: queryParameters,
      data:
          isFormData ? FormData.fromMap(data as Map<String, dynamic>) : data,
    );

    LoggerService.d('GET ${dio.options.baseUrl}$path → ${response.statusCode}', tag: 'DioConsumer');

    return response.data;
  }

  @override
  Future<dynamic> patch(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    bool isFormData = false,
  }) async {
    final response = await dio.patch<dynamic>(
      path,
      queryParameters: queryParameters,
      data:
          isFormData ? FormData.fromMap(data as Map<String, dynamic>) : data,
    );

    LoggerService.d('PATCH ${dio.options.baseUrl}$path → ${response.statusCode}', tag: 'DioConsumer');

    return response.data;
  }

  @override
  Future<dynamic> delete(String path, {bool isFormData = false}) async {
    final response = await dio.delete<dynamic>(
      path,
      data: isFormData ? FormData.fromMap({}) : null,
    );

    LoggerService.d('DELETE ${dio.options.baseUrl}$path → ${response.statusCode}', tag: 'DioConsumer');

    return response.data;
  }
}
