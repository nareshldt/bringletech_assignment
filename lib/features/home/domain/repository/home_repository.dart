import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/model/book.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, List<Book>>> getBooks(String query);
}
