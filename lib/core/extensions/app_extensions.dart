import 'package:flutter/material.dart';

extension StringExtensions on String {
  String get capitalize =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';

  String get capitalizeFirst =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  bool get isValidEmail =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);

  bool get isValidPhone =>
      RegExp(r'^\+?[\d\s\-()]{7,15}$').hasMatch(this);

  bool get isValidPassword => length >= 6;

  bool get isNumeric => RegExp(r'^-?\d+(\.\d+)?$').hasMatch(this);

  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$suffix';
  }

  String get hardcoded =>
      this; // For easy identification of non-localized strings
}

extension NumExtensions on num {
  Widget get verticalSpace => SizedBox(height: toDouble());
  Widget get horizontalSpace => SizedBox(width: toDouble());

  String get toFileSize {
    if (this < 1024) return '${toStringAsFixed(0)} B';
    if (this < 1048576) return '${(this / 1024).toStringAsFixed(1)} KB';
    if (this < 1073741824) return '${(this / 1048576).toStringAsFixed(1)} MB';
    return '${(this / 1073741824).toStringAsFixed(2)} GB';
  }
}

extension ListExtensions<T> on List<T> {
  T? get firstOrNull => isNotEmpty ? first : null;

  T? get lastOrNull => isNotEmpty ? last : null;

  List<T> separated(T separator) {
    if (isEmpty) return [];
    final result = <T>[];
    for (var i = 0; i < length; i++) {
      result.add(this[i]);
      if (i != length - 1) result.add(separator);
    }
    return result;
  }

  List<T> get unique => toSet().toList();

  List<T> whereNotNull() => where((e) => e != null).cast<T>().toList();

  List<List<T>> chunk(int size) {
    if (size <= 0) throw ArgumentError('Chunk size must be positive');
    final chunks = <List<T>>[];
    for (var i = 0; i < length; i += size) {
      chunks.add(sublist(i, i + size > length ? length : i + size));
    }
    return chunks;
  }
}

extension DateTimeExtensions on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isPast => isBefore(DateTime.now());

  bool get isFuture => isAfter(DateTime.now());

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    }
    if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    }
    if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    }
    if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    }
    if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    }
    return 'Just now';
  }
}

extension WidgetExtensions on Widget {
  Widget paddingAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) =>
      Padding(
          padding:
              EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
          child: this);

  Widget visible(bool condition) => condition ? this : const SizedBox.shrink();

  Widget withTooltip(String message) => Tooltip(message: message, child: this);

  Widget get expanded => Expanded(child: this);

  Widget get flexible => Flexible(child: this);
}
