import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/logger/logger_service.dart';
import '../../../../core/shared/feedback/feedback_handler.dart';
import '../../data/repositories/categories_repository.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesRepository _repository;

  CategoriesCubit({required CategoriesRepository repository})
      : _repository = repository,
        super(const CategoriesInitial());

  Future<void> loadCategories() async {
    LoggerService.i('Loading categories', tag: 'CategoriesCubit');
    emit(const CategoriesLoading());

    final result = await _repository.getCategories();

    result.fold(
      (failure) {
        LoggerService.w(
          'Categories load failed: ${failure.message}',
          tag: 'CategoriesCubit',
        );
        FeedbackHandler.error(failure.message);
        emit(CategoriesError(message: failure.message));
      },
      (categories) {
        LoggerService.i(
          'Categories loaded: ${categories.length}',
          tag: 'CategoriesCubit',
        );
        emit(CategoriesLoaded(categories: categories));
      },
    );
  }
}
