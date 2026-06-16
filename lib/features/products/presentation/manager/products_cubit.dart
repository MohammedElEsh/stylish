import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/logger/logger_service.dart';
import '../../../../core/shared/feedback/feedback_handler.dart';
import '../../data/repositories/products_repository.dart';
import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepository _repository;
  static const int _defaultLimit = 10;
  bool _isLoadingMore = false;

  ProductsCubit({required ProductsRepository repository})
      : _repository = repository,
        super(const ProductsInitial());

  Future<void> loadProducts() async {
    LoggerService.i('Loading products', tag: 'ProductsCubit');
    emit(const ProductsLoading());

    final result =
        await _repository.getProducts(offset: 0, limit: _defaultLimit);

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
        emit(ProductsLoaded(
          products: products,
          hasMore: products.length >= _defaultLimit,
          offset: products.length,
        ));
      },
    );
  }

  Future<void> loadMore() async {
    final currentState = state;
    if (_isLoadingMore) return;
    if (currentState is! ProductsLoaded) return;
    if (!currentState.hasMore) return;

    _isLoadingMore = true;
    LoggerService.i('Loading more products', tag: 'ProductsCubit');
    emit(ProductsLoaded(
      products: currentState.products,
      hasMore: currentState.hasMore,
      offset: currentState.offset,
      isLoadingMore: true,
    ));

    final result = await _repository.getProducts(
      offset: currentState.offset,
      limit: _defaultLimit,
    );

    result.fold(
      (failure) {
        _isLoadingMore = false;
        LoggerService.w(
          'Products load more failed: ${failure.message}',
          tag: 'ProductsCubit',
        );
        FeedbackHandler.error(failure.message);
        emit(ProductsLoaded(
          products: currentState.products,
          hasMore: currentState.hasMore,
          offset: currentState.offset,
          isLoadingMore: false,
        ));
      },
      (newProducts) {
        _isLoadingMore = false;
        final allProducts = [...currentState.products, ...newProducts];
        LoggerService.i(
          'Products loaded more: ${newProducts.length}, total: ${allProducts.length}',
          tag: 'ProductsCubit',
        );
        emit(ProductsLoaded(
          products: allProducts,
          hasMore: newProducts.length >= _defaultLimit,
          offset: allProducts.length,
          isLoadingMore: false,
        ));
      },
    );
  }
}
