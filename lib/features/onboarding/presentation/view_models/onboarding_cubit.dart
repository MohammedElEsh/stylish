import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final SharedPreferences _prefs;

  OnboardingCubit(this._prefs) : super(const OnboardingState());

  void onPageChanged(int page) {
    emit(state.copyWith(currentPage: page));
  }

  Future<void> complete() async {
    await _prefs.setBool(AppConstants.onboardingKey, true);

    emit(state.copyWith(completed: true));
  }
}
