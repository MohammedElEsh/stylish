import '../../../../core/errors/safe_call.dart';
import '../models/auth_tokens.dart';

abstract class AuthRepository {
  EitherResult<AuthTokens> login({
    required String email,
    required String password,
  });
}
