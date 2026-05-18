import 'package:flutter/material.dart';

extension StringExtensions on String {
  String get capitalize =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';
  bool get isValidEmail =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  bool get isValidPassword => length >= 6;

  String get hardcoded =>
      this; // For easy identification of non-localized strings
}

extension NumExtensions on num {
  Widget get verticalSpace => SizedBox(height: toDouble());
  Widget get horizontalSpace => SizedBox(width: toDouble());
}

extension ListExtensions<T> on List<T> {
  T? get firstOrNull => isNotEmpty ? first : null;
  List<T> separated(T separator) {
    if (isEmpty) return [];
    final result = <T>[];
    for (var i = 0; i < length; i++) {
      result.add(this[i]);
      if (i != length - 1) result.add(separator);
    }
    return result;
  }
}

extension DateTimeExtensions on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
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
}
