import '../../../../core/errors/failures.dart';
import '../../../../core/errors/safe_call.dart';
import '../../../../core/networking/api_consumer.dart';
import '../../../../core/networking/api_endpoints.dart';
import '../models/auth_tokens.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiConsumer apiConsumer;

  AuthRepositoryImpl({required this.apiConsumer});

  @override
  EitherResult<AuthTokens> login({
    required String email,
    required String password,
  }) {
    return safeCall(() async {
      final response = await apiConsumer.post(
        ApiEndpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response is! Map<String, dynamic>) {
        throw const ServerFailure('Unexpected response format');
      }

      if (!response.containsKey('access_token') || !response.containsKey('refresh_token')) {
        final message = response['message'] as String?;
        throw ServerFailure(message ?? 'Incorrect email or password');
      }

      return AuthTokens.fromJson(response);
    });
  }
}
