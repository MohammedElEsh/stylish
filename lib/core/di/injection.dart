import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/onboarding/presentation/manager/onboarding_cubit.dart';
import '../networking/api_consumer.dart';
import '../networking/dio_consumer.dart';
import '../services/connectivity/connectivity_service.dart';
import '../services/media/media_service.dart';
import '../services/session/session_manager.dart';
import '../services/storage/secure_storage_service.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);

  sl.registerLazySingleton<SecureStorageService>(
      () => SecureStorageServiceImpl());

  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<ConnectivityService>(
      () => ConnectivityServiceImpl(sl()));

  sl.registerLazySingleton<MediaService>(() => MediaServiceImpl());

  sl.registerLazySingleton<DioConsumer>(
      () => DioConsumer(dio: Dio(), secureStorage: sl()));
  sl.registerLazySingleton<ApiConsumer>(() => sl<DioConsumer>());

  sl.registerLazySingleton<SessionManager>(() => SessionManager(sl(), sl()));

  sl.registerFactory<OnboardingCubit>(() => OnboardingCubit(sl()));
}
