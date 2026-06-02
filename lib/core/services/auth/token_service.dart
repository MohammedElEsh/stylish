import '../logger/logger_service.dart';
import '../storage/secure_storage_service.dart';

class TokenKeys {
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
}

class TokenService {
  final SecureStorageService _secureStorage;

  TokenService({required SecureStorageService secureStorage})
      : _secureStorage = secureStorage;

  Future<String?> getAccessToken() =>
      _secureStorage.read(TokenKeys.accessToken);

  Future<String?> getRefreshToken() =>
      _secureStorage.read(TokenKeys.refreshToken);

  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    await _secureStorage.write(TokenKeys.accessToken, accessToken);
    if (refreshToken != null && refreshToken.isNotEmpty) {
      await _secureStorage.write(TokenKeys.refreshToken, refreshToken);
    }
    LoggerService.i('Tokens saved to SecureStorage', tag: 'TokenService');
  }

  Future<void> clearTokens() async {
    await _secureStorage.delete(TokenKeys.accessToken);
    await _secureStorage.delete(TokenKeys.refreshToken);
    LoggerService.w('Tokens cleared', tag: 'TokenService');
  }
}
