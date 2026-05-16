import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/session/session_manager.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final SessionManager _sessionManager;

  OnboardingCubit(this._sessionManager) : super(const OnboardingState());

  void onPageChanged(int page) {
    emit(state.copyWith(currentPage: page));
  }

  Future<void> complete() async {
    await _sessionManager.completeOnboarding();
    emit(state.copyWith(completed: true));
  }
}
