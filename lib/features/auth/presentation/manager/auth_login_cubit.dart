import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/logger/logger_service.dart';
import '../../../../core/shared/feedback/feedback_handler.dart';
import '../../data/repositories/auth_repository.dart';
import 'auth_login_state.dart';

class AuthLoginCubit extends Cubit<AuthLoginState> {
  final AuthRepository _repository;

  AuthLoginCubit({required AuthRepository repository})
      : _repository = repository,
        super(const AuthLoginInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    LoggerService.i('Attempting login for: $email', tag: 'AuthLoginCubit');
    emit(const AuthLoginLoading());

    final result = await _repository.login(
      email: email,
      password: password,
    );

    result.fold(
      (failure) {
        LoggerService.w(
          'Login failed: ${failure.message}',
          tag: 'AuthLoginCubit',
        );
        FeedbackHandler.error(failure.message);
        emit(AuthLoginError(message: failure.message));
      },
      (tokens) {
        // SessionManager.login() already saved + validated the tokens and
        // notified its listeners, so the router guard redirects automatically.
        LoggerService.i('Login succeeded', tag: 'AuthLoginCubit');
        // FeedbackHandler.success('Logged in successfully');
        emit(const AuthLoginSuccess());
      },
    );
  }
}
