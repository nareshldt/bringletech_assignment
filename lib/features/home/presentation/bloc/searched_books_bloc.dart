import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/model/book.dart';
import '../../domain/usecase/get_books.dart';

part 'searched_books_event.dart';
part 'searched_books_state.dart';

class SearchedBooksBloc extends Bloc<SearchedBooksEvent, SearchedBooksState> {
  final GetBooks _getBooks;

  SearchedBooksBloc({required GetBooks getBooks})
    : _getBooks = getBooks,
      super(SearchedBooksInitial()) {
    on<SearchBooksEvent>(_onSearchBooks);
  }

  Future<void> _onSearchBooks(
    SearchBooksEvent event,
    Emitter<SearchedBooksState> emit,
  ) async {
    final res = await _getBooks(GetBooksParams(query: event.query));

    res.fold(
      (failure) => emit(
        SearchedBooksFailure.fromPrevState(
          state,
          statusCode: failure.statusCode,
          message: failure.message,
        ),
      ),
      (books) {
        final List<Book> newState = [];

        if (books.isNotEmpty) {
          newState.addAll(books);
        }

        emit(SearchedBooksSuccess(books: newState));
      },
    );
  }
}
