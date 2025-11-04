part of 'searched_books_bloc.dart';

@immutable
sealed class SearchedBooksEvent {}

final class SearchBooksEvent extends SearchedBooksEvent {
  final String query;

  SearchBooksEvent(this.query);
}
