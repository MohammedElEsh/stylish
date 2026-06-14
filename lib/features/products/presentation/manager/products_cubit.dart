import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/logger/logger_service.dart';
import '../../../../core/shared/feedback/feedback_handler.dart';
import '../../data/repositories/products_repository.dart';
import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepository _repository;

  ProductsCubit({required ProductsRepository repository})
      : _repository = repository,
        super(const ProductsInitial());

  Future<void> loadProducts() async {
    LoggerService.i('Loading products', tag: 'ProductsCubit');
    emit(const ProductsLoading());

    final result = await _repository.getProducts();

    result.fold(
      (failure) {
        LoggerService.w(
          'Products load failed: ${failure.message}',
          tag: 'ProductsCubit',
        );
        FeedbackHandler.error(failure.message);
        emit(ProductsError(message: failure.message));
      },
      (products) {
        LoggerService.i(
          'Products loaded: ${products.length}',
          tag: 'ProductsCubit',
        );
        emit(ProductsLoaded(products: products));
      },
    );
  }
}