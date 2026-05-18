import 'package:dio/dio.dart';

import 'failures.dart';

class ResponseMessage {
  static const String connectionTimeout = 'Connection timeout';
  static const String cancel = 'Request cancelled';
  static const String receiveTimeout = 'Receive timeout';
  static const String sendTimeout = 'Send timeout';
  static const String cacheError = 'Cache error';
  static const String noInternetConnection = 'No internet connection';
  static const String unKnown = 'Unknown error';
  static const String badCertificate = 'Bad certificate';
  static const String connectionError = 'Connection error';
}

class ErrorHandler {
  static Failure handle(dynamic error) {
    if (error is DioException) {
      return _handleDioException(error);
    }
    return const UnknownFailure();
  }

  static Failure _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure(ResponseMessage.connectionTimeout);
      case DioExceptionType.sendTimeout:
        return const ServerFailure(ResponseMessage.sendTimeout);
      case DioExceptionType.receiveTimeout:
        return const ServerFailure(ResponseMessage.receiveTimeout);
      case DioExceptionType.badCertificate:
        return const ServerFailure(ResponseMessage.badCertificate);
      case DioExceptionType.connectionError:
        return const NetworkFailure(ResponseMessage.connectionError);
      case DioExceptionType.cancel:
        return const ServerFailure(ResponseMessage.cancel);
      case DioExceptionType.badResponse:
        return ServerFailure(
          e.response?.statusMessage ?? ResponseMessage.unKnown,
          statusCode: e.response?.statusCode,
        );
      case DioExceptionType.unknown:
        return const UnknownFailure();
    }
  }
}
