import 'dart:async';

import 'package:dio/dio.dart';

import '../services/auth/token_refresher.dart';
import '../services/auth/token_service.dart';
import '../services/logger/logger_service.dart';
import '../services/session/session_manager.dart';

class ApiInterceptors extends Interceptor {
  final Dio _dio;
  final TokenService _tokenService;
  final TokenRefresher _tokenRefresher;
  final SessionManager _sessionManager;

  bool _isRefreshing = false;
  final List<Completer<void>> _queue = [];

  ApiInterceptors({
    required Dio dio,
    required TokenService tokenService,
    required TokenRefresher tokenRefresher,
    required SessionManager sessionManager,
  })  : _dio = dio,
        _tokenService = tokenService,
        _tokenRefresher = tokenRefresher,
        _sessionManager = sessionManager;

  // ── Attach token to every request ─────────────────────────────────────────

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenService.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  // ── Handle 401 ────────────────────────────────────────────────────────────

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401) return handler.next(err);
    if (err.requestOptions.extra['retried'] == true) {
      await _sessionManager.logout();
      return handler.next(err);
    }

    // ── Queue: wait if refresh is already running ──────────────────────────
    if (_isRefreshing) {
      final completer = Completer<void>();
      _queue.add(completer);
      try {
        await completer.future;
      } catch (_) {
        return handler.next(err);
      }
    }

    // ── Refresh ────────────────────────────────────────────────────────────
    else {
      _isRefreshing = true;
      final refreshed = await _tokenRefresher.refresh();
      _isRefreshing = false;

      if (!refreshed) {
        _queue
          ..forEach((c) => c.completeError('Refresh failed'))
          ..clear();
        await _tokenService.clearTokens();
        await _sessionManager.logout();
        return handler.next(err);
      }

      _queue
        ..forEach((c) => c.complete())
        ..clear();
    }

    // ── Retry original request with new token ──────────────────────────────
    try {
      final token = await _tokenService.getAccessToken() ?? '';
      err.requestOptions
        ..extra['retried'] = true
        ..headers['Authorization'] = 'Bearer $token';
      handler.resolve(await _dio.fetch<dynamic>(err.requestOptions));
    } catch (e, st) {
      LoggerService.e('Retry failed',
          error: e, stackTrace: st, tag: 'ApiInterceptors');
      handler.next(err);
    }
  }
}
