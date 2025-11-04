import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/model/book.dart';
import '../../../../core/usecase/usecase.dart';

import '../repository/home_repository.dart';

class GetBooks implements Usecase<List<Book>, GetBooksParams> {
  final HomeRepository _homeRepository;

  GetBooks({required HomeRepository homeRepository})
    : _homeRepository = homeRepository;

  @override
  Future<Either<Failure, List<Book>>> call(GetBooksParams params) async {
    return await _homeRepository.getBooks(params.query);
  }
}

final class GetBooksParams {
  final String query;

  GetBooksParams({required this.query});
}
