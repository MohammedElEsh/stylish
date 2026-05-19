import 'package:flutter/material.dart';

import '../di/injection.dart';
import '../services/connectivity/connectivity_service.dart';
import '../shared/feedback/offline_banner.dart';

class ConnectivityWrapper extends StatelessWidget {
  final Widget? child;

  const ConnectivityWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: sl<ConnectivityService>().onConnectivityChanged,
      initialData: sl<ConnectivityService>().currentStatus,
      builder: (context, snapshot) {
        final offline = snapshot.data == false;

        return Stack(
          children: [
            child ?? const SizedBox.shrink(),
            if (offline)
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: OfflineBanner(),
              ),
          ],
        );
      },
    );
  }
}
