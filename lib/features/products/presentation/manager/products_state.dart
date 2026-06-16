import 'package:equatable/equatable.dart';

import '../../data/models/product_model.dart';

class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object?> get props => [];
}

class ProductsInitial extends ProductsState {
  const ProductsInitial();
}

class ProductsLoading extends ProductsState {
  const ProductsLoading();
}

class ProductsLoaded extends ProductsState {
  final List<ProductModel> products;
  final bool hasMore;
  final int offset;
  final bool isLoadingMore;

  const ProductsLoaded({
    required this.products,
    required this.hasMore,
    required this.offset,
    this.isLoadingMore = false,
  });

  @override
  List<Object?> get props => [products, hasMore, offset, isLoadingMore];
}

class ProductsError extends ProductsState {
  final String message;

  const ProductsError({required this.message});

  @override
  List<Object?> get props => [message];
}