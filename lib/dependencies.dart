import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import './features/home/data/datasource/home_remote_datasource.dart';
import './features/home/domain/repository/home_repository.dart';
import './features/home/data/repository/home_repository_impl.dart';
import './features/home/domain/usecase/get_books.dart';
import './features/home/presentation/bloc/searched_books_bloc.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  _initDio();

  _initHome();
}

void _initDio() {
  final dio = Dio()
    ..options = BaseOptions(
      baseUrl: 'https://www.googleapis.com',
      connectTimeout: const Duration(seconds: 120),
      receiveTimeout: const Duration(seconds: 120),
      sendTimeout: const Duration(seconds: 120),
      headers: {'Content-Type': 'application/json'},
    );

  getIt.registerLazySingleton(() => dio);
}

void _initHome() {
  getIt.registerFactory<HomeRemoteDatasource>(
    () => HomeRemoteDatasourceImpl(dio: getIt<Dio>()),
  );

  getIt.registerFactory<HomeRepository>(
    () =>
        HomeRepositoryImpl(homeRemoteDatasource: getIt<HomeRemoteDatasource>()),
  );

  getIt.registerFactory<GetBooks>(
    () => GetBooks(homeRepository: getIt<HomeRepository>()),
  );

  getIt.registerLazySingleton(
    () => SearchedBooksBloc(getBooks: getIt<GetBooks>()),
  );
}
