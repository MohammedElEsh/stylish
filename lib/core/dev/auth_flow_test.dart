import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../di/injection.dart';
import '../networking/api_consumer.dart';
import '../networking/api_endpoints.dart';
import '../services/logger/logger_service.dart';

/// Dev-only screen used to manually exercise the auth/refresh flow after
/// a successful login. Replaces [HomeView] during development.
class AuthFlowTest extends StatelessWidget {
  const AuthFlowTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth Flow Test'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _testProfileRequest,
          child: const Text('Test Profile Request'),
        ),
      ),
    );
  }

  Future<void> _testProfileRequest() async {
    LoggerService.i(
      'Profile request started',
      tag: 'AuthFlowTest',
    );

    try {
      final response = await sl<ApiConsumer>().get(
        ApiEndpoints.profile,
      );

      LoggerService.json(
        response is Map<String, dynamic> ? response : {'data': response},
        tag: 'AuthFlowTest/Profile',
      );

      LoggerService.i(
        'Profile request succeeded',
        tag: 'AuthFlowTest',
      );
    } on DioException catch (e, st) {
      LoggerService.e(
        'Profile request failed (${e.response?.statusCode})',
        error: e,
        stackTrace: st,
        tag: 'AuthFlowTest',
      );
    } catch (e, st) {
      LoggerService.e(
        'Profile request crashed',
        error: e,
        stackTrace: st,
        tag: 'AuthFlowTest',
      );
    }
  }
}
