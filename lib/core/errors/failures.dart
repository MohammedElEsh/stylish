import 'package:dio/dio.dart';

import '../shared/feedback/feedback_message.dart';

abstract class Failure {
  final String message;

  const Failure(this.message);

  FeedbackMessage toFeedbackMessage() {
    return FeedbackMessage(
      type: FeedbackType.error,
      description: message,
    );
  }
}

class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure(super.message, {this.statusCode});

  factory ServerFailure.fromDioException(DioException e) {
    final statusCode = e.response?.statusCode;
    final message =
        e.response?.data?['message'] as String? ?? e.message ?? 'Server error';
    return ServerFailure(message, statusCode: statusCode);
  }
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache error occurred']);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Authentication failed']);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'An unexpected error occurred']);
}
