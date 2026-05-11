import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'failures.dart';

typedef EitherResult<T> = Future<Either<Failure, T>>;

Future<Either<Failure, T>> safeCall<T>(Future<T> Function() call) async {
  try {
    final result = await call();
    return Right(result);
  } on DioException catch (e) {
    return Left(_handleDioException(e));
  } on SocketException {
    return const Left(NetworkFailure());
  } catch (e) {
    return Left(UnknownFailure(e.toString()));
  }
}

Failure _handleDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.sendTimeout:
      return const NetworkFailure('Connection timed out');
    case DioExceptionType.connectionError:
      return const NetworkFailure();
    case DioExceptionType.badResponse:
      final statusCode = e.response?.statusCode;
      final message = e.response?.data is Map
          ? e.response?.data['message'] ?? 'Server error'
          : 'Server error';
      if (statusCode == 401) return AuthFailure(message);
      return ServerFailure(message, statusCode: statusCode);
    default:
      return UnknownFailure(e.message ?? 'Unknown error');
  }
}
