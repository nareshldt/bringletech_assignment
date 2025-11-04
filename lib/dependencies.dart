import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  _initDio();
}

void _initDio() {
  final dio = Dio().options = BaseOptions(
    baseUrl: 'https://www.googleapis.com',
    connectTimeout: const Duration(seconds: 120),
    receiveTimeout: const Duration(seconds: 120),
    sendTimeout: const Duration(seconds: 120),
    headers: {'Content-Type': 'application/json'},
  );

  getIt.registerLazySingleton(() => dio);
}
