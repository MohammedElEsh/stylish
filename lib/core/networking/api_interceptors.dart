import 'package:dio/dio.dart';

import '../services/auth/token_refresher.dart';
import '../services/auth/token_service.dart';
import '../services/logger/logger_service.dart';
import '../services/session/session_manager.dart';

class ApiInterceptors extends Interceptor {
  final Dio dio;
  final TokenService _tokenService;
  final TokenRefresher _tokenRefresher;

  /// Called when all refresh/retry attempts have been exhausted.
  Future<void> Function()? _onAuthFailure;

  ApiInterceptors({
    required this.dio,
    required TokenService tokenService,
    required TokenRefresher tokenRefresher,
  })  : _tokenService = tokenService,
        _tokenRefresher = tokenRefresher;

  void attachSessionManager(SessionManager sessionManager) {
    _onAuthFailure = sessionManager.logout;
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenService.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    LoggerService.d(
      '→ ${options.method} ${options.baseUrl}${options.path}',
      tag: 'ApiInterceptors',
    );
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401) {
      handler.next(err);
      return;
    }

    // ── Guard: already retried once — prevent infinite loop ──────────────────
    if (err.requestOptions.extra['retried'] == true) {
      LoggerService.w(
        'Request already retried once — logging out',
        tag: 'ApiInterceptors',
      );
      await _performLogout();
      handler.next(err);
      return;
    }

    // ── Attempt refresh (single-flight is handled inside TokenRefresher) ─────
    LoggerService.w(
      '401 received — attempting token refresh',
      tag: 'ApiInterceptors',
    );

    final refreshed = await _tokenRefresher.refresh();

    if (refreshed) {
      await _retryRequest(err, handler);
    } else {
      LoggerService.e(
        'Refresh failed after 401 — logging out',
        tag: 'ApiInterceptors',
      );
      await _tokenService.clearTokens();
      await _performLogout();
      handler.next(err);
    }
  }

  Future<void> _retryRequest(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      final token = await _tokenService.getAccessToken() ?? '';
      final options = err.requestOptions
        ..extra['retried'] = true
        ..headers['Authorization'] = 'Bearer $token';

      LoggerService.d(
        'Retrying ${options.method} ${options.baseUrl}${options.path}',
        tag: 'ApiInterceptors',
      );
      handler.resolve(await dio.fetch<dynamic>(options));
    } catch (e, st) {
      LoggerService.e(
        'Retry failed',
        error: e,
        stackTrace: st,
        tag: 'ApiInterceptors',
      );
      handler.next(err);
    }
  }

  Future<void> _performLogout() async {
    LoggerService.w('Auth failure — triggering logout', tag: 'ApiInterceptors');
    await _onAuthFailure?.call();
  }
}
