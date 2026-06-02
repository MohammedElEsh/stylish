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

  Future<bool>? _refreshFuture;

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
    LoggerService.d(
      '→ ${options.method} ${options.path}',
      tag: 'NETWORK',
    );
    handler.next(options);
  }

  // ── Handle 401 ────────────────────────────────────────────────────────────

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401) return handler.next(err);

    LoggerService.w(
      '401 on ${err.requestOptions.method} ${err.requestOptions.path}',
      tag: 'AUTH',
    );

    // Already retried — break the loop
    if (err.requestOptions.extra['retried'] == true) {
      LoggerService.e(
        'Retry also returned 401 — forcing logout',
        tag: 'AUTH',
      );
      await _sessionManager.logout();
      return handler.next(err);
    }

    // Single-flight: start refresh or join the one already running
    final isLeader = _refreshFuture == null;
    if (isLeader) {
      LoggerService.i('Starting token refresh', tag: 'AUTH');
    } else {
      LoggerService.d('Joining in-flight refresh', tag: 'AUTH');
    }

    _refreshFuture ??= _tokenRefresher.refresh();
    final refreshed = await _refreshFuture!;
    _refreshFuture = null;

    if (!refreshed) {
      LoggerService.e('Token refresh failed — logging out', tag: 'AUTH');
      await _sessionManager.logout();
      return handler.next(err);
    }

    LoggerService.i(
      'Retrying ${err.requestOptions.method} ${err.requestOptions.path}',
      tag: 'NETWORK',
    );

    // Retry with new token — no mutation of original RequestOptions
    try {
      final token = await _tokenService.getAccessToken() ?? '';
      final response = await _dio.request<dynamic>(
        err.requestOptions.path,
        data: err.requestOptions.data,
        queryParameters: err.requestOptions.queryParameters,
        options: Options(
          method: err.requestOptions.method,
          headers: {
            ...err.requestOptions.headers,
            'Authorization': 'Bearer $token',
          },
          extra: {
            ...err.requestOptions.extra,
            'retried': true,
          },
          contentType: err.requestOptions.contentType,
          responseType: err.requestOptions.responseType,
        ),
      );
      handler.resolve(response);
    } catch (e, st) {
      LoggerService.e(
        'Retry failed for ${err.requestOptions.method} ${err.requestOptions.path}',
        error: e,
        stackTrace: st,
        tag: 'NETWORK',
      );
      handler.next(err);
    }
  }
}
