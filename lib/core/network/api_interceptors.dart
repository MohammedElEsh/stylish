import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['token'] = 'Bearer YOUR_ACCESS_TOKEN';
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    debugPrint(
        'Response: ${response.statusCode} ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('Error: ${err.message} ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}
