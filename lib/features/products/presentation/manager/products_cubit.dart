import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/logger/logger_service.dart';
import '../../../../core/shared/feedback/feedback_handler.dart';
import '../../data/repositories/products_repository.dart';
import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepository _repository;
  static const int _defaultLimit = 10;
  int _currentOffset = 0;

  ProductsCubit({required ProductsRepository repository})
      : _repository = repository,
        super(const ProductsInitial());

  Future<void> fetchProducts() async {
    LoggerService.i('Loading products', tag: 'ProductsCubit');
    emit(const ProductsLoading());
    _currentOffset = 0;

    final result =
        await _repository.getProducts(offset: 0, limit: _defaultLimit);

    result.fold(
      (failure) {
        LoggerService.w(
          'Products load failed: ${failure.message}',
          tag: 'ProductsCubit',
        );
        FeedbackHandler.error(failure.message);
        emit(ProductsFailure(errorMessage: failure.message));
      },
      (products) {
        LoggerService.i(
          'Products loaded: ${products.length}',
          tag: 'ProductsCubit',
        );
        _currentOffset = products.length;
        emit(ProductsSuccess(
          products: products,
          hasMore: products.length >= _defaultLimit,
        ));
      },
    );
  }

  Future<void> fetchMoreProducts() async {
    final currentState = state;
    if (currentState is! ProductsSuccess) return;
    if (!currentState.hasMore) return;

    LoggerService.i('Loading more products', tag: 'ProductsCubit');
    emit(ProductsPaginationLoading(
      currentProducts: currentState.products,
    ));

    final result = await _repository.getProducts(
      offset: _currentOffset,
      limit: _defaultLimit,
    );

    result.fold(
      (failure) {
        LoggerService.w(
          'Products load more failed: ${failure.message}',
          tag: 'ProductsCubit',
        );
        FeedbackHandler.error(failure.message);
        emit(ProductsPaginationFailure(
          errorMessage: failure.message,
          currentProducts: currentState.products,
        ));
      },
      (newProducts) {
        final allProducts = [...currentState.products, ...newProducts];
        _currentOffset = allProducts.length;
        LoggerService.i(
          'Products loaded more: ${newProducts.length}, total: ${allProducts.length}',
          tag: 'ProductsCubit',
        );
        emit(ProductsSuccess(
          products: allProducts,
          hasMore: newProducts.length >= _defaultLimit,
        ));
      },
    );
  }
}
