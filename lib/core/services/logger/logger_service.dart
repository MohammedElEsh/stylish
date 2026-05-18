import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LoggerService {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
    ),
  );

  /// Debug logs
  static void d(String message, {String? tag}) {
    if (!_enabled) return;
    _logger.d(_format(message, tag));
  }

  /// Info logs
  static void i(String message, {String? tag}) {
    if (!_enabled) return;
    _logger.i(_format(message, tag));
  }

  /// Warning logs
  static void w(String message, {String? tag}) {
    if (!_enabled) return;
    _logger.w(_format(message, tag));
  }

  /// Error logs
  static void e(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
    String? tag,
  ]) {
    if (!_enabled) return;

    _logger.e(
      _format(message, tag),
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Format logs
  static String _format(String message, String? tag) {
    if (tag == null) return message;
    return '[$tag] $message';
  }

  /// Disable logs in production
  static bool get _enabled => kDebugMode;
}
