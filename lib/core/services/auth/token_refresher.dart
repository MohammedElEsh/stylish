import 'dart:async';

import 'package:dio/dio.dart';

import '../../networking/api_endpoints.dart';
import '../logger/logger_service.dart';
import 'token_service.dart';

class TokenRefresher {
  final TokenService _tokenService;

  final Dio _authDio;

  bool _complete(bool value) {
    if (!(_refreshCompleter?.isCompleted ?? true)) {
      _refreshCompleter!.complete(value);
    }
    _refreshCompleter = null;
    return value;
  }

  Completer<bool>? _refreshCompleter;

  TokenRefresher({
    required TokenService tokenService,
    Dio? authDio,
  })  : _tokenService = tokenService,
        _authDio = authDio ??
            Dio(
              BaseOptions(
                baseUrl: ApiEndpoints.baseUrl,
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
              ),
            );

  Future<bool> refresh() async {
    if (_refreshCompleter != null) {
      LoggerService.d(
        'Refresh already in-flight, waiting…',
        tag: 'TokenRefresher',
      );
      return _refreshCompleter!.future;
    }

    final storedRefreshToken = await _tokenService.getRefreshToken();
    if (storedRefreshToken == null || storedRefreshToken.isEmpty) {
      LoggerService.w('No refresh token available', tag: 'TokenRefresher');
      return false;
    }

    _refreshCompleter = Completer<bool>();
    try {
      final response = await _authDio.post<dynamic>(
        ApiEndpoints.refresh,
        data: {'refreshToken': storedRefreshToken},
      );

      final data = response.data;
      if (data is! Map) {
        return _complete(false);
      }

      final newAccess = data['access_token'] as String?;
      final newRefresh = data['refresh_token'] as String?;

      if (newAccess == null || newAccess.isEmpty) {
        return _complete(false);
      }

      await _tokenService.saveTokens(
        accessToken: newAccess,
        refreshToken: newRefresh,
      );
      LoggerService.i('Token refresh succeeded', tag: 'TokenRefresher');
      return _complete(true);
    } catch (e, st) {
      LoggerService.e(
        'Token refresh failed',
        error: e,
        stackTrace: st,
        tag: 'TokenRefresher',
      );
      return _complete(false);
    }
  }
}
