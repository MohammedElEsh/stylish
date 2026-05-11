import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../network/dio_client.dart';
import '../services/connectivity/connectivity_service.dart';
import '../services/media/media_service.dart';
import '../services/storage/secure_storage_service.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton<SecureStorageService>(
      () => SecureStorageServiceImpl());

  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<ConnectivityService>(
      () => ConnectivityServiceImpl(sl()));

  sl.registerLazySingleton<MediaService>(() => MediaServiceImpl());

  sl.registerLazySingleton<Dio>(() => DioClient.dio);

  // Features
  // Register feature-specific data sources, repositories, and view models here
}
