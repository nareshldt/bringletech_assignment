import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/model/book.dart';
import '../../domain/repository/home_repository.dart';
import '../datasource/home_remote_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasource _homeRemoteDatasource;

  HomeRepositoryImpl({required HomeRemoteDatasource homeRemoteDatasource})
    : _homeRemoteDatasource = homeRemoteDatasource;

  @override
  Future<Either<Failure, List<Book>>> getBooks(String query) async {
    try {
      final books = await _homeRemoteDatasource.getBooks(query);

      return right(books);
    } catch (error) {
      if (error is AppException) {
        return left(
          Failure(statusCode: error.statusCode, message: error.message),
        );
      }

      return left(Failure(message: 'An unexpected error occurred'));
    }
  }
}
