import 'dart:async';
import 'package:flutter/services.dart';

// Note: Requires flutter_hooks package if used in widgets
// These are logic-only "hooks" or utility managers from the hybrid core.

class TimerManager {
  Timer? _timer;
  final StreamController<int> _controller = StreamController<int>.broadcast();

  Stream<int> get tick => _controller.stream;

  void start(int seconds) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timer.tick >= seconds) {
        timer.cancel();
      }
      _controller.add(seconds - timer.tick);
    });
  }

  void stop() {
    _timer?.cancel();
  }

  void dispose() {
    _timer?.cancel();
    _controller.close();
  }
}

class ClipboardManager {
  static Future<void> copy(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }
}
