import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../services/logger/logger_service.dart';
import 'failures.dart';

typedef EitherResult<T> = Future<Either<Failure, T>>;

Future<Either<Failure, T>> safeCall<T>(Future<T> Function() call) async {
  try {
    final result = await call();
    return Right(result);
  } on Failure catch (e) {
    LoggerService.e('Failure thrown in safeCall: ${e.message}', null, null, 'SafeCall');
    return Left(e);
  } on DioException catch (e) {
    LoggerService.e('DioException in safeCall', e, e.stackTrace, 'SafeCall');
    return Left(_handleDioException(e));
  } on SocketException catch (e) {
    LoggerService.w('SocketException: ${e.message}', tag: 'SafeCall');
    return const Left(NetworkFailure('No internet connection'));
  } catch (e, stack) {
    LoggerService.e('Unknown error in safeCall', e, stack, 'SafeCall');
    return Left(UnknownFailure(e.toString()));
  }
}

Failure _handleDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.sendTimeout:
      LoggerService.w('Connection timed out', tag: 'SafeCall');
      return const NetworkFailure('Connection timed out');
    case DioExceptionType.connectionError:
      LoggerService.w('No internet connection', tag: 'SafeCall');
      return const NetworkFailure('No internet connection');
    case DioExceptionType.badResponse:
      final statusCode = e.response?.statusCode;
      final message = e.response?.data is Map
          ? e.response?.data['message'] ?? 'Server error'
          : 'Server error';
      LoggerService.e('Server response: $statusCode — $message', null, null, 'SafeCall');
      if (statusCode == 401) return const AuthFailure('Incorrect email or password');
      return ServerFailure(message, statusCode: statusCode);
    case DioExceptionType.cancel:
      LoggerService.w('Request cancelled', tag: 'SafeCall');
      return const NetworkFailure('Request cancelled');
    default:
      LoggerService.e('Unknown DioException: ${e.message}', null, null, 'SafeCall');
      return UnknownFailure(e.message ?? 'Unknown error');
  }
}
