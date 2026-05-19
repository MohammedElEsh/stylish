import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectivityService {
  Future<bool> get isConnected;
  Stream<bool> get onConnectivityChanged;
  bool get currentStatus;
}

class ConnectivityServiceImpl implements ConnectivityService {
  final Connectivity _connectivity;
  final _controller = StreamController<bool>.broadcast();
  bool _lastStatus = true;
  Timer? _debounce;

  ConnectivityServiceImpl(this._connectivity) {
    _connectivity.onConnectivityChanged.listen(_onConnectivityEvent);
  }

  @override
  bool get currentStatus => _lastStatus;

  @override
  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }

  @override
  Stream<bool> get onConnectivityChanged => _controller.stream;

  void _onConnectivityEvent(List<ConnectivityResult> results) {
    final connected = !results.contains(ConnectivityResult.none);

    if (connected == _lastStatus) return;

    _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      _lastStatus = connected;
      _controller.add(connected);
    });
  }

  void dispose() {
    _debounce?.cancel();
    _controller.close();
  }
}
