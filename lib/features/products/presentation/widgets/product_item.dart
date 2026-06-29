import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/formatters/currency_formatter.dart';
import 'package:stylish/core/theme/typography/app_typography.dart';

import '../../data/models/product_model.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
    this.onTap,
    this.onFavoriteTap,
    this.isFavorite = false,
  });

  final ProductModel product;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final price = CurrencyFormatter.format(product.price);

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(12.r),
      elevation: 2,
      shadowColor: colors.shadow.withValues(alpha: 0.1),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE SECTION
            AspectRatio(
              aspectRatio: 7 / 8,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: _Image(product: product),
                  ),

                  // FAVORITE BUTTON
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: _FavoriteButton(
                      colors: colors,
                      isFavorite: isFavorite,
                      onTap: onFavoriteTap,
                    ),
                  ),
                ],
              ),
            ),

            // INFO SECTION
            Padding(
              padding: EdgeInsets.all(10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.regular12.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.semiBold14,
                  ),
                  SizedBox(height: 18.h),
                  Text(
                    price,
                    style: AppTypography.semiBold18.copyWith(
                      color: colors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    if (product.images.isEmpty) {
      return _fallback(colors);
    }

    return CachedNetworkImage(
      imageUrl: product.images.first,
      fit: BoxFit.cover,
      placeholder: (_, __) => ColoredBox(
        color: colors.surfaceContainerHighest,
      ),
      errorWidget: (_, __, ___) => _fallback(colors),
    );
  }

  Widget _fallback(ColorScheme colors) {
    return ColoredBox(
      color: colors.surfaceContainerHighest,
      child: Icon(
        Icons.image_not_supported_outlined,
        size: 32.r,
        color: colors.onSurfaceVariant,
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton({
    required this.colors,
    required this.isFavorite,
    this.onTap,
  });

  final ColorScheme colors;
  final bool isFavorite;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.surface.withValues(alpha: 0.9),
      borderRadius: BorderRadius.circular(8.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Padding(
          padding: EdgeInsets.all(6.r),
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            size: 18.r,
            color: colors.onSurface,
          ),
        ),
      ),
    );
  }
}
