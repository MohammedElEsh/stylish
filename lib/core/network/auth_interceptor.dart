import 'package:dio/dio.dart';
import '../constants/app_constants.dart';
import '../services/storage/secure_storage_service.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorageService _secureStorage;

  AuthInterceptor(this._secureStorage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _secureStorage.read(AppConstants.tokenKey);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await _secureStorage.delete(AppConstants.tokenKey);
      await _secureStorage.delete(AppConstants.refreshTokenKey);
      // Logic for redirecting to login should be handled via GoRouter
      // or a listener on the session state.
    }
    handler.next(err);
  }
}
