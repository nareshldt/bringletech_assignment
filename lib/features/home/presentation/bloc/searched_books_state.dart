part of 'searched_books_bloc.dart';

@immutable
sealed class SearchedBooksState {
  final List<Book>? books;

  const SearchedBooksState({this.books});
}

final class SearchedBooksInitial extends SearchedBooksState {
  const SearchedBooksInitial() : super(books: null);
}

final class SearchedBooksLoading extends SearchedBooksState {
  const SearchedBooksLoading({super.books});

  SearchedBooksLoading.fromPrevState(SearchedBooksState state)
    : super(books: state.books);
}

final class SearchedBooksSuccess extends SearchedBooksState {
  const SearchedBooksSuccess({required super.books});
}

final class SearchedBooksFailure extends SearchedBooksState {
  final int? statusCode;
  final String message;

  const SearchedBooksFailure({
    this.statusCode,
    required this.message,
    super.books,
  });

  SearchedBooksFailure.fromPrevState(
    SearchedBooksState state, {
    this.statusCode,
    required this.message,
  }) : super(books: state.books);
}
