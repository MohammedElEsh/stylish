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
    if (refreshToken == null || refreshToken.isEmpty) {
      LoggerService.w('No refresh token stored — cannot refresh', tag: 'AUTH');
      return false;
    }

    try {
      final res = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.refresh,
        data: {'refreshToken': refreshToken},
      );

      final newAccess = res.data?['access_token'] as String?;
      final newRefresh = res.data?['refresh_token'] as String?;

      if (newAccess == null || newAccess.isEmpty) {
        LoggerService.e(
          'Refresh response missing access_token',
          tag: 'AUTH',
        );
        return false;
      }

      await _tokenService.saveTokens(
        accessToken: newAccess,
        refreshToken: newRefresh,
      );

      LoggerService.i('Token refresh succeeded — new tokens saved',
          tag: 'AUTH');
      return true;
    } catch (e, st) {
      LoggerService.e(
        'Token refresh request failed',
        error: e,
        stackTrace: st,
        tag: 'AUTH',
      );
      return false;
    }
  }
}
