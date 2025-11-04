import 'package:dio/dio.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/model/book.dart';

abstract interface class HomeRemoteDatasource {
  Future<List<Book>> getBooks(String query);
}

class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  final Dio _dio;

  HomeRemoteDatasourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<List<Book>> getBooks(String query) async {
    try {
      final response = await _dio.get(
        '/books/v1/volumes',
        queryParameters: {'q': query},
      );

      final decodedBody = response.data;

      final List<Book> books = (decodedBody['items'] as List).map((bookInfo) {
        return Book.fromMap(bookInfo);
      }).toList();

      return books;
    } catch (error) {
      if (error is DioException) {
        throw handleDioException(error);
      }

      throw AppException(
        message: 'An unexpected error occurred while fetching homework details',
      );
    }
  }
}
