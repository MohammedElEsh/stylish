import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial());

  Future<void> load() async {
    emit(const HomeInitial());
    emit(const HomeLoading());
  }
}
