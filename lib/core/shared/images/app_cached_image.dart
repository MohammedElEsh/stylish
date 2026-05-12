import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppCachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double borderRadius;

  const AppCachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => Skeletonizer(
          child: Container(
            width: width,
            height: height,
            color: Colors.grey[300],
          ),
        ),
        errorWidget: (context, url, error) => Container(
          width: width,
          height: height,
          color: Colors.grey[200],
          child: const Icon(Icons.error),
        ),
      ),
    );
  }
}
