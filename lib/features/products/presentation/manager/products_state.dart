import 'package:equatable/equatable.dart';

import '../../data/models/product_model.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object?> get props => [];
}

final class ProductsInitial extends ProductsState {
  const ProductsInitial();
}

final class ProductsLoading extends ProductsState {
  const ProductsLoading();
}

final class ProductsPaginationLoading extends ProductsState {
  final List<ProductModel> currentProducts;

  const ProductsPaginationLoading({required this.currentProducts});

  @override
  List<Object?> get props => [currentProducts];
}

final class ProductsSuccess extends ProductsState {
  final List<ProductModel> products;
  final bool hasMore;

  const ProductsSuccess({
    required this.products,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [products, hasMore];
}

final class ProductsFailure extends ProductsState {
  final String errorMessage;

  const ProductsFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

final class ProductsPaginationFailure extends ProductsState {
  final String errorMessage;
  final List<ProductModel> currentProducts;

  const ProductsPaginationFailure({
    required this.errorMessage,
    required this.currentProducts,
  });

  @override
  List<Object?> get props => [errorMessage, currentProducts];
}
