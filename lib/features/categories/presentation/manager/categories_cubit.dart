import 'package:flutter_bloc/flutter_bloc.dart';

import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(const CategoriesInitial());

  Future<void> load() async {
    emit(const CategoriesInitial());
    emit(const CategoriesLoading());
  }
}
