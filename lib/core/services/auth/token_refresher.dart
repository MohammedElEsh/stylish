import 'package:dio/dio.dart';

import '../../networking/api_endpoints.dart';
import '../logger/logger_service.dart';
import 'token_service.dart';

class TokenRefresher {
  final TokenService _tokenService;

  // Separate Dio — no interceptors, never causes a 401 loop
  final _dio = Dio(BaseOptions(
    baseUrl: ApiEndpoints.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  TokenRefresher({required TokenService tokenService})
      : _tokenService = tokenService;

  Future<bool> refresh() async {
    final refreshToken = await _tokenService.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) return false;

    try {
      final res = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.refresh,
        data: {'refreshToken': refreshToken},
      );

      final newAccess = res.data?['access_token'] as String?;
      final newRefresh = res.data?['refresh_token'] as String?;

      if (newAccess == null || newAccess.isEmpty) return false;

      await _tokenService.saveTokens(
        accessToken: newAccess,
        refreshToken: newRefresh,
      );

      LoggerService.i('Token refreshed', tag: 'TokenRefresher');
      return true;
    } catch (e) {
      LoggerService.e('Refresh failed: $e', tag: 'TokenRefresher');
      return false;
    }
  }
}
