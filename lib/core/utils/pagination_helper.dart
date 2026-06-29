import 'package:flutter/material.dart';

class PaginationHelper {
  static bool onNotification(
    ScrollNotification notification,
    VoidCallback onLoadMore, {
    double scrollThreshold = 0.8,
  }) {
    if (notification is ScrollUpdateNotification) {
      final metrics = notification.metrics;
      if (metrics.pixels / metrics.maxScrollExtent > scrollThreshold) {
        onLoadMore();
        return true;
      }
    }
    return false;
  }
}

class PagedList<T> {
  final List<T> items;
  final int page;
  final bool hasNextPage;

  PagedList({
    required this.items,
    required this.page,
    required this.hasNextPage,
  });

  PagedList<T> copyWith({
    List<T>? items,
    int? page,
    bool? hasNextPage,
  }) {
    return PagedList<T>(
      items: items ?? this.items,
      page: page ?? this.page,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }
}
