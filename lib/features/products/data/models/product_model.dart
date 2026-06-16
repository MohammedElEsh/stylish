import 'package:equatable/equatable.dart';

import '../../../../features/categories/data/models/category_model.dart';

class ProductModel extends Equatable {
  final int id;
  final String title;
  final String slug;
  final double price;
  final String description;
  final CategoryModel category;
  final List<String> images;
  final DateTime creationAt;
  final DateTime updatedAt;

  const ProductModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
    required this.creationAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] as String? ?? '',
      category: CategoryModel.fromJson(
        json['category'] as Map<String, dynamic>? ?? {},
      ),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(growable: false) ??
          const [],
      creationAt: DateTime.tryParse(json['creationAt'] as String? ?? '') ??
          DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? '') ??
          DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        slug,
        price,
        description,
        category,
        images,
        creationAt,
        updatedAt,
      ];
}
