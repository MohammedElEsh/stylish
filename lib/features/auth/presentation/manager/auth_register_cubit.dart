import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/logger/logger_service.dart';
import '../../../../core/shared/feedback/feedback_handler.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';
import 'auth_register_state.dart';

class AuthRegisterCubit extends Cubit<AuthRegisterState> {
  final AuthRepository _repository;

  AuthRegisterCubit({
    required AuthRepository repository,
  })  : _repository = repository,
        super(const AuthRegisterInitial());

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    LoggerService.i('Checking email availability for: $email', tag: 'AuthRegisterCubit');
    emit(const AuthRegisterLoading());

    final availabilityResult = await _repository.checkEmailAvailability(
      email: email,
    );

    final isAvailable = availabilityResult.fold(
      (failure) {
        LoggerService.w('Email check failed: ${failure.message}', tag: 'AuthRegisterCubit');
        FeedbackHandler.error(failure.message);
        emit(AuthRegisterError(message: failure.message));
        return false;
      },
      (isAvailable) => isAvailable,
    );

    if (!isAvailable) {
      LoggerService.w('Email already registered: $email', tag: 'AuthRegisterCubit');
      FeedbackHandler.error('Email is already registered');
      emit(const AuthRegisterError(message: 'Email is already registered'));
      return;
    }

    LoggerService.i('Attempting registration for: $email', tag: 'AuthRegisterCubit');

    final result = await _repository.register(
      name: name,
      email: email,
      password: password,
    );

    result.fold(
      (failure) {
        LoggerService.w('Registration failed: ${failure.message}', tag: 'AuthRegisterCubit');
        FeedbackHandler.error(failure.message);
        emit(AuthRegisterError(message: failure.message));
      },
      (UserModel user) {
        LoggerService.i('Registration successful for: ${user.email}', tag: 'AuthRegisterCubit');
        FeedbackHandler.success('Account created successfully');
        emit(const AuthRegisterSuccess());
      },
    );
  }
}
